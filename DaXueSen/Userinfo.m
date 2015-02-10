//
//  Userinfo.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Userinfo.h"
#import "Photo.h"
@implementation Userinfo
+(Class)photos_class{
    return [Photo class];
}
+(Userinfo *)jsonDataToObj:(NSData *)data{
    Userinfo *userinfo=nil;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if(dic)
    {
        userinfo=[[Userinfo alloc]initWithDictionary:dic];
    }
    return userinfo;
}
+(Userinfo*)dirToObj:(NSDictionary*)dic{
    Userinfo *userinfo=nil;
    if(dic)
    {
        userinfo=[[Userinfo alloc]initWithDictionary:dic];
    }
    return userinfo;
}
@end
