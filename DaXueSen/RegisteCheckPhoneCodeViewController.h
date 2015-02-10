//
//  RegisteCheckPhoneCodeViewController.h
//  DaXueSen
//
//  Created by zhangmin on 15/2/8.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisteCheckPhoneCodeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *viewInputVerifyCode;
@property (weak, nonatomic) IBOutlet UIButton *viewRegetCode;
@property(nonatomic,assign)long userId;
@property(nonatomic,strong)NSString*phone;
@property(nonatomic,strong)NSString*password;
@end
