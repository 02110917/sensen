//
//  BaseMessage.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "BaseMessage.h"

@implementation BaseMessage
+(BaseMessage *)jsonDataToObj:(NSData *)data{
    BaseMessage *message=nil;
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    if(dic)
    {
        message=[[BaseMessage alloc]init];
        message.code=[dic valueForKey:@"code"];
        message.message=[dic valueForKey:@"message"];
        message.result=[dic valueForKey:@"result"];
//        message=[[BaseMessage alloc]initWithDictionary:dic];
    }
    return message;
}
@end
