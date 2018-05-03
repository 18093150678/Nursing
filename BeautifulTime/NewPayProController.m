//
//  NewPayProController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/14.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//


#define pickerHeight 216
#define PICKERVIEW_HEIGHT 256
#import "NewPayProController.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "AFNetworking.h"
#import "DataMD5.h"
#import <CommonCrypto/CommonDigest.h>
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "RSADataSigner.h"
#import <Foundation/Foundation.h>


@interface NewPayProController (){
    
    NSInteger selectRow;
    NSInteger selectcomponent;
    
}

@end

@implementation NewPayProController
@synthesize Pro_id,orderProDictInfo;

- (void)viewDidLoad {
    [super viewDidLoad];


    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zfbgetOrderPayResult:) name:@"zfb_pay" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"wx_pay" object:nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"订单详情";
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *proLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    proLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [proLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    proLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [proLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    
    [proLeftBack addTarget:self action:@selector(proBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:proLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftBarButton;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    pay_Type = 1;
    
    //协议按钮常量
    deleteButStatus = @"1";
    
    [self TabViewFunc];
    
    [self OriderFuncss];
    
    number = [[NSMutableArray alloc]init];
    

    
    bqNumindex = 0;
    
    arrayBut = [[NSMutableArray alloc]init];
}


-(void)viewWillAppear:(BOOL)animated{
    
    
  //  [self GetHttpsDataProductslist];
    [self GetAdressListFunc];
    
}

#pragma mark -产品订单信息表示图
-(void)TabViewFunc{
    
    //初始化产品数量 默认为 1件
    payNum = 1;
    
    UIImageView *imageTableView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, SIZE_HEIGHT)];
    imageTableView.image = [UIImage imageNamed:@"timelogo.png"];
    
    //UITableViewStylePlain   不分组
    //UITableViewStyleGrouped   分组
    TabLeView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, SIZE_WIDTH, SIZE_HEIGHT-115) style:UITableViewStylePlain];
    TabLeView.delegate = self;
    TabLeView.dataSource = self;
    TabLeView.backgroundView = imageTableView;
    [TabLeView setSeparatorColor:[UIColor colorWithRed:227/255.0 green:227/255.0 blue:227/255.0 alpha:0.4]];
    TabLeView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:TabLeView];
    
}

#pragma mark -返回有TabLeView有几块
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

#pragma mark -返回每块有几行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
 //   return 10+arrayMutableProduct.count;
    return 11;
    
}

