//
//  MeViewController.m
//  DaXueSen
//
//  Created by zhangmin on 14-11-3.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "MeViewController.h"
#import "MWPhotoBrowser.h"
#import "HttpUtil.h"
#import "MBProgressHUD.h"
#import "Photo.h"
#import "Config.h"
@interface MeViewController ()<RequestResultDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate>
@property(nonatomic,strong)Userinfo*userInfo;
@property(nonatomic,assign)BOOL isLogin;
@property(nonatomic,strong)NSArray*images;
@property(nonatomic,strong)NSMutableArray*photos;
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isLogin=[[Config instance]isLogin];
    if(_isLogin==YES){
        _userInfo=[[Config instance] getUserInfo];
        _viewUserImages.delegate=self;
        _viewUserImages.dataSource=self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _viewHeadImage.clipsToBounds=YES;
        _viewHeadImage.layer.cornerRadius=50;
        NSString *url=[NSString stringWithFormat:URL_GET_MY_INFO,HOST,_userInfo.user_id];
        [[HttpUtil getHttpUtil]httpGetWithUrl:url andName:@"myInfo" andRequestResultDelegate:self];

    }else{ //未登录  切换到未登录界面
        
    }
}
-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if([requestName isEqualToString:@"myInfo"]){
        if(msg.code==1024){
            Userinfo*user=[Userinfo dirToObj:msg.result];
            if(user){
                NSString *headImageUrl=[NSString stringWithFormat:@"%@/%@",HOST,user.user_head_image_url];
                [[HttpUtil getHttpUtil]httpDownLoadImageWithUrl:headImageUrl andDisplatImageView:_viewHeadImage andErrorImageName:@"photo.png" showProgress:NO];
                _viewUserNickName.text=user.user_nick_name;
                [_viewdynamicCount setTitle:[NSString stringWithFormat:@"动态    %d",user.user_dynamic_count] forState:UIControlStateNormal];
                [_viewAttentionCount setTitle:[NSString stringWithFormat:@"关注    %d",user.user_attention_count] forState:UIControlStateNormal];
                [_viewFancCount setTitle:[NSString stringWithFormat:@"粉丝    %d",user.user_fans_count] forState:UIControlStateNormal];
                if(user.photos.count>0){
                    _images=user.photos;
                    [_viewUserImages reloadData];
                }
            }else{
                
            }
        }else{
            NSLog(@"request get myinfo error: code=%ld,message=%@",(long)msg.code,msg.message);
        }
    }
}
-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
//tag 0 dynamicCount 1 attention count 2 fanc count 3 my comment 4 my praises 5 setting
- (IBAction)btnClick:(id)sender {
    
}

#pragma mark -collection view datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images?_images.count:0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId=@"my_info_images_cell";
    UICollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 65,80)];
    [cell addSubview:imageView];
    NSString*imageUrl=[[NSString alloc]initWithFormat:@"%@/%@",HOST,[[_images objectAtIndex:indexPath.row] valueForKey:@"photo_image_small_url"]];
    [[HttpUtil getHttpUtil]httpDownLoadImageWithUrl:imageUrl andDisplatImageView:imageView andErrorImageName:@"pictures_no.png" showProgress:NO];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _photos=[NSMutableArray array];
    for(Photo *photo in _images){
        NSString*url=[[NSString alloc]initWithFormat:@"%@/%@",HOST,photo.photo_image_url];
        [_photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:url]]];
    }
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
    
    // Optionally set the current visible photo before displaying
    [browser setCurrentPhotoIndex:indexPath.row];
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
    
    // Manipulate
    [browser showNextPhotoAnimated:YES];
    [browser showPreviousPhotoAnimated:YES];
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
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
