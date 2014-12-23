//
//  Attention.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Userinfo.h"
@interface Attention : NSObject
@property(nonatomic) long atten_id ;
@property(nonatomic) long atten_user_id ; //谁发起的关注
@property(nonatomic) long atten_who_user_id ; //关注谁
@property(nonatomic,strong) Userinfo * userinfoAttention; //关注的
@property(nonatomic,strong) Userinfo * userinfoFans; //粉丝
@end
