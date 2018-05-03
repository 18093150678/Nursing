//
//  MoreController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/19.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "MoreController.h"

@interface MoreController ()

@end

@implementation MoreController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *indexLabel =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    indexLabel.text = @"更多设置";
    [indexLabel setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    indexLabel.textColor = [UIColor blackColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = indexLabel;
    
    UIButton *MoreLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    MoreLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [MoreLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    MoreLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [MoreLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    [MoreLeftBack addTarget:self action:@selector(MoreBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *LeftbuttonItem = [[UIBarButtonItem alloc]initWithCustomView:MoreLeftBack];
    
    self.navigationItem.leftBarButtonItem = LeftbuttonItem;
    
    [self TableViewFunc];
}


-(void)viewWillAppear:(BOOL)animated{

    [self GetArrayDataFunc];

}

-(void)TableViewFunc{
    
    TableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SIZE_WIDTH, 3*45+3*15+19+49) style:UITableViewStylePlain];
    TableView.delegate = self;
    TableView.dataSource = self;
    // TableView.backgroundColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
    TableView.showsVerticalScrollIndicator = NO;
    [TableView setSeparatorColor:[UIColor colorWithRed:147/255.0
                                                 green:145/255.0
                                                  blue:145/255.0
                                                 alpha:0.2]];
    
    TableView.scrollEnabled = NO;
    
    [self.view addSubview:TableView];
   
    
}

#pragma mark 一共有多少组（section == 区域\组）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

#pragma mark -每一组有多少cell
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return  userInfoArray.count;
    
}
/*
 *
 *UITableView内部有一个缓存池，初始化时使用initWithStyle:(UITableViewCellStyle) 
 reuseIdentifier:(NSString *)方法指定一个可重用标识，就可以将这个cell放到缓存池。
 然后在使用时使用指定的标识去缓存池中取得对应的cell然后修改cell内容即可
 *
 */
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //可重用标识可以有多个，如果在UITableView中有多类结构不同的Cell，可以通过这个标识进行缓存和重新；
    
     //由于此方法调用十分频繁，cell的标示声明成静态变量有利于性能优化
 
    static NSString *cellIdentifier=@"UITableViewCellIdentifierKey1";
//    static NSString *cellIdentifierForFirstRow=@"UITableViewCellIdentifierKeyWithSwitch";
    //首先根据标识去缓存池取
    UITableViewCell *cell;
    
    if (cell == nil) {
        
          //如果缓存池没有到则重新创建并放到缓存池中
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //点击的选择样式
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    while ([cell.contentView.subviews lastObject] != nil)
    {
        [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

   

    
    if (indexPath.row ==0 || indexPath.row == 3 ||indexPath.row == 5) {
        
        UIView *NullCellView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE_WIDTH, 15)];
        NullCellView.backgroundColor =[UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:0.4];
        
        [cell.contentView addSubview:NullCellView];
        
    }else{
        
        NSString *cell_name = userInfoArray[indexPath.row];
        
        UIImageView *imageLogo = [[UIImageView alloc]initWithFrame:CGRectMake(10, 11, 20, 20)];
        NSString *imageName = [NSString stringWithFormat:@"Menuuserlogo_%ld.png",(long)indexPath.row];
        imageLogo.image = [UIImage imageNamed:imageName];
        
        [cell.contentView addSubview:imageLogo];
        
        UILabel *NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, SIZE_WIDTH/3, 20)];
        NameLabel.textColor = [UIColor colorWithRed:96/255.0 green:96/255.0 blue:96/255.0 alpha:0.9];
        NameLabel.text  = cell_name;
        NameLabel.font = [UIFont systemFontOfSize:12.0];
        
        [cell.contentView addSubview:NameLabel];
        
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
   
    }
    
   
    
   

    
    return cell;
}


#pragma mark -选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row==5) {
        
        return;
    }
    
    
    UIAlertController *AlertCon = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登陆吗?" preferredStyle:UIAlertControllerStyleAlert];
    
    
     UIAlertController *outMyAlert = [UIAlertController alertControllerWithTitle:@"提示" message:@"敬请期待" preferredStyle:UIAlertControllerStyleAlert];
    // 添加按钮
 

    DeleteController *deleteConss = [[DeleteController alloc]init];
    switch (indexPath.row) {
       
        case 1:
            
            deleteConss.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:deleteConss animated:YES];

            NSLog(@"---x4---");
            break;
        case 2:
            
            
            [outMyAlert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                
                NSLog(@"点击确定回调方法");
                
            }]];
            
            [self presentViewController:outMyAlert animated:YES completion:nil];

            
            NSLog(@"---x5---");
            break;

        case 4:
            
            
            [AlertCon addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                
                NSLog(@"点击取消回调方法");
                
            }]];

            
            [AlertCon addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                
                NSLog(@"点击确定回调方法");
                [USER_DEFAULT setObject:NULL forKey:@"UserName"];
                [USER_DEFAULT setObject:NULL forKey:@"user_id"];
                
                [self.navigationController popToRootViewControllerAnimated:YES];

                
            }]];
          
            [self presentViewController:AlertCon animated:YES completion:nil];
            break;

       
    }
    
}


#pragma mark -返回每行高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0 ) {
        
        return 15;
    }
    if (indexPath.row == 3 ) {
        
        return 15;
    }
    if (indexPath.row == 5) {
        
        return 15;
    }
    
    return 45;
}



-(void)GetArrayDataFunc{
    
    
    userInfoArray = @[@"nil",@"服务条款",@"关于我们",@"nil",@"退出登录",@"nil"];
    //  userInfoArray = [[NSMutableArray alloc]initWithObjects:@"我的订单",@"我的地址",@"意见反馈",@"用户协议",@"更多设置", nil];
    
}


-(void)switchValueChange:(id)sender{

    NSLog(@"---s--");
    UISwitch *_switchBut = (UISwitch *)sender;
    switch (_switchBut.tag) {
        case 1:

            if (_switchBut.on == NO) {
                
                NSLog(@"关闭广告");
                 [USER_DEFAULT setObject:@"1" forKey:@"myfrist"];
                
            }else{
            
                NSLog(@"开启广告");
                [USER_DEFAULT setObject:@"2" forKey:@"myfrist"];
            
            }
            break;
            
        case 2:
            
            if (_switchBut.on == NO) {
                
                NSLog(@"关闭通知");
                
            }else{
                
                NSLog(@"开启通知");
                
            }
            break;
            
        default:
            break;
    }
    
}

#pragma mark -返回按钮
-(void)MoreBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
