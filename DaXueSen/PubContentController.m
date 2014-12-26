//
//  PubContentControllerViewController.m
//  DaXueSen
//
//  Created by administrator on 14/12/25.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "PubContentController.h"
#import <CoreLocation/CLLocationManager.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "HttpUtil.h"
#import "ASIHTTPRequest.h"
#import "Config.h"
#import "Util.h"
@interface PubContentController ()<CLLocationManagerDelegate,ASIHTTPRequestDelegate,RequestResultDelegate>
@property(nonatomic,strong)UIActionSheet *actionSheet;
@property(nonatomic,strong)CLLocationManager *locationManager ;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic)CGFloat screenWidth;
@property(nonatomic,strong)NSMutableArray*imagesArray;
//@property (nonatomic,strong)ALAssetsLibrary *specialLibrary;
@end

@implementation PubContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imagesArray=[NSMutableArray new];
    _screenWidth=[UIScreen mainScreen].applicationFrame.size.width;
    UIImageView* addImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    addImage.image=[UIImage imageNamed:@"add_images.png"];
    [_mViewAddImageBtn addSubview:addImage];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 80, 20)];
    label.text=@"添加照片";
    [_mViewAddImageBtn addSubview:label];
    _actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
    if([CLLocationManager locationServicesEnabled]){
        //location
        _locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDelegate:self];
        //要求CLLocationManager对象返回全部结果
//        [locationManager setDistanceFilter:kCLDistanceFilterNone];
        //要求CLLocationManager对象的返回结果尽可能的精准
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //要求CLLocationManager对象开始工作，定位设备位置
        if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
            [_locationManager requestWhenInUseAuthorization];
        }
        else
        {
            [_locationManager startUpdatingLocation];
        }
    }else{
        NSLog(@"%s","不允许定位");
    }
    
}
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status==kCLAuthorizationStatusAuthorizedWhenInUse){
        [_locationManager startUpdatingLocation];
    }
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
     CLLocation *loc = [locations objectAtIndex:0];
    [[HttpUtil getHttpUtil]httpGetWithUrl:[[NSString alloc]initWithFormat:@"http://apis.map.qq.com/ws/geocoder/v1?location=%f,%f&coord_type=1&get_poi=1&key=3ODBZ-QIIH5-K5SIF-QYM5F-7Y6G2-FYBSK&output=json",loc.coordinate.latitude,loc.coordinate.longitude] andRequestResultDelegate:self];
    
    [_locationManager stopUpdatingLocation];//3ODBZ-QIIH5-K5SIF-QYM5F-7Y6G2-FYBSK
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){ //手机相册
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        
        elcPicker.maximumImagesCount = 100; //Set the maximum number of images to select to 100
        elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
        elcPicker.returnsImage = NO; //Return UIimage if YES. If NO, only return asset location information
        elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
        elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types //, (NSString *)kUTTypeMovie
        
        elcPicker.imagePickerDelegate = self;
        
        [self presentViewController:elcPicker animated:YES completion:nil];
    }else{ //拍照
        
    }
}
#pragma mark Select images from photo delegate
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    if(info&&info.count>0){
        NSUInteger size=info.count+1;
        CGRect rect=_mViewAddImageBtn.frame;
        CGFloat d=(rect.size.width-30)/4.0;
        CGFloat h=(size/4+1)*(d+10)-10;
        _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, h)];
        _scrollView.directionalLockEnabled = YES; //只能一个方向滑动
        _scrollView.pagingEnabled = NO; //是否翻页
        _scrollView.showsVerticalScrollIndicator =YES; //垂直方向的滚动指示
        _scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite;//滚动指示的风格
        _scrollView.showsHorizontalScrollIndicator = NO;//水平方向的滚动指示
        _scrollView.contentSize=CGSizeMake(rect.size.width, h);
        _mViewAddImageBtn.hidden=YES;
        NSUInteger i=0;
        
        for(NSDictionary *dic in info){
            NSURL*imageUrl=[dic objectForKey:UIImagePickerControllerReferenceURL];
            ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
            [assetLibrary assetForURL:imageUrl resultBlock:^(ALAsset *asset) {
                ALAssetRepresentation *rep = [asset defaultRepresentation];
                Byte *buffer = (Byte*)malloc(rep.size);
                NSUInteger buffered = [rep getBytes:buffer fromOffset:0.0 length:rep.size error:nil];
                NSData *data = [NSData dataWithBytesNoCopy:buffer length:buffered freeWhenDone:YES];
                UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(i%4*d+10*(i%4), (i/4)*d+(i/4)*10, d, d)];
                UIImage*image=[UIImage imageWithData:data];
                imageView.image=image;
                [_scrollView addSubview:imageView];
                [_imagesArray addObject:image];
                //[data writeToFile:photoFile atomically:YES];//you can save image later
            } failureBlock:^(NSError *err) {
                NSLog(@"Error: %@",[err localizedDescription]);
            }];
//          imgMain.image = [UIImage imageWithData:data]
            i++;
        }
//        rect=_mLabelLocation.frame;
//        _mLabelLocation.frame=CGRectMake(rect.origin.x, rect.origin.y+(h-50), rect.size.width, rect.size.height);
        _locationTopConstraint.constant=h-40;
        [_mLabelLocation updateConstraintsIfNeeded];
        UIButton* btn=[[UIButton alloc]initWithFrame:CGRectMake(i%4*d+10*(i%4), (i/4)*d+(i/4)*10, d, d)];
        [btn addTarget:self action:@selector(addImages:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"add_images.png"] forState:UIControlStateNormal];
        [_scrollView addSubview:btn];
        [self.view addSubview:_scrollView];
        [self.view bringSubviewToFront:_scrollView];
//       self.view layoutSubviews];
    }
}

/**
 * Called when image selection was cancelled, by tapping the 'Cancel' BarButtonItem.
 */
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)requestFinished:(ASIHTTPRequest *)request{
    NSData*data=[request responseData];
    NSString* str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"result:%@",str);
}
- (void)requestFailed:(ASIHTTPRequest *)request{
    
}
- (IBAction)addImages:(id)sender {
    [_actionSheet showInView:self.view];
}
#pragma mark 开始发表状态
- (IBAction)pubContentAction:(id)sender {
    Config *config=[Config instance];
    if(!config.isLogin){
        NSLog(@"%s","未登录！！");
        return;
    }
    if([_mTvInput.text isEqual:@""]){
        NSLog(@"%s","content为空！！");
        return;
    }
    NSString*content=_mTvInput.text;
    NSString*location=_mLabelLocation.text;
    NSMutableDictionary*params=[NSMutableDictionary new];
    [params setValue:content forKey:@"con_info"];
    [params setValue:location forKey:@"con_location"];
    [params setValue:[NSNumber numberWithLong:config.userInfo.user_id] forKey:@"con_user_id"];
    [params setValue:[NSNumber numberWithInt:0] forKey:@"con_type"];
    NSMutableDictionary*files=[NSMutableDictionary new];
    int i=0;
    if(_imagesArray.count>0){
        for(UIImage*image in _imagesArray){
            NSString*filePath=[Util savaImageToDocument:image WithName:[NSString stringWithFormat:@"image_%d.jpg",i]];
            [files setValue:filePath forKeyPath:[NSString stringWithFormat:@"Image_%d",i]];
            i++;
        }
    }
    [[HttpUtil getHttpUtil]httpPostWithUrl:[NSString stringWithFormat:URL_PUB_CONTENT,HOST] andName:@"pub content"  andParams:params andFiles:files andRequestResultDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    
}
-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
