//
//  MainTableViewCell.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-29.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Content.h"
#import "MWPhotoBrowser.h"
@interface MainTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,MWPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *viewHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *viewUserName;
@property (weak, nonatomic) IBOutlet UILabel *viewData;
@property (weak, nonatomic) IBOutlet UILabel *viewContent;
@property (weak, nonatomic) IBOutlet UICollectionView *viewImages;
@property (weak, nonatomic) IBOutlet UILabel *viewLocation;
@property(strong,nonatomic)NSArray*imageUrls ;
@property(strong,nonatomic)Content*content;
@property(strong,nonatomic)UIViewController*parentController;
-(void)initCollectionView;
@end
