

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
#import "MBProgressHUD.h"
@interface MainViewController ()
@property(nonatomic,strong) NSMutableArray* contentsSquare;
@property(nonatomic,strong) NSMutableArray* contentsGril;
@property(nonatomic) NSInteger type;
@property(nonatomic) NSInteger page;
@property(nonatomic) NSInteger pageGril;
@property(nonatomic) NSInteger currectPage;
@property(nonatomic) NSInteger pageSize;
@property(nonatomic) BOOL isLoad;
@property(nonatomic,strong)NSMutableArray*currectArray;
@property(nonatomic,strong)UIRefreshControl *refresh;
@property(nonatomic,strong)UIRefreshControl *refreshGril;
@property(nonatomic,strong)UIRefreshControl *currectRefresh;
@property(nonatomic,weak)UITableView*currectTableView;
//@property(nonatomic,strong)UIButton *bottomRefresh;
@property(nonatomic,assign)CGFloat screenWidth;
@property(nonatomic)BOOL loaMore;
@property(nonatomic,strong)NSString*cellId;
@end

@implementation MainViewController
//static NSString * const cellId=@"mainsquaretablecell";
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(UIRefreshControl*)addRefreshViewTo:(UITableView*)tableView{
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, -10, 0, 0)];
    tableView.tableHeaderView=refreshView;
    //    [self.tableView insertSubview:refreshView atIndex:0]; //the tableView is a IBOutlet
    UIRefreshControl*re = [[UIRefreshControl alloc] init];
    re.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    re.tintColor = [UIColor blueColor];
    [re addTarget:self action:@selector(pullToRefresh) forControlEvents:UIControlEventValueChanged];
    [refreshView addSubview:re];
    return re;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _cellId=@"mainsquaretablecell";
