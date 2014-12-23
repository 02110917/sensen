//
//  MainViewController.h
//  DaXueSen
//
//  Created by zhangmin on 14-10-28.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "ViewController.h"

@interface MainViewController : ViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray* contents;
@end
