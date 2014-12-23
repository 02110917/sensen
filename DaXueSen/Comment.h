//
//  Comment.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Jastor.h"
#import "Userinfo.h"
@interface Comment : Jastor
@property(nonatomic) long com_id ;
@property(nonatomic) long com_con_id ;
@property(nonatomic) long com_user_id ;
@property(nonatomic,strong) Userinfo* userInfo ; //我回复的
@property(nonatomic,strong) Userinfo* userReply ; //回复给谁的
@property(nonatomic,strong) NSString* com_info ;
@property(nonatomic) long com_reply_user_id ;
@property(nonatomic,strong) NSDate* com_pub_time ;
@end
