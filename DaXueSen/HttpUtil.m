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
#import <SDWebImage/UIImageView+WebCache.h>
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
-(void)httpGetWithUrl:(NSString *)url andRequestResultDelegate:(id)delegate{
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[[NSURL alloc]initWithString:url]];
    [request setDelegate:delegate];
    [request setUseCookiePersistence : YES ];
    [request setTimeOutSeconds:TIME_OUT];
    [request startAsynchronous];
}
-(void)httpGetWithUrl:(NSString *)url andRequestSuccessBlock:(RequestSuccess)success andFiledBlock:(RequestFail)failed{
    ASIHTTPRequest*request=[ASIHTTPRequest requestWithURL:[[NSURL alloc]initWithString:url]];
    __weak typeof(ASIHTTPRequest*) weakRequest=request;
    [request setCompletionBlock:^{
        success([weakRequest responseData]);
    }];
    [request setFailedBlock:^{
        failed([weakRequest error].description);
    }];
    [request setUseCookiePersistence : YES ];
    [request setTimeOutSeconds:TIME_OUT];
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
    [requestForm addRequestHeader:@"Content-Type" value:@"multipart/form-data"];
    [requestForm setDelegate:self];
    [ requestForm setUseCookiePersistence : YES ];
    [requestForm setName:name];
    [requestForm setTimeOutSeconds:TIME_OUT];
    [requestForm startAsynchronous];
}
-(void)httpDownLoadImageWithUrl:(NSString *)url andSuccessBlock:(void (^)(UIImage *))success andFailedBlock:(void (^)(NSError *))failed{
    [self httpDownLoadImageWithUrl:url andSuccessBlock:success andProgressBlock:nil andFailedBlock:failed];
}
-(void)httpDownLoadImageWithUrl:(NSString *)url andSuccessBlock:(void (^)(UIImage *))success andProgressBlock:(void (^)(float))progress andFailedBlock:(void (^)(NSError *))failed{
    NSURL*u=[[NSURL alloc]initWithString:url];
    [[SDWebImageManager sharedManager] downloadWithURL:u options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize){
        if(progress){
            progress(receivedSize*0.1/expectedSize);
        }
    } completed:^(UIImage *aImage, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        if(error){
            failed(error);
        }else{
            success(aImage);
        }
    }];
}
-(void)httpDownLoadImageWithUrl:(NSString *)url andDisplatImageView:(UIImageView *)imageView andErrorImageName:(NSString*)defaultImage showProgress:(BOOL)isShowProgress{
    [self httpDownLoadImageWithUrl:url andSuccessBlock:^(UIImage* image){
        imageView.image=image;
    } andProgressBlock:^(float progress){
        if(isShowProgress){
            
        }
    }andFailedBlock:^(NSError *error){
        UIImage *image=[UIImage imageNamed:defaultImage];
        imageView.image=image;
    }];
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
