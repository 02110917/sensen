//
//  LocationPoi.h
//  DaXueSen
//
//  Created by zhangmin on 15/2/6.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Jastor.h"
@interface LocationPoi : Jastor
@property(nonatomic,strong) NSString*title;
@property(nonatomic,strong) NSString*address;
@property(nonatomic,strong) NSString*category;
@property(nonatomic,assign) float lat;
@property(nonatomic,assign) float lng;
+(NSArray*)jsonToArray:(NSArray *)json;
@end
