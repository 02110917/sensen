//
//  RegisteCheckPhoneCodeViewController.m
//  DaXueSen
//
//  Created by zhangmin on 15/2/8.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "RegisteCheckPhoneCodeViewController.h"
#import "HttpUtil.h"
#import "MBProgressHUD.h"
#import "Config.h"
@interface RegisteCheckPhoneCodeViewController ()<RequestResultDelegate>
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)int time;
@end

@implementation RegisteCheckPhoneCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _time=60;
    _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    
}
-(void)scrollTimer{
    _time--;
    if(_time==0){
        [_timer setFireDate:[NSDate distantFuture]];  //关闭定时器
        [_viewRegetCode setTitle:@"重新获取" forState:UIControlStateNormal];
        [_viewRegetCode setEnabled:YES];
        _time=60;
    }else{
        [_viewRegetCode setTitle:[[NSString alloc]initWithFormat:@"重新获取 %d",_time] forState:UIControlStateNormal];
        [_viewRegetCode setEnabled:NO];
    }
}
- (IBAction)btnClick:(id)sender {
    UIButton*btn=sender;
    if(btn.tag==0){ //重新获取验证码
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString*url=[[NSString alloc]initWithFormat:URL_REGISTE_1,HOST,_phone,_password];
        [[HttpUtil getHttpUtil]httpGetWithUrl:url andName:@"registe" andRequestResultDelegate:self];        
    }else if(btn.tag==1){ //下一步
        NSString*code=_viewInputVerifyCode.text;
        if([code isEqualToString:@""]){
            NSLog(@"验证码输入为空!!");
            return;
        }
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSString*urlCheckCode=[[NSString alloc]initWithFormat:URL_REGISTE_2,HOST,self.phone,code];
        [[HttpUtil getHttpUtil]httpGetWithUrl:urlCheckCode andName:@"checkCode" andRequestResultDelegate:self];
    }
}
-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if([requestName isEqualToString:@"registe"])
    {
        if(msg&&msg.code==1004){
            _userId=[msg.result longLongValue];
            [_timer setFireDate:[NSDate distantPast]]; //开启定时器
        }else{
            NSLog(@"registe error:%@",msg.message);
        }
    }else if([requestName isEqualToString:@"checkCode"]){
        if(msg&&msg.code==1010){
            Userinfo* userinfo=[Userinfo dirToObj:msg.result];
            Config *config=[Config instance];
            config.userInfo=userinfo;
            config.isLogin=YES;
            [config saveUserLoginIWithPhone:self.phone andPsd:self.password]; //保存用户数据
            [self performSegueWithIdentifier:@"toRegiste3" sender:self];
        }else{
            NSLog(@"check code error: code=%ld,error=%@",(long)msg.code,msg.message);
        }
    }
}
-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [_timer invalidate];
}

 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }


@end
