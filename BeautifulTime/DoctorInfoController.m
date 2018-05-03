//
//  DoctorInfoController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/3.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "DoctorInfoController.h"

@interface DoctorInfoController ()

@end

@implementation DoctorInfoController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"特邀名医";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(DoctorInfoFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self contentView];

}

-(void)contentView{

    UIView *doctorView=[[UIView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT*0.3)];
    
    UIImageView *doctorphoto = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, doctorView.frame.size.height-20)];
    doctorphoto.image=[UIImage imageNamed:@"dd_2.png"];
   
    [doctorView addSubview:doctorphoto];
    
    UIView *doctorNameTitle=[[UIView alloc]initWithFrame:CGRectMake(60, doctorView.frame.size.height-40, SIZE_WIDTH-120, 40)];
    doctorNameTitle.backgroundColor=[UIColor colorWithRed:255/255.0 green:51/255.0 blue:102/255.0 alpha:1.0];
    doctorNameTitle.layer.cornerRadius = 10;
    doctorNameTitle.layer.masksToBounds = true;
    
    UILabel *doctorName=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, doctorNameTitle.frame.size.width/2, 40)];
    [doctorName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16.0]];
    doctorName.textAlignment=NSTextAlignmentRight;
    doctorName.backgroundColor = [UIColor clearColor];
    doctorName.textColor=[UIColor whiteColor];
    doctorName.text=@"刘德华";
    
    UILabel *doctorTitle=[[UILabel alloc]initWithFrame:CGRectMake(doctorNameTitle.frame.size.width/2, 0, doctorNameTitle.frame.size.width/2, 40)];
    [doctorTitle setFont:[UIFont fontWithName:@"Arial" size:14.0]];
    doctorTitle.textAlignment=NSTextAlignmentCenter;
    doctorTitle.backgroundColor = [UIColor clearColor];
    doctorTitle.textColor=[UIColor whiteColor];
    doctorTitle.text=@"主任医师";

    [doctorNameTitle addSubview:doctorName];
    [doctorNameTitle addSubview:doctorTitle];
    
    [doctorView addSubview:doctorNameTitle];
    
    [self.view addSubview:doctorView];
    
    [self Middle];
    [self BottomView];

}

-(void)Middle{

    UITextView *DoctortextView=[[UITextView alloc]initWithFrame:CGRectMake(20, SIZE_HEIGHT*0.3+64+10, SIZE_WIDTH-40, SIZE_HEIGHT-SIZE_HEIGHT*0.3-50-76)];
    DoctortextView.editable=NO;
    DoctortextView.delegate=self;
    DoctortextView.textColor= [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0];//设置textview里面的字体颜色
    DoctortextView.font= [UIFont fontWithName:@"Arial"size:14.0];//设置字体名字和字体大小
    DoctortextView.backgroundColor = [UIColor whiteColor];//设置它的背景颜色
    DoctortextView.autoresizingMask=UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
//    DoctortextView.scrollEnabled=YES;
    DoctortextView.text=@"   丁进芳，女，主任检验师、硕士生导师，中共党员。毕业于兰州医学院医疗系，本科，学士学位。甘肃省临床检验中心副主任、甘肃省人民医院检验科主任、甘肃省医学会第六届常务理事、甘肃省检验专业委员会主任委员、中华医学会检验分会血液体液专家委员会委员。多次被评为甘肃省卫生厅、甘肃省人民医院优秀党员，先进工作者。1999年获甘肃省优秀专家荣誉称号，是甘肃省检验医学界的带头人之一，在血液系统疾病及实验室诊断，尤其对溶血性贫血、出血与血栓性疾病的检查方面有突出贡献。先后完成科研课题11项，分获省级三等奖(3项)和厅级二、三等奖。主编和参编著作3本，撰写论文30余篇。";
    [self.view addSubview:DoctortextView];

}

-(void)textViewDidChange:(UITextView *)textView{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    paragraphStyle.lineSpacing = 40;// 字体的行间距
    
    
    
    NSDictionary *attributes = @{
                                 
                                 NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 
                                 };
    
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];

}
//最下方tabber
-(void)BottomView{

    UIView *bottomView=[[UIView alloc]initWithFrame:CGRectMake(0, SIZE_HEIGHT-50, SIZE_WIDTH, 50)];
    
    UIView *bottomViewLeft=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH*0.7, 50)];
    bottomView.backgroundColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0];
  //  bottomLabel.font=[UIFont systemFontOfSize:14.0];
    
    UILabel *tellLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, 40, 50)];
    tellLabel.font = [UIFont fontWithName:@"iconfont" size:18];
    tellLabel.textColor = [UIColor redColor];
    [tellLabel setText:@"\U0000e60a"];
 //   [tellLabel setTitle:@"\U0000e60a" forState:UIControlStateNormal];
    [bottomViewLeft addSubview:tellLabel];
    
    UILabel *collLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0,bottomViewLeft.frame.size.width-60, 50)];
    collLabel.backgroundColor =[UIColor clearColor];
    collLabel.text=@"电话咨询";
    collLabel.font=[UIFont systemFontOfSize:14.0];
    collLabel.textColor = [UIColor blackColor];
    [bottomViewLeft addSubview:collLabel];
    
    
    UIButton *YuYueBut = [[UIButton alloc]initWithFrame:CGRectMake(SIZE_WIDTH*0.7, 0, SIZE_WIDTH*0.3, 50)];
    [YuYueBut setTitle:@"@预约TA" forState:UIControlStateNormal];
    [YuYueBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [YuYueBut setBackgroundColor:[UIColor colorWithRed:255/255.0 green:51/255.0 blue:102/255.0 alpha:1.0]];
    YuYueBut.titleLabel.font = [UIFont systemFontOfSize:14.0];
    

    [bottomView addSubview:bottomViewLeft];
    [bottomView addSubview:YuYueBut];
    
    [self.view addSubview:bottomView];
    
}


-(void)DoctorInfoFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
