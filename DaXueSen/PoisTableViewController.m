//
//  PoisTableViewController.m
//  DaXueSen
//
//  Created by zhangmin on 15/2/6.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "PoisTableViewController.h"
#import "LocationPoi.h"
#import "HttpUtil.h"
@interface PoisTableViewController ()
@end

@implementation PoisTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(!self.pois){
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _pois==nil?0:_pois.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellId=@"pois_list";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    LocationPoi*poi=[_pois objectAtIndex:indexPath.row];
    cell.textLabel.text=poi.title;
    cell.detailTextLabel.text=poi.address;
    if(_currectPoi.lat==poi.lat&&_currectPoi.lng==poi.lng){
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LocationPoi*poi=[_pois objectAtIndex:indexPath.row];
    [_delegate setReturnValue:_pois forKey:@"locationPoisArray"];
    [_delegate setReturnValue:poi forKey:@"currectPoi"];
    [self.navigationController popViewControllerAnimated:YES];
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
