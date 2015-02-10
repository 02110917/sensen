//
//  RegisteViewController.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-28.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "ViewController.h"

@interface RegisteViewController : ViewController<RequestResultDelegate>
@property (weak, nonatomic) IBOutlet UITextField *viewInputPhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *viewInputPassword;

@end
