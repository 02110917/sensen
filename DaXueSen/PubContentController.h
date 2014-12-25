//
//  PubContentControllerViewController.h
//  DaXueSen
//
//  Created by administrator on 14/12/25.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface PubContentController : UIViewController<UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITextView *mTvInput;
@property (weak, nonatomic) IBOutlet UIButton *mViewAddImageBtn;
@property (weak, nonatomic) IBOutlet UILabel *mLabelLocation;
   
@end
