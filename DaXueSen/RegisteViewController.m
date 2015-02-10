//
//  RegisteViewController.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-28.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "RegisteViewController.h"
#import "HttpUtil.h"
#import "MBProgressHUD.h"
@interface RegisteViewController ()
@property(nonatomic,assign)long userId;
@property(nonatomic,strong)NSString*phone;
@property(nonatomic,strong)NSString*password;
@end

@implementation RegisteViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)btnSureClick:(id)sender {
    NSString*phone=self.viewInputPhoneNumber.text;
    NSString*password=self.viewInputPassword.text;
    if([phone isEqualToString:@""]||[password isEqualToString:@""]){
        //输入为空
    }else{
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _phone=phone;
        _password=password;
        NSString*url=[[NSString alloc]initWithFormat:URL_REGISTE_1,HOST,phone,password];
        [[HttpUtil getHttpUtil]httpGetWithUrl:url andName:@"registe" andRequestResultDelegate:self];
    }
}
-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if(msg&&msg.code==1004){
        _userId=[msg.result longLongValue];
        [self performSegueWithIdentifier:@"to_registe2" sender:self];
    }else{
        NSLog(@"registe error:%@",msg.message);
    }
}
-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"to_registe2"]){
        [segue.destinationViewController setValue:[NSNumber numberWithLong:_userId] forKey:@"userId"];
        [segue.destinationViewController setValue:_phone forKey:@"phone"];
        [segue.destinationViewController setValue:_password forKey:@"password"];
    }
}


@end
