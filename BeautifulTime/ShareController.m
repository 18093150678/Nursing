//
//  ShareController.m
//  BeautifulTime
//
//  Created by lee on 2017/5/22.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "ShareController.h"
#import <UShareUI/UShareUI.h>
#import "Pretreatment.h"
static NSString* const UMS_Title = @"【大肚婆】时光集团";
static NSString* const UMS_Prog_Title = @"大肚婆】时光集团";
static NSString* const UMS_Text = @"欢迎使用【大肚婆】专业护理,一站式服务！";
static NSString* const UMS_Text_image = @"欢迎使用【大肚婆】专业护理,一站式服务！";
static NSString* const UMS_Web_Desc = @"欢迎使用【大肚婆】专业护理,一站式服务！！";
static NSString* const UMS_Music_Desc = @"欢迎使用【大肚婆】专业护理,一站式服务！";
static NSString* const UMS_Video_Desc = @"欢迎使用【大肚婆】专业护理,一站式服务！";

//static NSString* const UMS_THUMB_IMAGE = @"http://ddp.lzsg120.com/img/index_nav_2.png";
static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";

static NSString* const UMS_WebLink = @"http://ddp.lzsg120.com/download.htm";

static NSString* const UMS_THUMB_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//static NSString* const UMS_IMAGE = @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
//
//static NSString* const UMS_WebLink = @"https://mobile.umeng.com";


static NSString *UMS_SHARE_TBL_CELL = @"UMS_SHARE_TBL_CELL";


@interface ShareController ()<UMSocialShareMenuViewDelegate>
@property (nonatomic, strong) UIButton *bottomNormalButton;
@property (nonatomic, strong) UIButton *bottomCircleButton;
@property (nonatomic, strong) UIButton *middleNormalButton;
@property (nonatomic, strong) UIButton *middleCircleButton;

@property (nonatomic, strong) UIButton *bottomNormalButtonWithoutTitle;
@property (nonatomic, strong) UIButton *bottomNormalButtonWithoutCancel;


@end

@implementation ShareController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置用户自定义的平台

    [self.navigationController setNavigationBarHidden:YES animated:YES];

    
    self.view.backgroundColor=[UIColor colorWithRed:246/255.0 green:71/255.0 blue:71/255.0 alpha:1.0];
  //  self.view.backgroundColor = [UIColor whiteColor];
    
     [self contentFunc];
    
    
    UIButton *LeftCloses=[[UIButton alloc]initWithFrame:CGRectMake(15,30, 24, 24)];
    [LeftCloses setImage:[UIImage imageNamed:@"login_back.png"] forState:UIControlStateNormal];
    //   LeftClose.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"back_but.png"]];
    [LeftCloses setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [LeftCloses addTarget:self action:@selector(closeshareFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:LeftCloses];
    
    
    self.navigationController.navigationBar.translucent = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
 
}


-(void)contentFunc{

 //   UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((SIZE_WIDTH-180)/2, 80,180 ,180)];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0 ,SIZE_WIDTH,SIZE_HEIGHT)];
    imageView.image = [UIImage imageNamed:@"fenxiang"];
    
    [self.view addSubview:imageView];

//    UILabel *sharelabeltitle = [[UILabel alloc]initWithFrame:CGRectMake(30, 260, SIZE_WIDTH-60, 80)];
//    sharelabeltitle.text = @"大肚婆";
//    sharelabeltitle.numberOfLines = 0;
//    sharelabeltitle.textAlignment = NSTextAlignmentCenter;
//    sharelabeltitle.font = [UIFont systemFontOfSize:32.0];
//    sharelabeltitle.textColor = [UIColor whiteColor];
//    
//    [self.view addSubview:sharelabeltitle];
    
    UILabel *sharelabel = [[UILabel alloc]initWithFrame:CGRectMake(30,SIZE_HEIGHT-240, SIZE_WIDTH-60, 120)];
    sharelabel.text = @"备孕，孕期，产后恢复，婴幼儿胎教早教资讯及服务，孕妈一站式全方位的全能健康管理平台，让您省心又省力，宝宝健康，妈妈安心，家人放心，备孕宝妈们想要的资讯干货集结地。";
    sharelabel.numberOfLines = 0;
    sharelabel.font = [UIFont systemFontOfSize:16.0];
    sharelabel.textColor = [UIColor blackColor];
    
    [self.view addSubview:sharelabel];
    
    
    UIButton *button = [self button];
    [button setTitle:@"分享有礼" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(showBottomCircleView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.bottomNormalButton = button;
    
    
    [self.view addSubview:self.bottomNormalButton];

}


- (UIButton *)button
{
    CGRect frame = self.view.frame;
    CGFloat width = frame.size.width - 20.f * 3;
    width /= 2;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((SIZE_WIDTH-width)/2,SIZE_HEIGHT-100, width, width/3);
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 8;
    button.layer.masksToBounds = true;
    button.layer.borderWidth = 2;
    button.layer.borderColor = [[UIColor whiteColor] CGColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor colorWithRed:217/255.0 green:90/255.0 blue:88/255.0 alpha:1.0]];
    button.titleLabel.font = [UIFont systemFontOfSize:20.f];
    
    return button;
}

- (void)showBottomCircleView
{
    [UMSocialUIManager removeAllCustomPlatformWithoutFilted];
    [UMSocialShareUIConfig shareInstance].sharePageGroupViewConfig.sharePageGroupViewPostionType = UMSocialSharePageGroupViewPositionType_Bottom;
    [UMSocialShareUIConfig shareInstance].sharePageScrollViewConfig.shareScrollViewPageItemStyleType = UMSocialPlatformItemViewBackgroudType_IconAndBGRadius;
#ifdef UM_Swift
    [UMSocialSwiftInterface showShareMenuViewInWindowWithPlatformSelectionBlockWithSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary* userInfo) {
#else
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
#endif
            [self shareWebPageToPlatformType:platformType];
           
        }];
    }
     
     
  
//分享文本
- (void)shareTextToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = @"大肚婆";
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
    }

 //网页分享
- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    NSString* thumbURL =  UMS_THUMB_IMAGE;
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:UMS_Title descr:UMS_Web_Desc thumImage:thumbURL];
    //设置网页地址
    NSString *shareurl=[NSString stringWithFormat:@"%@?userid=%@",UMS_WebLink,[USER_DEFAULT objectForKey:@"user_id"]];
    shareObject.webpageUrl = shareurl;
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
#ifdef UM_Swift
    [UMSocialSwiftInterface shareWithPlattype:platformType messageObject:messageObject viewController:self completion:^(UMSocialShareResponse * data, NSError * error) {
#else
        //调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
#endif
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else{
                if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                    UMSocialShareResponse *resp = data;
                    //分享结果消息
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    //第三方原始返回的数据
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                    
                }else{
                    UMSocialLogInfo(@"response data is %@",data);
                }
            }
            [self alertWithError:error];
        }];
}

          
         
- (void)alertWithError:(NSError *)error{
    
    NSString *result = nil;
            if (!error) {
                result = [NSString stringWithFormat:@"Share succeed"];
            }
            else{
                NSMutableString *str = [NSMutableString string];
                if (error.userInfo) {
                    for (NSString *key in error.userInfo) {
                        [str appendFormat:@"%@ = %@\n", key, error.userInfo[key]];
                    }
                }
                if (error) {
                    result = [NSString stringWithFormat:@"Share fail with error code: %d\n%@",(int)error.code, str];
                }
                else{
                    result = [NSString stringWithFormat:@"Share fail"];
                }
            }
 
}
     
#pragma mark-加载分享
-(void)closeshareFunc:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