#pragma mark -返回cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellName = @"idfentName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    NSLog(@"ld%ld",(long)indexPath.row);
    
    if (cell == nil) {
        //不存在的cell
        //创建新的cel
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellName];
        
    }
    while ([cell.contentView subviews].count >0) {
        
        [[[cell.contentView subviews] objectAtIndex:0] removeFromSuperview];
        
    }
    
    if (indexPath.row == 0) {
        
        
        UIView *addressView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 70)];
        [addressView setBackgroundColor:[UIColor colorWithRed:239/255.0 green:127/255.0 blue:52/255.0 alpha:1.0]];
        
        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH-20, 70)];
        
        if (addressList.count == 0) {
            
            addressLabel.text =@"设置地址";
            addressLabel.textAlignment = NSTextAlignmentCenter;
            addressLabel.font = [UIFont systemFontOfSize:14.0];
            addressLabel.textColor = [UIColor whiteColor];
            
            [addressView addSubview:addressLabel];
            
         
            
        }else{
            
            UILabel *addressName = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SIZE_WIDTH/2, 30)];
            addressName.text =[NSString stringWithFormat:@"姓名:%@",[[addressList objectAtIndex:0] valueForKey:@"user_name"]];
            addressName.textAlignment = NSTextAlignmentLeft;
            addressName.textColor = [UIColor whiteColor];
            addressName.font = [UIFont systemFontOfSize:14.0];
            
            [addressView addSubview:addressName];
            
            UILabel *addressmobile = [[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH/2+10, 5, SIZE_WIDTH/2-20, 30)];
            addressmobile.text =[NSString stringWithFormat:@"电话:%@",[[addressList objectAtIndex:0] valueForKey:@"mobile"]];
            addressmobile.textAlignment = NSTextAlignmentCenter;
            addressmobile.textColor = [UIColor whiteColor];
            addressmobile.font = [UIFont systemFontOfSize:14.0];
            
            [addressView addSubview:addressmobile];
            
            addressLabel.text =[NSString stringWithFormat:@"地址:%@",[[addressList objectAtIndex:0] valueForKey:@"address"]];
            addressLabel.frame = CGRectMake(10, 20, SIZE_WIDTH-40, 40);
            addressLabel.textAlignment = NSTextAlignmentLeft;
            addressLabel.font = [UIFont systemFontOfSize:12.0];
            addressLabel.textColor = [UIColor whiteColor];
            
            [addressView addSubview:addressLabel];
            
            
            
        }
        
        [cell.contentView addSubview:addressView];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        
    }else if (indexPath.row == 1){
        
        
        UIView *OneView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 40)];
        OneView.backgroundColor = [UIColor whiteColor];
        
        UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH/4, 40)];
        addressLabel.text =@"预约时间 ";
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.font = [UIFont systemFontOfSize:12.0];
        addressLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
        
        [OneView addSubview:addressLabel];
        
        
        TimeYYY_title = [[UILabel alloc]initWithFrame:CGRectMake(SIZE_WIDTH-(SIZE_WIDTH/2)-30, 0, SIZE_WIDTH/2, 40)];
        TimeYYY_title.text =[orderProDictInfo valueForKey:@"bespoke_time"];;
        TimeYYY_title.textAlignment = NSTextAlignmentCenter;
        TimeYYY_title.font = [UIFont systemFontOfSize:12.0];
        TimeYYY_title.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.8];
        TimeYYY_title.userInteractionEnabled = YES;
        TimeYYY_title.enabled = YES;
        
        [OneView addSubview:TimeYYY_title];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        [cell.contentView addSubview:OneView];

        
     //   cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        
    }else if (indexPath.row == 2){
        
        UIView *CellBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 30)];
        CellBackView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        UILabel *LabelName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SIZE_WIDTH/3, 20)];
        LabelName.text = @"预约项目";
        LabelName.font = [UIFont systemFontOfSize:12.0];
        LabelName.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.6];
        
        [cell.contentView addSubview:CellBackView];
        [cell.contentView addSubview:LabelName];
        
    }else if (indexPath.row == arrayMutableProduct.count+3){
        
        
        UIView *ProductView =  [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 270)];
        
        //产品图片
        
        
        AsynImageView *asynImageView=[[AsynImageView alloc]initWithFrame:CGRectMake(5, 10, SIZE_WIDTH-10, 180)];
        asynImageView.placeholderImage=[UIImage imageNamed:@"scroM.png"];
        asynImageView.imageURL=[NSString stringWithFormat:@"%@",[orderProDictInfo valueForKey:@"main_img"]];
        asynImageView.imageURL = [NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],asynImageView.imageURL];
        asynImageView.layer.cornerRadius = 8;
        asynImageView.layer.masksToBounds = true;
        asynImageView.contentMode = UIViewContentModeRedraw;
        asynImageView.clipsToBounds=YES;
        
        [ProductView addSubview:asynImageView];
        
        //产品名称
        UILabel *ProDuctName = [[UILabel alloc]initWithFrame:CGRectMake(20, asynImageView.frame.size.height+10, SIZE_WIDTH-30, 30)];
        ProDuctName.text = [NSString stringWithFormat:@"%@",[orderProDictInfo valueForKey:@"title"]];
        ProDuctName.font = [UIFont systemFontOfSize:14.0];
        ProDuctName.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
        
        
        [ProductView addSubview:ProDuctName];
        
        //产品数量
        ProNum = [[UILabel alloc]initWithFrame:CGRectMake(20,asynImageView.frame.size.height+50, SIZE_WIDTH-30, 20)];
        ProNum.text = [NSString stringWithFormat:@"数量 :%@",[orderProDictInfo valueForKey:@"product_number"]];
        ProNum.font = [UIFont systemFontOfSize:12.0];
        ProNum.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:1.0];
        
        [ProductView addSubview:ProNum];
        
        
        
        //产品价格
        CGFloat HeiGht = ProDuctName.frame.size.height + ProNum.frame.size.height;
        
        ProPrice = [[UILabel alloc]initWithFrame:CGRectMake(asynImageView.frame.size.width+20, HeiGht, SIZE_WIDTH-asynImageView.frame.size.width-30, 25)];
        ProPrice.text = [NSString stringWithFormat:@"价格 : ¥%@",[orderProDictInfo valueForKey:@"price"]];
        ProPrice.font = [UIFont systemFontOfSize:14.0];
        ProPrice.textColor =  [UIColor colorWithRed:240/255.0 green:68/255.0 blue:68/255.0 alpha:0.8];
                
        [ProductView addSubview:ProPrice];
        
        [cell.contentView addSubview:ProductView];
    
    } else if (indexPath.row == arrayMutableProduct.count+4){
        

        UILabel *SgNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SIZE_WIDTH/5, 30)];
        SgNum.text = @"合计 :";
        SgNum.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.7];
        SgNum.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:SgNum];
        
        HJPricNum = [[UILabel alloc]initWithFrame:CGRectMake(10+(SIZE_WIDTH/5), 5, SIZE_WIDTH/2, 30)];
        HJPricNum.text =[NSString stringWithFormat:@"¥%@",[orderProDictInfo valueForKey:@"totalprice"]];
        HJPricNum.textAlignment = NSTextAlignmentLeft;
        HJPricNum.textColor = [UIColor colorWithRed:240/255.0 green:68/255.0 blue:68/255.0 alpha:0.8];
        HJPricNum.font = [UIFont systemFontOfSize:14.0];
        
        [cell.contentView addSubview:HJPricNum];
        
    }else if (indexPath.row == arrayMutableProduct.count+5){
        

        
        UIView *ScureesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 40)];
        ScureesView.backgroundColor = [UIColor whiteColor];
        
        UILabel *SgNum = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SIZE_WIDTH/5, 30)];
        SgNum.text = @"实付金额 :¥";
        SgNum.textColor = [UIColor redColor];
        SgNum.font = [UIFont systemFontOfSize:14.0];
        
        SFPricNum = [[UILabel alloc]initWithFrame:CGRectMake(SgNum.frame.size.width+15, 5, SIZE_WIDTH/2, 30)];
        SFPricNum.text =[NSString stringWithFormat:@"%@",[orderProDictInfo valueForKey:@"totalprice"]];
        SFPricNum.textAlignment = NSTextAlignmentLeft;
        SFPricNum.textColor = [UIColor colorWithRed:240/255.0 green:68/255.0 blue:68/255.0 alpha:0.8];
        SFPricNum.font = [UIFont systemFontOfSize:14.0];
        
        
        [ScureesView addSubview:SgNum];
        [ScureesView addSubview:SFPricNum];
        
        [cell.contentView addSubview:ScureesView];
        
    }else if (indexPath.row == arrayMutableProduct.count+6){
        
        UIView *ScureesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 40)];
        ScureesView.backgroundColor = [UIColor whiteColor];
        
        UILabel *BZLable = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, SIZE_WIDTH/2, 30)];
        BZLable.text = @"备注:如对产品有详细要求请提出";
        BZLable.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.4];
        BZLable.font = [UIFont systemFontOfSize:12.0];
        
        [ScureesView addSubview:BZLable];
        
        [cell.contentView addSubview:ScureesView];
        
    }else if (indexPath.row == arrayMutableProduct.count+7){
        
        UIView *CellBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 30)];
        CellBackView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        UILabel *LabelName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SIZE_WIDTH/3, 20)];
        LabelName.text = @"选择付款方式";
        LabelName.font = [UIFont systemFontOfSize:14.0];
        LabelName.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.6];
        
        [cell.contentView addSubview:CellBackView];
        [cell.contentView addSubview:LabelName];
        
    }else if (indexPath.row == arrayMutableProduct.count+8){
        
        UIView *ScureesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 40)];
        ScureesView.backgroundColor = [UIColor whiteColor];
        
        
        UIImageView *imageWX = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 30, 30)];
        imageWX.image = [UIImage imageNamed:@"wxTB.png"];
        
        [ScureesView addSubview:imageWX];
        
        UILabel *LabelName = [[UILabel alloc]initWithFrame:CGRectMake(20+imageWX.frame.size.width, 10, SIZE_WIDTH/3, 20)];
        LabelName.text = @"微信支付";
        LabelName.font = [UIFont systemFontOfSize:16.0];
        LabelName.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.8];
        
        SelectButWX = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        SelectButWX.frame = CGRectMake(SIZE_WIDTH-40, 10, 20, 20);
        SelectButWX.tag = 1;
        [SelectButWX setBackgroundImage:[UIImage imageNamed:@"PayButYes.png"] forState:UIControlStateNormal];
        
        [ScureesView addSubview:LabelName];
        [ScureesView addSubview:SelectButWX];
        cell.accessoryType= UITableViewCellAccessoryNone;
        [cell.contentView addSubview:ScureesView];
        
    }else if (indexPath.row == arrayMutableProduct.count+9){
        
        UIView *ScureesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 50)];
        ScureesView.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageWX = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 30, 30)];
        imageWX.image = [UIImage imageNamed:@"zfbTB.png"];
        
        [ScureesView addSubview:imageWX];
        
        
        UILabel *LabelName = [[UILabel alloc]initWithFrame:CGRectMake(20+imageWX.frame.size.width, 10, SIZE_WIDTH/3, 20)];
        LabelName.text = @"支付宝支付";
        LabelName.font = [UIFont systemFontOfSize:14.0];
        LabelName.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.8];
        
        SelectButZFB = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        SelectButZFB.frame = CGRectMake(SIZE_WIDTH-40, 10, 20, 20);
        SelectButZFB.tag = 2;
        
        if(pay_Type ==1){
            
            [SelectButZFB setBackgroundImage:[UIImage imageNamed:@"PayButNo.png"] forState:UIControlStateNormal];
        }
        if (pay_Type ==2) {
            
            [SelectButZFB setBackgroundImage:[UIImage imageNamed:@"PayButYes.png"] forState:UIControlStateNormal];
        }
        
        [ScureesView addSubview:LabelName];
        [ScureesView addSubview:SelectButZFB];
        cell.accessoryType= UITableViewCellAccessoryNone;
        [cell.contentView addSubview:ScureesView];
        
    } else if (indexPath.row == arrayMutableProduct.count+10){
        
        UIView *ScureesView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 70)];
        ScureesView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        
        UILabel *NowLaBle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SIZE_WIDTH, 30)];
        NowLaBle.userInteractionEnabled = YES;
        NowLaBle.text = @"1.服务开始前 您可致电客服修改订单！仅有一次机会";
        NowLaBle.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.6];
        NowLaBle.font = [UIFont systemFontOfSize:14.0];
        NowLaBle.lineBreakMode = NSLineBreakByWordWrapping;
        NowLaBle.numberOfLines = 0;
        
        [ScureesView addSubview:NowLaBle];
        
        UIButton *DeleteBut = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [DeleteBut setBackgroundImage:[UIImage imageNamed:@"checkbox_pressed.png"] forState:UIControlStateNormal];
        
        DeleteBut.frame = CGRectMake(10, 30, 20,20);
        [DeleteBut addTarget:self action:@selector(DeleteButFunc:) forControlEvents:UIControlEventTouchUpInside];
        
        [ScureesView addSubview:DeleteBut];

        UILabel *DelegateText = [[UILabel alloc]initWithFrame:CGRectMake(30, 30, SIZE_WIDTH*2/3, 20)];
        DelegateText.userInteractionEnabled = YES;
        DelegateText.text = @"我已阅读并同意《时光服务平台协议》";
        DelegateText.textColor = [UIColor blackColor];
        DelegateText.font = [UIFont systemFontOfSize:14.0];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TouchDelegateFunc:)];
        [DelegateText addGestureRecognizer:tapGesture];
        
        [ScureesView addSubview:DelegateText];
        
        [cell.contentView addSubview:ScureesView];
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

