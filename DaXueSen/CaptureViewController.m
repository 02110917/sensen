//
//  CaptureViewController.m
//  DaXueSen
//
//  Created by zhangmin on 15/2/9.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "CaptureViewController.h"
#import "AGSimpleImageEditorView.h"
@interface CaptureViewController ()
@property(nonatomic,strong)AGSimpleImageEditorView*editorView;
@end

@implementation CaptureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加导航栏和完成按钮
    UINavigationBar *naviBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:naviBar];
    
    UINavigationItem *naviItem = [[UINavigationItem alloc] initWithTitle:@"图片裁剪"];
    [naviBar pushNavigationItem:naviItem animated:YES];
    
    //保存按钮
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(saveButton)];
    naviItem.rightBarButtonItem = doneItem;
    
    //image为上一个界面传过来的图片资源
    _editorView = [[AGSimpleImageEditorView alloc] initWithImage:self.image];
    _editorView.frame = CGRectMake(0, 0, self.view.frame.size.width ,  self.view.frame.size.width);
    _editorView.center = self.view.center;
    
    //外边框的宽度及颜色
    _editorView.borderWidth = 1.f;
    _editorView.borderColor = [UIColor blackColor];
    
    //截取框的宽度及颜色
    _editorView.ratioViewBorderWidth = 5.f;
    _editorView.ratioViewBorderColor = [UIColor orangeColor];
    
    //截取比例，我这里按正方形1:1截取（可以写成 3./2. 16./9. 4./3.）
    _editorView.ratio = 1;
    
    [self.view addSubview:_editorView];
}
//完成截取
-(void)saveButton
{
    //output为截取后的图片，UIImage类型
    UIImage *resultImage = _editorView.output;
    
    //通过代理回传给上一个界面显示
    [self.delegate passImage:resultImage];
    
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
