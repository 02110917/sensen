//
//  Content.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
#import "Userinfo.h"
@interface Content : Jastor
@property(nonatomic) long con_id ;
@property(nonatomic) long con_user_id ;
@property(nonatomic,strong) NSString* con_info ;
@property(nonatomic,strong) NSString* con_voice_url ;
@property(nonatomic,strong) NSString* con_location ;
@property(nonatomic) int con_state; //状态(愿望墙)，0:未接1:已接，实现中2:已实现3:未实现
@property(nonatomic,strong) NSDate * con_pub_time ;
@property(nonatomic) int con_type ; //0:帖子 1:愿望墙
@property(nonatomic) int con_praise_count ;
@property(nonatomic) int con_comment_count ;
@property(nonatomic,strong)Userinfo*userinfo;
@property(nonatomic,strong)NSArray* images;
+(NSArray*) jsonToArray:(NSArray*)json;
@end
