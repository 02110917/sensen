//
//  CaptureViewController.h
//  DaXueSen
//
//  Created by zhangmin on 15/2/9.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PassImageDelegate <NSObject>

-(void)passImage:(UIImage *)image;

@end
@interface CaptureViewController : UIViewController
@property(nonatomic,strong)UIImage*image;
@property(nonatomic,assign)id<PassImageDelegate>delegate;
@end