#pragma mark -返回每一行的高度大小
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSInteger arrayCount = arrayMutableProduct.count;
    

    NSInteger arrayCount = 1;
    
    if (indexPath.row == 0) {
        
        return 70;
    }
    if (indexPath.row == 1) {
        
        return 40;
    }
    if (indexPath.row == 2) {
        
        return 30;
    }
    if (indexPath.row == 3+arrayCount ) {
        
        if([[[arrayMutableProduct objectAtIndex:0] valueForKey:@"type"] intValue]== 1){
            
            return 1;
            
        }else{
            
            return 50;
        }
    }
    if (indexPath.row == 3+arrayCount+1 ) {
        
        return 40;
    }
    if (indexPath.row == 3+arrayCount+2 ) {
        
        return 40;
    }
    if (indexPath.row == 3+arrayCount+3 ) {
        
        return 30;
    }
    if (indexPath.row == 3+arrayCount+4 ) {
        
        return 50;
    }
    if (indexPath.row == 3+arrayCount+5 ) {
        
        return 50;
    }
    if (indexPath.row == 3+arrayCount+6 ) {
        
        return 70;
    }
//    if (indexPath.row == 3+arrayCount+6 ) {
//        
//        return 40;
//    }
    
    return 270;
    
}

#pragma mark -tableview select选择
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserAddressController *userAddresCon = [[UserAddressController alloc]init];
    
    if (indexPath.row == 0) {
        
        userAddresCon.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:userAddresCon animated:YES];
        
        
    }
    
    if (indexPath.row == 1) {
        
        
    }

    
    if (arrayMutableProduct.count+8 == indexPath.row) {
        
        NSLog(@"%ld",(long)indexPath.row);
        
        pay_Type = 1;
        [SelectButWX setBackgroundImage:[UIImage imageNamed:@"PayButYes.png"] forState:UIControlStateNormal];
        [SelectButZFB setBackgroundImage:[UIImage imageNamed:@"PayButNo.png"] forState:UIControlStateNormal];
        return;
        
    }
    if (arrayMutableProduct.count+9 == indexPath.row){
        
        NSLog(@"%ld",(long)indexPath.row);
        
        pay_Type = 2;
        [SelectButWX setBackgroundImage:[UIImage imageNamed:@"PayButNo.png"] forState:UIControlStateNormal];
        [SelectButZFB setBackgroundImage:[UIImage imageNamed:@"PayButYes.png"] forState:UIControlStateNormal];
        return;
    }

    
}


