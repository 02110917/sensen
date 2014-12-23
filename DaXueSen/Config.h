//
//  Config.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-28.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Userinfo.h"
@interface Config : NSObject
@property(nonatomic,getter=isLogin,setter=setLogin:)BOOL isLogin;
@property(nonatomic,strong)Userinfo*userInfo;
-(BOOL)isLogin;
-(void)setLogin:(BOOL)isLogin;
-(Userinfo*)getUserInfo;
-(void)setUserInfo:(Userinfo*)userInfo;
+(Config*)instance;
-(void)saveUserLoginIWithPhone:(NSString*)phone andPsd:(NSString*) psd;
-(NSString*)readUserLoginPhone;
-(NSString*)readUserLoginPsd;
@end
