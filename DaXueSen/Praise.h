//
//  Praise.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "Userinfo.h"
@interface Praise : Jastor
@property(nonatomic) long praise_id ;
@property(nonatomic) long praise_con_id ;
@property(nonatomic) long praise_user_id ;
@property(nonatomic,strong)Userinfo* userinfo ; //谁赞的;
@end
