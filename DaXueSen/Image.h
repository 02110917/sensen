//
//  Image.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Jastor.h"

@interface Image : Jastor
@property(nonatomic) long image_id ;
@property(nonatomic) long image_con_id ;
@property(nonatomic,strong) NSString* image_url ;
@property(nonatomic,strong) NSString* image_small_url ;
@end