#pragma mark -下单按钮
-(void)OriderFuncss{
    
    UIButton *_OrderBut = [UIButton buttonWithType:UIButtonTypeCustom];
    _OrderBut.frame = CGRectMake(0, SIZE_HEIGHT-50, SIZE_WIDTH, 50);
    [_OrderBut setTitle:@" 立即支付 " forState:UIControlStateNormal];
    [_OrderBut setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_OrderBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateNormal];
    [_OrderBut setBackgroundImage:[UIImage imageNamed:@"sms_but.png"] forState:UIControlStateHighlighted];
    [_OrderBut addTarget:self action:@selector(OrderProductFuncss:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_OrderBut];
    
}

-(void)proBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark -下单支付事件
-(void)OrderProductFuncss:(id)sender{
    
    
    if (TimeYYY_title.text.length<=8) {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择服务时间!" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
    }
    
    if ([deleteButStatus isEqualToString:@"0"]) {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"请确认遵守时光协议!" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
        
    }

    if (pay_Type == 1) {
        
        [self weChatPayButtonAction];
        
    }else if(pay_Type == 2 ){
    
        [self doAlipayPay];
        
    }else{
        
    }
}




//
//选中商品调用支付宝极简支付
//
- (void)doAlipayPay
{
    //重要说明
    //这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    //真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    //防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"2016103002420994";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBANOjVjNha+G8RX1uRSPPgdxryKmnfZpGjSZSFMhVQuTpN/Q0NwM5VkBMNBI6NiMYld8A4r3XQYJZoNJpEqSKPsa0QlZ3WU2FhadaRSZ+c8PrH67HLcOYqAUQ4gWeJQwN++IBeszL3d4GtOBMePHflRe2EqXvf4WM/mxBwMWBhFwhAgMBAAECgYBTC2CjwLKIXUwXL9HJf39BcrnGeIZ8pvpz8vlcsrgRAsKF/IcpqLIDgONd06Gym88TNlHClFiMQYctiTVbgzOmJeucHyFehAdwlhl2dR4jf1PaF8D7Ec+NymIA0wt4rOr3h7JiJyOV+7xJT70eW3wZXAdH8pDukBe4yV6qdfbFwQJBAPQ4dmwihK6LGqkHQOa+WQjr99b3zW5EB0IKyUGnjTTKil0q1x7AGKcy/Hq8lMQHBgA6UpZW4Jr/v7lDj2n23XUCQQDd2I7ncPHM2FakUeF3K45ZJkgBQ0XlegQAI7J+2f/HwV2CNS649xhS8Q5ERcKaCYqPuze8JDaOJPi8qH8xyBJ9AkEA0M3pqkDFEnrKe5RBEEfU1gTybPCHyuwNDJEuS50W5Pj63fd/38G8ElBMgB/2Tbf3kIBNFk8HUF6zrJGv75hq9QJAZSDaC/D1mO6pmGBnCj8Ftef4fPLgwvn7JuEe9iqEKdggu0FpGhIxuWV/nmm6iyN8UYcDojVT1TpPVRjuWpActQJAKEY5GUmhzufEL6CdqjyzpfJ9sPGRmSF25y/sFXhttq7+uaKr8TH/6LPKQSVIoWN26GFGwcuVJzGc6PsiQ+m7vQ==";    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付异常,请稍后再试！" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Order* order = [Order new];
    
    // NOTE: app_id设置
    order.app_id = appID;
    
    // NOTE: 支付接口名称
    order.method = @"alipay.trade.app.pay";
    
    // NOTE: 参数编码格式
    order.charset = @"utf-8";
    
    // NOTE: 当前时间点
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    order.timestamp = [formatter stringFromDate:[NSDate date]];
    
    // NOTE: 支付版本
    order.version = @"1.0";
    
    // NOTE: sign_type 根据商户设置的私钥来决定
    order.sign_type = (rsa2PrivateKey.length > 1)?@"RSA2":@"RSA";
    
    // NOTE: 商品数据
    order.biz_content = [BizContent new];
    order.biz_content.body = [NSString stringWithFormat:@"%@",[orderProDictInfo valueForKey:@"title"]];
    order.biz_content.subject = [NSString stringWithFormat:@"%@",[orderProDictInfo valueForKey:@"title"]];
    order.biz_content.out_trade_no = [orderProDictInfo valueForKey:@"orderid"]; //订单ID（由商家自行制定）
    order.biz_content.timeout_express = @"30m"; //超时时间设置
    NSString *paynumstr = SFPricNum.text;
    float pricePro = [paynumstr floatValue];
    NSLog(@"pricePro%f=====",pricePro);
    order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f",pricePro]; //商品价格
    
    //将商品信息拼接成字符串
    NSString *orderInfo = [order orderInfoEncoded:NO];
    NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
    NSLog(@"orderSpec = %@",orderInfo);
    
    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
    NSString *signedString = nil;
    RSADataSigner* signer = [[RSADataSigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
    if ((rsa2PrivateKey.length > 1)) {
        signedString = [signer signString:orderInfo withRSA2:YES];
    } else {
        signedString = [signer signString:orderInfo withRSA2:NO];
    }
    
    // NOTE: 如果加签成功，则继续执行支付
    if (signedString != nil) {
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"BeautifulTimeapp";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                 orderInfoEncoded, signedString];
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    }
}


#pragma mark -微信支付
-(void)weChatPayButtonAction{
    
    //先调用统一下单接口
    //http://ddp.lzsg120.com/order/iosorder.do?id=160725190415543092009&price=1&userid=admin&paytype=1&num=1&needtime=2016-12-05
    
    @try {

        NSString *orderDefluts = ios_orderinfo;
        NSString *strTexts = [TimeYYY_title.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *aids = [[addressList objectAtIndex:0] valueForKey:@"id"];
        NSString *paynumstrs = [NSString stringWithFormat:@"%ld",(long)payNum];
        NSString *order_uRLs = [NSString stringWithFormat:@"%@%@id=%@&price=%@&userid=%@&paytype=11&num=%@&needtime=%@&aid=%@",[USER_DEFAULT objectForKey:@"SERVERIP"],orderDefluts,[orderProDictInfo valueForKey:@"orderid"],SFPricNum.text,[USER_DEFAULT objectForKey:@"user_id"],paynumstrs,strTexts,aids];
        NSLog(@"order_uRL----%@",order_uRLs);
        
        //创建链接
        manager = [AFHTTPSessionManager manager];
        
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];

        //发送请求
        [manager GET:order_uRLs parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

            @try {
                
                PayReq *request = [[PayReq alloc] init];
                request.partnerId = @"1407117902";
                request.prepayId=  [[responseObject objectAtIndex:0] valueForKey:@"prepay_id"];
                request.package = @"Sign=WXPay";
                request.nonceStr= [[responseObject objectAtIndex:0] valueForKey:@"nonce_str"];
                request.timeStamp= [[[responseObject objectAtIndex:0] valueForKey:@"timestamp"] intValue];
                request.sign=[[responseObject objectAtIndex:0] valueForKey:@"sign"];
                [WXApi sendReq:request];
                
            } @catch (NSException *exception) {
                
                UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付有问题!请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
                
                
                [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }]];
                
                [self presentViewController:alertCon animated:YES completion:nil];

            }
           
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            
            UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付有问题!请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
            
            
            [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }]];
            
            [self presentViewController:alertCon animated:YES completion:nil];
            
        }];
        
    }
    @catch (NSException *exception) {
        
        NSLog(@"exception%@",exception);
        
        UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"支付有问题!请稍后再试" preferredStyle:UIAlertControllerStyleAlert];
        
        
        [alertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        [self presentViewController:alertCon animated:YES completion:nil];
        
    }
    @finally {
        
    }
    
}

