

//
//  MainViewController.m
//  DaXueSen
//
//  Created by zhangmin on 14-10-28.
//  Copyright (c) 2014年 ZM. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "Content.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface MainViewController ()
@property(nonatomic) NSInteger type;
@property(nonatomic) NSInteger page;
@property(nonatomic) NSInteger pageSize;
@end

@implementation MainViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    [[HttpUtil getHttpUtil] httpGetWithUrl:[[NSString alloc]initWithFormat:URL_GET_CONTENT,HOST,1,self.page,self.pageSize] andName:@"getContent" andRequestResultDelegate:self];
}
-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellId=@"mainsquaretablecell";
    MainTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell=[[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    NSInteger rowNo=indexPath.row;
    Content*content=[self.contents objectAtIndex:rowNo];
    cell.viewContent.text=content.con_info;
    cell.viewData.text=content.con_pub_time.description;
    //cell.viewLocation.text=content.con_location;
    cell.viewUserName.text=content.userinfo.user_nick_name;
    NSURL*headImageUrl=[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",HOST,content.userinfo.user_head_image_url]];
    [[SDWebImageManager sharedManager] downloadWithURL:headImageUrl options:SDWebImageLowPriority progress:nil completed:^(UIImage *aImage, NSError *error, SDImageCacheType cacheType, BOOL finished) {
        cell.viewHeadImage.image = aImage;
        // NSLog(@"成功了:%d",UIImageJPEGRepresentation(aImage, 1).length);
    }];
    if(content.images){
        cell.viewImages.hidden=NO;
        [cell initCollectionView];
        cell.imageUrls=content.images;
        [cell.viewImages reloadData];
    }else{
        //[cell.viewImages setFrame:CGRectMake(3, 4, 1, 1)];
        cell.viewImages.hidden=YES;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(!self.contents)
        return 0;
    else
        return self.contents.count;
}
-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    if([msg.code isEqualToString:@"2000"])
    {
        self.contents=[Content jsonToArray:msg.result];
        [self.tableView reloadData]; //刷新数据
    }else{
        NSLog(@"%@",msg.message);
    }
}

-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
    NSLog(@"error:%@",error);
}
- (IBAction)selectChange:(id)sender {
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
