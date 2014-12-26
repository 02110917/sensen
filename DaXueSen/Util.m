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
+(NSString*)savaImageToDocument:(UIImage *)image WithName:(NSString *)fileName{
    NSData *data=UIImageJPEGRepresentation(image, 0.7f);
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* documentsDirectory = [paths objectAtIndex:0];
    // Now we get the full path to the file
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:fileName];
    // and then we write it out
    [data writeToFile:fullPathToFile atomically:NO];
    return fullPathToFile;
}
+(NSString *)documentFolderPath
{
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}
+(NSString*)getImagePathWithName:(NSString *)imageName{
    return [NSString stringWithFormat:@"%@/%@",[Util documentFolderPath],imageName];
}
@end
