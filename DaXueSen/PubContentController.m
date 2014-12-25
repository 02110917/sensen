//
//  PubContentControllerViewController.m
//  DaXueSen
//
//  Created by administrator on 14/12/25.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "PubContentController.h"

@interface PubContentController ()

@end

@implementation PubContentController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView* addImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    addImage.image=[UIImage imageNamed:@"add_images.png"];
    [_mViewAddImageBtn addSubview:addImage];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(60, 15, 80, 20)];
    label.text=@"添加照片";
    [_mViewAddImageBtn addSubview:label];
}
- (IBAction)addImages:(id)sender {
    
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
