//
//  PoisTableViewController.h
//  DaXueSen
//
//  Created by zhangmin on 15/2/6.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PubContentController.h"
@class LocationPoi;
@interface PoisTableViewController : UITableViewController
@property(nonatomic,strong) NSArray* pois;
@property(nonatomic,strong) LocationPoi*currectPoi;
@property(assign,nonatomic) id<ReturnValueDelegate> delegate;
@end
