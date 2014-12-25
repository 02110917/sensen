//
//  PubContentControllerViewController.m
//  DaXueSen
//
//  Created by administrator on 14/12/25.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "PubContentController.h"
#import <CoreLocation/CLLocationManager.h>
#import "HttpUtil.h"
#import "ASIHTTPRequest.h"
@interface PubContentController ()<CLLocationManagerDelegate,ASIHTTPRequestDelegate>
@property(nonatomic,strong)UIActionSheet *actionSheet;
@property(nonatomic,strong)CLLocationManager *locationManager ;
@end

@implementation PubContentController

- (void)viewDidLoad {
    [super viewDidLoad];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
