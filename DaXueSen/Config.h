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
@property(nonatomic,strong,getter=getUserInfo,setter=setUserInfo:)Userinfo*userInfo;
@property(nonatomic,assign)float lat; //维度
@property(nonatomic,assign)float lng; //经度
-(BOOL)isLogin;
-(void)setLogin:(BOOL)isLogin;
-(Userinfo*)getUserInfo;
-(void)setUserInfo:(Userinfo*)userInfo;
+(Config*)instance;
-(void)saveUserLoginIWithPhone:(NSString*)phone andPsd:(NSString*) psd;
-(NSString*)readUserLoginPhone;
-(NSString*)readUserLoginPsd;

@end
