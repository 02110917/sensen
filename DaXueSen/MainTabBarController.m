//
//  MainTabBarController.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-29.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "MainTabBarController.h"
#import "Config.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
//    if(![[Config instance] isLogin]){
//        [self performSegueWithIdentifier:@"maintologin" sender:self];
//    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
