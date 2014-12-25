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
#import <SDWebImage/UIImageView+WebCache.h>
@implementation MainTableViewCell

- (void)awakeFromNib {
    // Initialization code

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
        UIImageView *iv=(UIImageView*)[cell viewWithTag:1];
        Image *image=[self.imageUrls objectAtIndex:rowNo];
        NSString *imageUrl=[NSString stringWithFormat:@"%@/%@",HOST,image.image_small_url];
        iv.image=[UIImage imageNamed: @"pictures_no.png"];
        [[SDWebImageManager sharedManager] downloadWithURL:[NSURL URLWithString:imageUrl] options:SDWebImageLowPriority progress:nil completed:^(UIImage *aImage, NSError *error, SDImageCacheType cacheType, BOOL finished) {
            iv.image = aImage;
            // NSLog(@"成功了:%d",UIImageJPEGRepresentation(aImage, 1).length);
        }];
    }
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(!self.imageUrls)
        return 0;
    return self.imageUrls.count;
}


@end
