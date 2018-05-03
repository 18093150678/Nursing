//
//  FindDoctorController.m
//  BeautifulTime
//
//  Created by MyBockPro on 2017/4/2.
//  Copyright © 2017年 MyBockPro. All rights reserved.
//

#import "FindDoctorController.h"
#import "TeYueDoctorWebController.h"

@interface FindDoctorController ()

@end

@implementation FindDoctorController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"预约名医";
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *userAddressLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    userAddressLeftBack.frame =CGRectMake(0, 0, 30, 30);
    userAddressLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [userAddressLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [userAddressLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    [userAddressLeftBack addTarget:self action:@selector(FindDoctBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:userAddressLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self GetHttpsDataDoctor];
    [self ViewControllerCounent];


}


-(void)ViewControllerCounent{
    
    
    FindDoctTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SIZE_WIDTH, SIZE_HEIGHT-64) style:UITableViewStylePlain];
    FindDoctTableView.delegate = self;
    FindDoctTableView.dataSource = self;
//    FindDoctTableView.backgroundView = imageTableView;
    FindDoctTableView.showsVerticalScrollIndicator = NO;
    //隐藏分割线
    FindDoctTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [FindDoctTableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                 green:145/255.0
                                                  blue:145/255.0
                                                 alpha:0.2]];

    
    
    [self.view addSubview:FindDoctTableView];



}

#pragma mark -返回有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