#pragma mark -协议服务条款触摸事件

-(void)TouchDelegateFunc:(id)sender{

    DeleteController *delegateCon = [[DeleteController alloc]init];
    delegateCon.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:delegateCon animated:YES];
    
}

#pragma mark -touchtime 选择时间
-(void)touchtime:(id)sender{
    
    //    act=[[UIActivityIndicatorView  alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    //
    //    //设置 风格;
    //    act.activityIndicatorViewStyle=UIActivityIndicatorViewStyleGray;
    //    //设置活动指示器的颜色
    //    act.color=[UIColor redColor];
    //    //hidesWhenStopped默认为YES，会隐藏活动指示器。要改为NO
    //    act.hidesWhenStopped=NO;
    //    //启动
    //    [self.view addSubview:act];
    
    [self getTimeYu];
    
}


#pragma mark -动画

-(void)anmindfunc{
    
    [self.view addSubview:backgroundview];
    
    [backgroundview addSubview:pickerTimeview];
    
    [UIView animateWithDuration:0.0 animations:^{
        
        CGPoint point = backgroundview.center;
        point.y = SIZE_HEIGHT/2;
        [backgroundview setCenter:point];
        
    } completion:^(BOOL finished) {
        
        UITapGestureRecognizer *tapbackgroundview = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Closefunc:)];
        [backgroundview addGestureRecognizer:tapbackgroundview];
        //动画完成后执行
    }];
    
    //提交动画
    [UIView commitAnimations];
    
}

