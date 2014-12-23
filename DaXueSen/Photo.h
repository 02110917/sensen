//
//  Photo.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "Jastor.h"

@interface Photo : Jastor
@property(nonatomic) long photo_id ;
@property(nonatomic) long photo_user_id ;
@property(nonatomic,strong) NSString* photo_image_url ;
@property(nonatomic,strong) NSString* photo_image_small_url ;
@property(nonatomic,strong) NSDate* photo_upload_time ;
@end
