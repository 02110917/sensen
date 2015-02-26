//
//  MeViewController.h
//  DaXueSen
//
//  Created by zhangmin on 14-11-3.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "ViewController.h"

@interface MeViewController : ViewController
@property (weak, nonatomic) IBOutlet UIImageView *viewHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *viewUserNickName;
@property (weak, nonatomic) IBOutlet UIButton *viewdynamicCount;
@property (weak, nonatomic) IBOutlet UIButton *viewAttentionCount;
@property (weak, nonatomic) IBOutlet UIButton *viewFancCount;
@property (weak, nonatomic) IBOutlet UICollectionView *viewUserImages;

@end
