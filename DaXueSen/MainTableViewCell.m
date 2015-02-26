//
//  MainTableViewCell.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-29.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "MainTableViewCell.h"
#import "Image.h"
#import "HttpUtil.h"
#import "PersonalCardViewController.h"
@interface MainTableViewCell()
@property(nonatomic,strong)NSMutableArray*photos;
@end
@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _viewHeadImage.clipsToBounds=YES;
    _viewHeadImage.layer.cornerRadius=30;
    [_viewHeadImage setUserInteractionEnabled:YES];
    [_viewHeadImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCategory:)]];
}
-(void)clickCategory:(UITapGestureRecognizer *)gestureRecognizer
{
    long userId=_content.con_user_id;
    //PersonalCardViewController *personalCard = [[PersonalCardViewController alloc] initWithNibName:<#(NSString *)#> bundle:<#(NSBundle *)#>];
//    if(self.parentController&&self.parentController.navigationController)
//        [self.parentController.navigationController pushViewController:personalCard animated:YES];
    [self.parentController performSegueWithIdentifier:@"toPersonalCard" sender:self];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}
-(void)initCollectionView{
    self.viewImages.dataSource=self;
    self.viewImages.delegate=self;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString*cellId=@"squareImagecSellId";
    UICollectionViewCell*cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    //cell.layer.cornerRadius=4;
    //cell.layer.masksToBounds=YES;
    NSInteger rowNo=indexPath.row;
    if(self.imageUrls&&self.imageUrls.count>0){
        UIImageView *iv=(UIImageView*)[cell viewWithTag:11];
        Image *image=[self.imageUrls objectAtIndex:rowNo];
        NSString *imageUrl=[NSString stringWithFormat:@"%@/%@",HOST,image.image_small_url];
        iv.image=[UIImage imageNamed: @"pictupres_no.png"];
        [[HttpUtil getHttpUtil]httpDownLoadImageWithUrl:imageUrl andDisplatImageView:iv andErrorImageName:@"pictures_no.png" showProgress:NO];
    }
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(!self.imageUrls)
        return 0;
    return self.imageUrls.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.imageUrls.count==1)
        return CGSizeMake(100, 120);
    else
        return CGSizeMake(60, 70);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _photos=[NSMutableArray array];
    for(Image *image in _imageUrls){
        NSString*url=[[NSString alloc]initWithFormat:@"%@/%@",HOST,image.image_url];
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
    [self.parentController.navigationController pushViewController:browser animated:YES];
    
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
@end
