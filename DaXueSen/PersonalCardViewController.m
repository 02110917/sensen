//
//  PersonalCardViewController.m
//  DaXueSen
//
//  Created by administrator on 14/12/26.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "PersonalCardViewController.h"
#import "MWPhotoBrowser.h"
#import "HttpUtil.h"
#import "MBProgressHUD.h"
#import "Photo.h"
#import "Userinfo.h"
@interface PersonalCardViewController ()<RequestResultDelegate,UICollectionViewDelegate,UICollectionViewDataSource,MWPhotoBrowserDelegate>
@property(nonatomic,strong)NSArray*images;
@property(nonatomic,strong)NSMutableArray*photos;
@end

@implementation PersonalCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _viewHeadImage.clipsToBounds=YES;
    _viewHeadImage.layer.cornerRadius=30;
    _viewImages.dataSource=self;
    _viewImages.delegate=self;
    NSString*url=[[NSString alloc]initWithFormat:URL_GET_USER_INFO,HOST,self.userId];
    [[HttpUtil getHttpUtil]httpGetWithUrl:url andName:@"get_user_info" andRequestResultDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -Request Result Delegate 

-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    if([requestName isEqualToString:@"get_user_info"]){
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        if(msg.code==1024){
            Userinfo*userInfo=[Userinfo dirToObj:msg.result];
            if(userInfo){
                NSString*headImageUrl=[[NSString alloc]initWithFormat:@"%@/%@",HOST,userInfo.user_head_image_url];
                [[HttpUtil getHttpUtil]httpDownLoadImageWithUrl:headImageUrl andDisplatImageView:self.viewHeadImage andErrorImageName:@"photo.png" showProgress:NO];
                self.viewNickname.text=userInfo.user_nick_name;
                
                [self.viewUserame setTitle:[[NSString alloc]initWithFormat:@"    昵称    %@",userInfo.user_nick_name] forState:UIControlStateNormal];
                [self.viewUserSex setTitle:[[NSString alloc]initWithFormat:@"    性别    %@",userInfo.user_sex==0?@"男":@"女"]forState:UIControlStateNormal];
                [self.viewUserCity setTitle:[[NSString alloc]initWithFormat:@"    城市    %@ %@",userInfo.province_name,userInfo.city_name] forState:UIControlStateNormal];
                [self.viewUserSchool setTitle:[[NSString alloc]initWithFormat:@"    学校    %@",userInfo.school_name] forState:UIControlStateNormal];
                [self.viewUserhobby setTitle:[[NSString alloc]initWithFormat:@"    兴趣爱好    %@",userInfo.user_hobbies] forState:UIControlStateNormal];
                _images=userInfo.photos;
                if(_images&&_images.count>0){
                    [_viewImages reloadData];
                }
            }
        }else{
            
        }
    }
}
-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark -collection view datasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images?_images.count:0;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId=@"personal_card_images_cell";
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