#pragma mark-关闭时间选择器窗体动画
-(void)Closefunc:(id)sender{
    
    CGPoint point = backgroundview.center;
    point.y = point.y+SIZE_HEIGHT;
    [backgroundview setCenter:point];
    
    [UIView animateWithDuration:0.0 animations:^{
        
        CGPoint point = backgroundview.center;
        point.y = point.y+SIZE_HEIGHT;
        [backgroundview setCenter:point];
        
    } completion:^(BOOL finished) {
        
    }];
    
}

#pragma mark -pickerView确定按钮事件
-(void)pickerViewBtnOK:(id)sender{
    
    
    NSString * timeLabelStr = [pickerTimeview getPickerviewValue];
    
    TimeYYY_title.text =timeLabelStr;
    
    [self Closefunc:(id)sender];
    
}

#pragma mark -pickerView取消按钮事件
-(void)pickerViewBtnCancel:(id)sender{
    
    [self Closefunc:(id)sender];
}


#pragma mark -时间接口
-(void)getTimeYu{
    
    
    NSString *TimeUrl = service_time_list;
    NSString *URL =[USER_DEFAULT objectForKey:@"SERVERIP"];
    NSString *strUrl =[NSString stringWithFormat:@"%@%@",URL,TimeUrl];
    
    manager = [AFHTTPSessionManager manager];
    [act startAnimating];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送请求
    
    
    [manager GET:strUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //        NSLog(@"responseObject%@",responseObject);
        
        letter = responseObject;
        
        //停止
        
   //     [self loadDatapicker];
        //
        [self anmindfunc];
        
        //     [act stopAnimating];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"----失败----");
        
        //    [act stopAnimating];
        
        
    }];
}



