//
//  PersonalCardViewController.h
//  DaXueSen
//
//  Created by administrator on 14/12/26.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalCardViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *viewHeadImage;
@property (weak, nonatomic) IBOutlet UILabel *viewNickname;
@property (weak, nonatomic) IBOutlet UIButton *viewUserame;
@property (weak, nonatomic) IBOutlet UIButton *viewUserSex;
@property (weak, nonatomic) IBOutlet UIButton *viewUserCity;
@property (weak, nonatomic) IBOutlet UIButton *viewUserSchool;
@property (weak, nonatomic) IBOutlet UIButton *viewUserhobby;
@property (weak, nonatomic) IBOutlet UICollectionView *viewImages;
@property(nonatomic,assign)long userId;
@end