#pragma mark -返回每块有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return doctArray.count+4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    //定义cell的名称
    static NSString *IdentifierCell=@"FindDoctorConCell";
    
    //定义cell
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:IdentifierCell];
    
    if (cell==nil) {
        
        //不存在的cell
        //创建新的cel

        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IdentifierCell];
        
    }

    //如果重用已经存在的cell 就把该cell中的view全部清除
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

    if(indexPath.row==0){
    
        UIImageView *LogoImageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH , SIZE_HEIGHT*0.26)];
        LogoImageView.image=[UIImage imageNamed:@"find_1.png"];
        [cell.contentView addSubview:LogoImageView];
        
    }else if (indexPath.row==1) {
        
        UIView *findview =[[UIView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH,120)];
        
        UILabel *findlabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 30)];
        findlabel.text = @"找名医";
        findlabel.textColor = [UIColor blackColor];
        findlabel.textAlignment = NSTextAlignmentLeft;
        findlabel.font = [UIFont systemFontOfSize:16.0];
        
        [findview addSubview:findlabel];
        
        UILabel *findtitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 0,SIZE_WIDTH-80, 30)];
        findtitle.text = @"专业品质妇产医疗";
        findtitle.font = [UIFont systemFontOfSize:14.0];
        findtitle.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:0.6];
        
        [findview addSubview:findtitle];
        
        
        UILabel *titlecontent = [[UILabel alloc]initWithFrame:CGRectMake(10,30, SIZE_WIDTH-20, 60)];
        titlecontent.text = @"权威妇产专家,保障医疗安全,专注服务质量\n"
                            "大肚婆孕期管理专家将全程为你服务,打造一个安心,舒适的就医环境.";
        titlecontent.font = [UIFont systemFontOfSize:14.0];
        titlecontent.textColor = [UIColor colorWithRed:107/255.0 green:107/255.0 blue:107/255.0 alpha:0.6];
        titlecontent.numberOfLines = 0;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:titlecontent.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [titlecontent.text length])];
        titlecontent.attributedText = attributedString;
        
        [titlecontent sizeToFit];
        
        [findview addSubview:titlecontent];
        
        [cell.contentView addSubview:findview];
        
    }else if(indexPath.row == 2){
    
        UIImageView *LogoImageView_1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH,90)];
        LogoImageView_1.image=[UIImage imageNamed:@"doc_ad.png"];
        [cell.contentView addSubview:LogoImageView_1];
        
    
    }else if (indexPath.row==3) {
        
    
        UIView *threeview = [[UIView alloc]initWithFrame:CGRectMake(0, 0,SIZE_WIDTH,55)];
        threeview.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1.0];
        [cell.contentView addSubview:threeview];
        
        UILabel *teyuedoct = [[UILabel alloc]initWithFrame:CGRectMake(30, (55-30)/2, SIZE_WIDTH-60, 30)];
        teyuedoct.text =@"---- 特邀名医 ----";
        teyuedoct.textColor = [UIColor blackColor];
        teyuedoct.font=[UIFont systemFontOfSize:16.0];
        teyuedoct.textAlignment = NSTextAlignmentCenter;
        [threeview addSubview:teyuedoct];
        
    }else{
    
        AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 240)];
        asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
        asynImageView.imageURL=[NSString stringWithFormat:@"%@",[[doctArray objectAtIndex:indexPath.row-4] valueForKey:@"photo"]];
        asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],asynImageView.imageURL];
        asynImageView.layer.cornerRadius = 8;
        asynImageView.layer.masksToBounds = true;
        asynImageView.contentMode=UIViewContentModeScaleToFill;
        [cell.contentView addSubview:asynImageView];

        UILabel *doctorName=[[UILabel alloc]initWithFrame:CGRectMake(20,245, 90, 30)];
        doctorName.text=[NSString stringWithFormat:@"%@",[[doctArray objectAtIndex:indexPath.row-4] valueForKey:@"name"]];
        [doctorName setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16.0]];
        [cell.contentView addSubview:doctorName];
        
        UILabel *doctorTitle=[[UILabel alloc]initWithFrame:CGRectMake(110,245, 120, 30)];
        doctorTitle.text=[NSString stringWithFormat:@"%@",[[doctArray objectAtIndex:indexPath.row-4] valueForKey:@"post"]];
        [doctorTitle setFont:[UIFont fontWithName:@"Arial" size:12.0]];
        doctorTitle.textColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0];
        [cell.contentView addSubview:doctorTitle];
        
        
        UILabel *doctorbrief = [[UILabel alloc]initWithFrame:CGRectMake(20, 285, SIZE_WIDTH-40, 70)];
        doctorbrief.text=[NSString stringWithFormat:@"%@",[[doctArray objectAtIndex:indexPath.row-4] valueForKey:@"shanchang"]];
        [doctorbrief setFont:[UIFont fontWithName:@"Arial" size:12.0]];
        doctorbrief.textColor = [UIColor colorWithRed:137/255.0 green:137/255.0 blue:137/255.0 alpha:1.0];
        doctorbrief.numberOfLines = 3;
        [cell.contentView addSubview:doctorbrief];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:doctorbrief.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:6];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [doctorbrief.text length])];
        doctorbrief.attributedText = attributedString;

        [doctorbrief sizeToFit];
      
        //华丽的分割view
        UIView *LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 350, SIZE_WIDTH, 10)];
        LineView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        [cell.contentView addSubview:LineView];
     
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;


}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat rowHeight = 360 ;
    
    if (indexPath.row == 0) {
        
        rowHeight = SIZE_HEIGHT*0.26;
    }
    if (indexPath.row==1 ) {
        
        rowHeight = 120;
    }

    if (indexPath.row==2 ) {
        
        rowHeight = 90;
    }
    
    if (indexPath.row==3) {
        
        rowHeight=55;
    }
    
    return rowHeight;
    
}


//表视图的选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

 
    if (indexPath.row==0 || indexPath.row ==1 ||indexPath.row==2 ) {
        
        return;
    }
//    DoctorInfoController *doctCon=[[DoctorInfoController alloc]init];
    TeYueDoctorWebController *teyueCon=[[TeYueDoctorWebController alloc]init];
    teyueCon.doctorID = [[doctArray objectAtIndex:indexPath.row-4] valueForKey:@"id"];
    [self.navigationController pushViewController:teyueCon animated:YES];
    
    
}

-(void)GetHttpsDataDoctor{
    
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    NSString *Urladress = ios_doctor_list;
    NSString *strUrl =[NSString stringWithFormat:@"%@%@",URL,Urladress];
        //创建链接
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        doctArray  = responseObject;
        NSLog(@"responseObject----%@",[responseObject valueForKey:@"name"]);
        [FindDoctTableView reloadData];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //    [activityIndicatorView stopAnimating];
        
    }];
}


-(void)FindDoctBackFunc:(id)sender{

    [self.navigationController popViewControllerAnimated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