#pragma mark -请求地址列表
-(void)GetAdressListFunc{
    
    //添加参数
    
    NSDictionary *parameters=@{@"user_id":[USER_DEFAULT objectForKey:@"user_id"]};
    NSString *AdressUrlList = service_address_list;
    NSString *strurGetAddressUrl=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],AdressUrlList];
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:strurGetAddressUrl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObjectaddress%@",responseObject);
        
        addressList = [[NSMutableArray alloc]initWithArray:responseObject];
        
        
        [TabLeView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}


#pragma mark -协议按钮事件
-(void)DeleteButFunc:(UIButton *)sender{
  
    if (sender.selected == NO) {
        
        deleteButStatus= @"0";
        sender.selected = YES;
        [sender setTintColor:[UIColor whiteColor]];
        [sender setBackgroundImage:[UIImage imageNamed:@"checkbox_normal.png"] forState:UIControlStateNormal];
        
    }else{
        sender.selected = NO;
        deleteButStatus= @"1";
        [sender setBackgroundImage:[UIImage imageNamed:@"checkbox_pressed.png"] forState:UIControlStateNormal];
        
    }
    
}



#pragma mark -标签点击事件
-(void)BQEventFunc:(UIButton *)sender{
    
    NSInteger indexofbut = sender.tag;
    NSLog(@"xxxx");
    
    for (UIButton *but in arrayBut) {
        
        NSLog(@"indexofbut%ld",(long)indexofbut);
        
        if(but.tag == indexofbut){
            
            NSLog(@"indexofbut%ld",(long)indexofbut);
            [but setTitleColor:[UIColor colorWithRed:251/255.0 green:106/255.0 blue:42/255.0 alpha:0.6] forState:UIControlStateNormal];
            but.layer.borderColor = [[UIColor colorWithRed:249/255.0 green:176/255.0 blue:82/255.0 alpha:0.4] CGColor];
            
        }else{
            
            [but setTitleColor:[UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.6] forState:UIControlStateNormal];
            but.layer.borderColor = [[UIColor colorWithRed:225/255.0 green:225/255.0 blue:225/255.0 alpha:0.4] CGColor];
            
        }
        
        
    }

    bqNumindex = indexofbut;
    
    Pro_id =  [[emapArray objectAtIndex:indexofbut] valueForKey:@"id"];
    
    NSString *pricestr = [[emapArray objectAtIndex:indexofbut] valueForKey:@"price"];
    
    float  PRICE  =pricestr.floatValue * payNum;
    
    ProPrice.text = [NSString stringWithFormat:@"价格 : ¥%@",pricestr];
    
    HJPricNum.text =[NSString stringWithFormat:@"¥%.2lf",PRICE];
    
    SFPricNum.text =[NSString stringWithFormat:@"%.2lf",PRICE];
    
    
}


