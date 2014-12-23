//
//  Userinfo.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@interface Userinfo : Jastor
@property(nonatomic)long user_id ;
@property(nonatomic,strong)NSString* user_phone;
//@property(nonatomic,strong)NSString* user_password ;
@property(nonatomic,strong)NSString* user_nick_name ;
@property(nonatomic,strong)NSString* user_signature;
@property(nonatomic,strong)NSString* user_head_image_url;
@property(nonatomic,strong)NSString* user_hobbies;
@property(nonatomic) int user_sex; //0 男  1女
@property(nonatomic) int user_school_id;
@property(nonatomic) int user_score;
@property(nonatomic) int user_phone_is_verify; //0:未验证 1:已验证
@property(nonatomic) int uer_attention_count;
@property(nonatomic) int user_fans_count;
@property(nonatomic) int user_dynamic_count;
+(Userinfo *)jsonDataToObj:(NSData *)data;
+(Userinfo*)dirToObj:(NSDictionary*)dic;
@end

