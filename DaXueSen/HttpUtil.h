//
//  HttpUtil.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseMessage.h"
//typedef void(^RequestSuccess) (BaseMessage*);  //Http请求成功block
//typedef void(^RequestFail)(NSString*); //Http请求失败block
#define TIME_OUT 30

#define HOST @"http://182.92.229.130/"
#define URL_LOGIN @"%@index.php/Home/user/login?user=%@&psd=%@"
#define URL_GET_CONTENT @"%@index.php/Home/content/getContent?type=%d&page=%d&size=%d"
#define URL_PUB_CONTENT @"%@index.php/Home/content/pubContent"

@protocol RequestResultDelegate;
@interface HttpUtil : NSObject
@property(nonatomic, assign) id<RequestResultDelegate> delegate ;
+(HttpUtil*)getHttpUtil;

-(void) httpGetWithUrl:(NSString*)url andName:(NSString*)name andRequestResultDelegate:(id<RequestResultDelegate>)delegate;
-(void)httpGetWithUrl:(NSString *)url andRequestResultDelegate:(id)delegate;
-(void) httpPostWithUrl:(NSString*)url andName:(NSString*)name andParams:(NSMutableDictionary*)params andRequestResultDelegate:(id<RequestResultDelegate>)delegate;
-(void) httpPostWithUrl:(NSString*)url andName:(NSString*)name andParams:(NSMutableDictionary*)params andFiles:(NSMutableDictionary*)files  andRequestResultDelegate:(id<RequestResultDelegate>)delegate;


@end
@protocol RequestResultDelegate <NSObject>

-(void)requestSuccess:(NSString*)requestName andResult:(BaseMessage*)msg ;
-(void)requestFail:(NSString*)requestName andError:(NSString*)error ;

@end