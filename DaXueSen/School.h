//
//  School.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Jastor.h"

@interface School : Jastor
@property(nonatomic) int school_id ;
@property(nonatomic,strong) NSString* school_name ;
@property(nonatomic) int school_city_id ;
@property(nonatomic,strong) NSString* school_jwxt_url ;

@end