#pragma mark -wx回调协议方法
-(void)getOrderPayResult:(NSNotification *)notification{
    
    OrderMessageController *orderMessageCon = [[OrderMessageController alloc]init];
    orderMessageCon.dictProduct =orderProDictInfo;
    orderMessageCon.ordernum = [orderProDictInfo valueForKey:@"orderid"];
    [self.navigationController pushViewController:orderMessageCon animated:NO];
    
}

#pragma mar -zfb回调通知
-(void)zfbgetOrderPayResult:(NSNotification *)notiffication{
    
    [self changeOrderstatusFunc];
    
}



#pragma mark -请求地址列表
-(void)changeOrderstatusFunc{
    
    //添加参数
    
    NSDictionary *parameters=@{@"id":[orderProDictInfo valueForKey:@"orderid"]};
    NSString *orderstatusUrlList = iosorderupdate;
    NSString *orderurl=[NSString stringWithFormat:@"%@%@",[USER_DEFAULT objectForKey:@"SERVERIP"],orderstatusUrlList];
    
    //创建请求
    manager = [AFHTTPSessionManager manager];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; encoding=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    //发送POST请求
    
    [manager POST:orderurl parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"responseObject%@",responseObject);
        
        OrderMessageController *orderMessageCon = [[OrderMessageController alloc]init];
        orderMessageCon.dictProduct = orderProDictInfo;
        orderMessageCon.ordernum = [orderProDictInfo valueForKey:@"orderid"];
        [self.navigationController pushViewController:orderMessageCon animated:NO];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
