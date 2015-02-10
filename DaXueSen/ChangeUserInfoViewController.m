//
//  ChangeUserInfoViewController.m
//  DaXueSen
//
//  Created by zhangmin on 15/2/9.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "ChangeUserInfoViewController.h"
#import "CaptureViewController.h"
#import "HttpUtil.h"
#import "Util.h"
#import "Config.h"
#import "MBProgressHUD.h"
@interface ChangeUserInfoViewController ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,PassImageDelegate,RequestResultDelegate>
@property(nonatomic,strong)UIActionSheet*actionSheet;
@property(nonatomic,strong)UIImage*headImage;
@property(nonatomic,strong)NSString*headImageFilePath;
@end

@implementation ChangeUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _actionSheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从手机相册选择",@"拍照", nil];
    _viewHeadImage.clipsToBounds=YES;
    _viewHeadImage.layer.cornerRadius=50;
    [_viewHeadImage setUserInteractionEnabled:YES];
    [_viewHeadImage addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headImageClick:)]];
}
-(void)headImageClick:(UITapGestureRecognizer*)gestureRecongnizer{
    [_actionSheet showInView:self.view];
}
- (IBAction)btnSure:(id)sender {
    NSString*nickName=_viewNickName.text;
    NSString*signature=_viewSignature.text;
    NSInteger sex=0;
    if(_headImage==nil||[nickName isEqualToString:@""]||[signature isEqualToString:@""]){
        NSLog(@"输入为空");
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString*url=[[NSString alloc]initWithFormat:URL_CHANGE_USER_INFO,HOST];
    NSMutableDictionary *params=[[NSMutableDictionary alloc]init];
    [params setValue:[NSNumber numberWithLongLong:[Config instance].userInfo.user_id]  forKey:@"user_id"];
    [params setValue:nickName forKey:@"user_nick_name"];
    [params setValue:signature forKey:@"user_signature"];
    [params setValue:[NSNumber numberWithInteger:sex] forKey:@"user_sex"];
    NSMutableDictionary*files=[NSMutableDictionary dictionaryWithObject:_headImageFilePath forKey:@"user_head_image"];
    [[HttpUtil getHttpUtil] httpPostWithUrl:url andName:@"userinfo" andParams:params andFiles:files andRequestResultDelegate:self];
}
-(void)requestSuccess:(NSString *)requestName andResult:(BaseMessage *)msg{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if(msg.code==10111){
        [self performSegueWithIdentifier:@"userinf_to_me" sender:self];
    }else{
        
    }
}
-(void)requestFail:(NSString *)requestName andError:(NSString *)error{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    switch (buttonIndex) {
        case 0: //相册
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentModalViewController:picker animated:YES];
            break;
        case 1: //相机
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }else{
                NSLog(@"模拟器无法打开相机");
            }
            [self presentModalViewController:picker animated:YES];
            break;
        default:
            break;
    }
}
#pragma mark- 拍照选择照片协议方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    NSData *data;
    
    if ([mediaType isEqualToString:@"public.image"]){
        
        //切忌不可直接使用originImage，因为这是没有经过格式化的图片数据，可能会导致选择的图片颠倒或是失真等现象的发生，从UIImagePickerControllerOriginalImage中的Origin可以看出，很原始，哈哈
        UIImage *originImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
        //图片压缩，因为原图都是很大的，不必要传原图
        UIImage *scaleImage = [self scaleImage:originImage toScale:0.3];
        
        //以下这两步都是比较耗时的操作，最好开一个HUD提示用户，这样体验会好些，不至于阻塞界面
        if (UIImagePNGRepresentation(scaleImage) == nil) {
            //将图片转换为JPG格式的二进制数据
            data = UIImageJPEGRepresentation(scaleImage, 1);
        } else {
            //将图片转换为PNG格式的二进制数据
            data = UIImagePNGRepresentation(scaleImage);
        }
        
        //将二进制数据生成UIImage
        UIImage *image = [UIImage imageWithData:data];
        
        //将图片传递给截取界面进行截取并设置回调方法（协议）
        CaptureViewController *captureView = [[CaptureViewController alloc] init];
        captureView.delegate = self;
        captureView.image = image;
        //隐藏UIImagePickerController本身的导航栏
        picker.navigationBar.hidden = YES;
        [picker pushViewController:captureView animated:YES];
        
    }
}
#pragma mark- 缩放图片
-(UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize
{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scaleSize,image.size.height*scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height *scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

-(void)passImage:(UIImage *)image{
    _headImage=image;
    _viewHeadImage.image=image;
    _headImageFilePath=[Util savaImageToDocument:image WithName:@"headimage.png"];
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
