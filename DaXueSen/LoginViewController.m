//
//  LoginViewController.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-28.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "LoginViewController.h"
#import "Userinfo.h"
#import "Config.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
- (IBAction)login:(id)sender {
    if(self.tfUserName.text==nil||self.tfPassword.text==nil){
        NSLog(@"用户名密码输入为空...");
        return ;
    }
    HttpUtil* http=[HttpUtil getHttpUtil];
    [http httpGetWithUrl:[[NSString alloc]initWithFormat:URL_LOGIN,HOST,self.tfUserName.text,self.tfPassword.text] andName:@"login" andRequestResultDelegate:self];
}
- (IBAction)scanInto:(id)sender {
    [self performSegueWithIdentifier:@"tomain" sender:self];
}
- (IBAction)forgetPsd:(id)sender {
}
- (IBAction)registe:(id)sender {
}
- (IBAction)hideKerBoard:(id)sender {
    [self.tfUserName resignFirstResponder];
    [self.tfPassword resignFirstResponder];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    if(msg)
    {
        if([msg.code isEqualToString:@"1000"]){ //登陆成功
            Userinfo* userinfo=[Userinfo dirToObj:msg.result];
            Config *config=[Config instance];
            config.userInfo=userinfo;
            config.isLogin=YES;
            [config saveUserLoginIWithPhone:self.tfUserName.text andPsd:self.tfPassword.text]; //保存用户数据
           [self performSegueWithIdentifier:@"tomain" sender:self];
        }else{
            NSLog(@"error :%@",msg.message);
        }
        
    }
    else
        NSLog(@"msg=nil");
}
-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
}
-(void)loadView{
    [super loadView];
    if([[Config instance]isLogin]){
        [self performSegueWithIdentifier:@"tomain" sender:self];
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    Config *config=[Config instance];
    self.tfUserName.text=[config readUserLoginPhone];
    self.tfPassword.text=[config readUserLoginPsd];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
