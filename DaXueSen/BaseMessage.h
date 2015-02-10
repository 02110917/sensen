//
//  BaseMessage.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Jastor.h"

@interface BaseMessage : Jastor
@property(nonatomic,assign) NSInteger code ;
@property(nonatomic,strong) NSString* message ;
@property(nonatomic,strong) id result ;
+(BaseMessage *)jsonDataToObj:(NSData *)data;
@end
