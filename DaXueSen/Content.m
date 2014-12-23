//
//  Content.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Content.h"
#import "Image.h"
@implementation Content
+(Class)images_class{
    return [Image class];
}
+(NSArray*)jsonToArray:(NSArray *)json{
    NSMutableArray *array=[NSMutableArray array];
    if(json){
        for(NSDictionary*key in json){
            Content *content=[[Content alloc]initWithDictionary:key];
            if(content){
                [array addObject:content];
            }
        }
    }
    return array;
}
@end
