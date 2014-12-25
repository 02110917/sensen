//
//  HttpUtil.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-23.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "HttpUtil.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
@implementation HttpUtil
HttpUtil *http=nil;
+(HttpUtil*)getHttpUtil{
    if(!http){
        http=[[HttpUtil alloc]init];
    }
    return http;
}

-(void)httpGetWithUrl:(NSString *)url andName:(NSString*)name andRequestResultDelegate:(id<RequestResultDelegate>)delegate{
    self.delegate=delegate;
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[[NSURL alloc]initWithString:url]];
    [request setDelegate:self];
    [request setUseCookiePersistence : YES ];
    [request setTimeOutSeconds:TIME_OUT];
    [request setName:name];
    [request startAsynchronous];
}

-(void)httpPostWithUrl:(NSString *)url andName:(NSString*)name andParams:(NSMutableDictionary *)params andRequestResultDelegate:(id<RequestResultDelegate>)delegate{
    self.delegate=delegate;
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[[NSURL alloc]initWithString:url]];
    if(params&&params.count>0)
    {
        NSArray* arr = [params allKeys];
        for(NSString* str in arr)
        {
//          NSLog("%@", [params objectForKey:str]);
            [requestForm setPostValue:[params objectForKey:str] forKey:str];
        
        }
    }
    [requestForm setDelegate:self];
    [ requestForm setUseCookiePersistence : YES ];
    [requestForm setName:name];
    [requestForm setTimeOutSeconds:TIME_OUT];
    [requestForm startAsynchronous];
}
-(void)httpPostWithUrl:(NSString *)url andName:(NSString *)name andParams:(NSMutableDictionary *)params andFiles:(NSMutableDictionary *)files andRequestResultDelegate:(id<RequestResultDelegate>)delegate{
    self.delegate=delegate;
    ASIFormDataRequest *requestForm = [[ASIFormDataRequest alloc] initWithURL:[[NSURL alloc]initWithString:url]];
    if(params&&params.count>0)
    {
        NSArray* arr = [params allKeys];
        for(NSString* str in arr)
        {
            //          NSLog("%@", [params objectForKey:str]);
            [requestForm setPostValue:[params objectForKey:str] forKey:str];
            
        }
    }
    if(files&&files.count>0)
    {
        NSArray*arr=[files allKeys];
        for(NSString* str in arr){
            [requestForm setFile:[files objectForKey:str] forKey:str];
        }
    }
    [requestForm setDelegate:self];
    [ requestForm setUseCookiePersistence : YES ];
    [requestForm setName:name];
    [requestForm setTimeOutSeconds:TIME_OUT];
    [requestForm startAsynchronous];
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSData * responstDate=[request responseData];
    NSString* responseStr=[[NSString alloc] initWithData:responstDate encoding:NSUTF8StringEncoding];
//    NSLog(@"result:%@",responseStr);
    BaseMessage *msg=[BaseMessage jsonDataToObj:responstDate];
    [self.delegate requestSuccess:request.name andResult:msg];
    
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"请求发生错误： the error is %@",error);
    [self.delegate requestFail:request.name andError:error.description];
    
}

@end
