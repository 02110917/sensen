//
//  PubContentControllerViewController.h
//  DaXueSen
//
//  Created by administrator on 14/12/25.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELCImagePickerHeader.h"
@class LocationPoi;
@protocol ReturnValueDelegate <NSObject>

-(void)setReturnValue:(id)value forKey:(NSString*)key;
@end

@interface PubContentController : UIViewController<UIActionSheetDelegate,ELCImagePickerControllerDelegate,ReturnValueDelegate>

@property (weak, nonatomic) IBOutlet UITextView *mTvInput;
@property (weak, nonatomic) IBOutlet UIButton *mViewAddImageBtn;
@property (weak, nonatomic) IBOutlet UIButton *mButtonLocation;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *locationTopConstraint;
@property(nonatomic,strong)NSArray*locationPoisArray;
@property(nonatomic,strong)LocationPoi* currectPoi;
@end
