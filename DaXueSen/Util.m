//
//  Util.m
//  DaXueSen
//
//  Created by administrator on 14/12/24.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Util.h"
#import "GTMBase64.h"
@implementation Util
+(NSString*)base64Encode:(NSString *)input{
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
+(NSString*)base64Decode:(NSString *)input{
    NSData *data =[GTMBase64 decodeString:input];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
@end
