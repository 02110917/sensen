//
//  Util.h
//  DaXueSen
//
//  Created by administrator on 14/12/24.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Util : NSObject
+(NSString*)base64Decode:(NSString*)input; //base64解码
+(NSString*)base64Encode:(NSString*)input; //base64编码
+(NSString*)savaImageToDocument:(UIImage*)image WithName:(NSString*)fileName;
+(NSString*)documentFolderPath;
+(NSString*)getImagePathWithName:(NSString*)imageName;
@end