//    _tableViewGril.hidden=YES;
    [self.view bringSubviewToFront:_tableView];
    _screenWidth=[ UIScreen mainScreen].applicationFrame.size.width;
    // Do any additional setup after loading the view.
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewGril.dataSource=self;
    self.tableViewGril.delegate=self;
    self.tableViewGril.separatorStyle = UITableViewCellSeparatorStyleNone;
    _refresh=[self addRefreshViewTo:_tableView];
    _refreshGril=[self addRefreshViewTo:_tableViewGril];
    _contentsSquare=[[NSMutableArray alloc]init];
    _contentsGril=[[NSMutableArray alloc]init];
    _currectArray=_contentsSquare;
    _currectRefresh=_refresh;
    _currectTableView=_tableView;
    _currectPage=_page;
    [self loadData];
}
-(void)loadData{
    [[HttpUtil getHttpUtil] httpGetWithUrl:[[NSString alloc]initWithFormat:URL_GET_CONTENT,HOST,_type,_currectPage,_pageSize] andName:@"getContent" andRequestResultDelegate:self];
}
-(void)viewDidAppear:(BOOL)animated{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//下拉刷新
- (void)pullToRefresh
{
    //[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    _currectRefresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"刷新中"];
    _currectPage=0;
    [self loadData];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString* cellId=@"mainsquaretablecell";
    return [self basicCellAtIndexPath:indexPath];
}
- (MainTableViewCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    MainTableViewCell *cell=[_currectTableView dequeueReusableCellWithIdentifier:_cellId];
    if(cell==nil){
        cell=[[MainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:_cellId];
    }
    cell.parentController=self;
    NSInteger rowNo=indexPath.row;
    Content*content=[self.currectArray objectAtIndex:rowNo];
    cell.content=content;
    cell.viewContent.text=content.con_info;
    cell.viewData.text=content.con_pub_time.description;
    cell.viewLocation.text=content.con_location;
    cell.viewUserName.text=content.userinfo.user_nick_name;
    NSString*headImageUrl=[NSString stringWithFormat:@"%@/%@",HOST,content.userinfo.user_head_image_url];
    [[HttpUtil getHttpUtil]httpDownLoadImageWithUrl:headImageUrl andDisplatImageView:cell.viewHeadImage andErrorImageName:@"photo.png" showProgress:NO];
    if(content.images){
        cell.viewImages.hidden=NO;
        cell.imageUrls=content.images;
        if(cell.imageUrls.count==1){
            cell.constraintImagesHeight.constant=121;
        }else{
            float height=((cell.imageUrls.count-1)/3+1)*75;
            cell.constraintImagesHeight.constant=height;
        }
        [cell.viewContent updateConstraintsIfNeeded];
        [cell initCollectionView];
        [cell.viewImages reloadData];
    }else{
        //[cell.viewImages setFrame:CGRectMake(3, 4, 1, 1)];
        cell.viewImages.hidden=YES;
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currectArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static MainTableViewCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [_currectTableView dequeueReusableCellWithIdentifier:_cellId];
    });
    
    Content*content=[self.currectArray objectAtIndex:indexPath.row];
//    CGRect size=sizingCell.viewContent.bounds;
    //    NSLog(@"info:%@",content.con_info);
    //    NSLog(@"width:%f",size.size.width);
    //    CGFloat height=[MainViewController heightForString:content.con_info withWidth:size.size.width andFontSize:14];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:sizingCell.viewContent.font, NSParagraphStyleAttributeName:paragraphStyle.copy};
//    NSLog(@"%f",sizingCell.viewContent.contentSize.width-20);
    CGSize labelSize = [content.con_info boundingRectWithSize:CGSizeMake(200, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    /*
     This method returns fractional sizes (in the size component of the returned CGRect); to use a returned size to size views, you must use raise its value to the nearest higher integer using the ceil function.
     */
    labelSize.height = ceil(labelSize.height);
    labelSize.width = ceil(labelSize.width);
    CGFloat height=labelSize.height+20;
//        NSLog(@"helght:%f ",height);
    float height_images=0;
    if(content.images.count==1){
        height_images=121;
    }else if(content.images.count>1){
        height_images=((content.images.count-1)/3+1)*75;
    }
    return height+height_images+125;
}
- (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
   CGSize size = [strText sizeWithFont:textView.font
                                              constrainedToSize:CGSizeMake(textView.contentSize.width-20, 2000)
                                                  lineBreakMode:NSLineBreakByWordWrapping];
    float fHeight = size.height + 20.0;
    
    return fHeight;
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 下拉到最底部时显示更多数据
    if(_loaMore&&(scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height)))
    {
        ++_currectPage;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [self loadData];
    }
}

+ (float) heightForString:(NSString *)value withWidth:(float)width andFontSize:(CGFloat)size
{
    return [value boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:[NSDictionary dictionaryWithObject:[UIFont systemFontOfSize:size] forKey:NSFontAttributeName] context:nil].size.width;
}
-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if([_currectRefresh isRefreshing]){
        [_currectRefresh endRefreshing];
        _currectRefresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    }
    if(msg.code==2000)
    {
        if([_currectRefresh isRefreshing]){
            [_currectArray removeAllObjects];
        }
        [self.currectArray addObjectsFromArray:[Content jsonToArray:msg.result]];
        [_currectTableView reloadData]; //刷新数据
        _loaMore=false;
        if(self.currectArray.count%20==0){
            _loaMore=true;
//            _bottomRefresh.frame = CGRectMake(0, _tableView.frame.size.height, _screenWidth, 50);
//            [_tableView setTableFooterView:_bottomRefresh];
        }
    }else{
        NSLog(@"%@",msg.message);
    }
}

-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSLog(@"error:%@",error);
    if([_currectRefresh isRefreshing]){
        [_currectRefresh endRefreshing];
        _currectRefresh.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    }
}
- (IBAction)selectChange:(UISegmentedControl*)sender {
    self.type=sender.selectedSegmentIndex;
    if(self.type==0){
        _currectArray=_contentsSquare;
        _currectRefresh=_refresh;
        _currectTableView=_tableView;
        
        _currectPage=_page;
        _cellId=@"mainsquaretablecell";
    }else{
        _currectArray=_contentsGril;
        _currectRefresh=_refreshGril;
        _currectTableView=_tableViewGril;
        _currectPage=_pageGril;
        _cellId=@"mainsquaregriltablecell";
    }
    [self.view bringSubviewToFront:_currectTableView];
    [_currectTableView reloadData];
    if(!self.isLoad){
        [self loadData];
        self.isLoad=true;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toPersonalCard"]){
//         segue.destinationViewController;
        MainTableViewCell*cell=sender;
         [segue.destinationViewController setValue:[NSNumber numberWithLong:cell.content.con_user_id] forKey:@"userId"];
    }
}

@end
