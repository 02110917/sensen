//
//  PubContentControllerViewController.h
//  DaXueSen
//
//  Created by administrator on 14/12/25.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerHeader.h"
@interface PubContentController : UIViewController<UIActionSheetDelegate,ELCImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *mTvInput;
@property (weak, nonatomic) IBOutlet UIButton *mViewAddImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *mLabelLocation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationTopConstraint;
   
@end
