//
//  LocationPoi.m
//  DaXueSen
//
//  Created by zhangmin on 15/2/6.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "LocationPoi.h"

@implementation LocationPoi
+(NSArray*)jsonToArray:(NSArray *)json{
    NSMutableArray *array=[NSMutableArray array];
    if(json){
        for(NSDictionary*key in json){
            LocationPoi *poi=[[LocationPoi alloc]initWithDictionary:key];
            if(poi){
                [array addObject:poi];
            }
        }
    }
    return array;
}
@end
