//
//  Config.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-28.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Config.h"
@interface Config()
@property(nonatomic,strong) NSUserDefaults *defaults;
@end
@implementation Config

static Config * instance = nil;
+(Config *) instance
{
    @synchronized(self)
    {
        if(nil == instance)
        {
            instance=[self new];
            instance.defaults=[NSUserDefaults standardUserDefaults];
        }
    }
    return instance;
}
-(BOOL)isLogin{
    return [self.defaults boolForKey:@"isLogin"];
}
-(void)setLogin:(BOOL)isLogin{
    [self.defaults setBool:isLogin forKey:@"isLogin"];
    [self.defaults synchronize];
}
-(void)setUserInfo:(Userinfo *)userInfo{
    [self.defaults setInteger:userInfo.user_id forKey:@"userId"];
    [self.defaults setObject:userInfo.user_nick_name forKey:@"userNickName"];
    [self.defaults setObject:userInfo.user_head_image_url forKey:@"userHeadImageUrl"];
    [self.defaults synchronize];
}
-(Userinfo*)getUserInfo{
    Userinfo*userInfo=[[Userinfo alloc]init];
    userInfo.user_id=[self.defaults integerForKey:@"userId"];
    userInfo.user_nick_name=[self.defaults objectForKey:@"userNickName"];
    userInfo.user_head_image_url=[self.defaults objectForKey:@"userHeadImageUrl"];
    return userInfo;
}
-(void)saveUserLoginIWithPhone:(NSString *)phone andPsd:(NSString *)psd{
    [self.defaults setObject:phone  forKey:@"loginPhone"];
    [self.defaults setObject:psd forKey:@"loginPsd"];
    [self.defaults synchronize];
}
-(NSString*)readUserLoginPhone{
    return [self.defaults objectForKey:@"loginPhone"];
}
-(NSString*)readUserLoginPsd{
    return [self.defaults objectForKey:@"loginPsd"];
}
@end
