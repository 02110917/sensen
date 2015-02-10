//
//  HttpUtil.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseMessage.h"
typedef void(^RequestSuccess) (NSData*);  //Http请求成功block
typedef void(^RequestFail)(NSString*); //Http请求失败block
#define TIME_OUT 30

//#define HOST @"http://182.92.229.130/"
//#define HOST @"http://localhost/"
#define HOST @"http://172.20.10.3/"
#define URL_LOGIN @"%@index.php/Home/user/login?user=%@&psd=%@"
#define URL_REGISTE_1 @"%@index.php/Home/user/registe?user_phone=%@&user_password=%@"
#define URL_REGISTE_2 @"%@index.php/Home/user/registeCodeCheck?phone=%@&code=%@"
#define URL_CHANGE_USER_INFO @"%@index.php/Home/user/registeInputInfo"
#define URL_GET_CONTENT @"%@index.php/Home/content/getContent?type=%d&page=%d&size=%d"
#define URL_PUB_CONTENT @"%@index.php/Home/content/pubContent"
#define URL_GET_USER_INFO @"%@index.php/Home/user/getUserInfo?userId=%ld"
#define URL_LOCATION @"%@index.php/Home/Location/location?lat=%f&lng=%f"
@protocol RequestResultDelegate;
@interface HttpUtil : NSObject
@property(nonatomic, assign) id<RequestResultDelegate> delegate ;
+(HttpUtil*)getHttpUtil;

-(void) httpGetWithUrl:(NSString*)url andName:(NSString*)name andRequestResultDelegate:(id<RequestResultDelegate>)delegate;
-(void)httpGetWithUrl:(NSString *)url andRequestResultDelegate:(id)delegate;
-(void) httpPostWithUrl:(NSString*)url andName:(NSString*)name andParams:(NSMutableDictionary*)params andRequestResultDelegate:(id<RequestResultDelegate>)delegate;
-(void) httpPostWithUrl:(NSString*)url andName:(NSString*)name andParams:(NSMutableDictionary*)params andFiles:(NSMutableDictionary*)files  andRequestResultDelegate:(id<RequestResultDelegate>)delegate;
-(void) httpGetWithUrl:(NSString*)url andRequestSuccessBlock:(RequestSuccess)success andFiledBlock:(RequestFail)failed;
-(void) httpDownLoadImageWithUrl:(NSString*)url andSuccessBlock:(void(^)(UIImage *aImage))success andFailedBlock:(void(^)(NSError*))failed;
-(void) httpDownLoadImageWithUrl:(NSString*)url andSuccessBlock:(void(^)(UIImage *aImage))success andProgressBlock:(void(^)(float))progress andFailedBlock:(void(^)(NSError*))failed;
-(void)httpDownLoadImageWithUrl:(NSString*)url andDisplatImageView:(UIImageView*)imageView andErrorImageName:(NSString*)defaultImage showProgress:(BOOL)isShowProgress;
@end
@protocol RequestResultDelegate <NSObject>
@required
-(void)requestSuccess:(NSString*)requestName andResult:(BaseMessage*)msg ;
-(void)requestFail:(NSString*)requestName andError:(NSString*)error ;

@end