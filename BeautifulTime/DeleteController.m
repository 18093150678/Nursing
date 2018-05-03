//
//  DeleteController.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/15.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "DeleteController.h"

@implementation DeleteController

-(void)viewDidLoad{

    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:243/255.0 green:241/255.0 blue:239/255.0 alpha:1.0];
    
    UILabel *ConTitleView = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    ConTitleView.textColor = [UIColor blackColor];
    ConTitleView.text = @"服务条款";
    [ConTitleView setFont:[UIFont fontWithName:@"ArialHebrew" size:16.0]];
    ConTitleView.textAlignment = NSTextAlignmentCenter;
    
    self.navigationItem.titleView = ConTitleView;
    
    UIButton *deleteLeftBack = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    deleteLeftBack.frame =CGRectMake(0, 0, 30, 30);
    [deleteLeftBack setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    deleteLeftBack.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [deleteLeftBack setTitle:@"\U0000e609" forState:UIControlStateNormal];
    
    [deleteLeftBack addTarget:self action:@selector(deleteBackFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *deleteLeftBarButton = [[UIBarButtonItem alloc]initWithCustomView:deleteLeftBack];
    
    self.navigationItem.leftBarButtonItem = deleteLeftBarButton;
    
    
    
    UIButton *RightBackDelete = [UIButton buttonWithType:UIButtonTypeSystem];
    RightBackDelete.frame = CGRectMake(0, 0, 30, 30);
    [RightBackDelete setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    RightBackDelete.titleLabel.font = [UIFont fontWithName:@"iconfont" size:16];
    [RightBackDelete setTitle:@"\U0000e60a" forState:UIControlStateNormal];
    [RightBackDelete addTarget:self action:@selector(DeletetellConFunc:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:RightBackDelete];
    
    self.navigationItem.rightBarButtonItem = RightButtonItem;


    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent = YES;
    
    
    
    

    UITextView *textView = [[UITextView alloc]initWithFrame:CGRectMake(5, 64, SIZE_WIDTH-10, SIZE_HEIGHT-64)];
    textView.backgroundColor = [UIColor colorWithRed:243/255.0 green:241/255.0 blue:239/255.0 alpha:1.0];
    textView.editable = NO;
    textView.text =@" 大肚婆协议 \n \n 本协议由您与甘肃新时代网络有限公司共同缔结，本协议经您确认同意后视为认可本协议全部内容，对双方均具有法律效力本协议中“大肚婆”，指由新时代有限公司（以下简称“新时代”）开发运营的、为用户提供上门护理服务的平台，平台上将展示优秀的护理师信息以及全国口碑良好的护理产品和护理仪器，您通过平台在线确认及支付，将与护理师建立服务合同，由护理师根据约定为您提供上门护理服务。协议内容及签署 \n \n 1.本协议内容包括协议正文及所有新时代已经发布的或将来可能发布的各类规则。所有规则为本协议不可分割的组成部分，与本协议正文具有同等法律效力。\n  2.您应当在使用大肚婆之前认真阅读全部协议内容，对于协议中以加粗字体显示的内容，您应当重点阅读。如您对协议有任何疑问的，应向大肚婆或者新时代咨询。只要您使用大肚婆服务，即视为您与大肚婆缔结本协议，本协议即对您产生约束，届时您不应以未阅读本协议的内容或者未获得大肚婆对您问询的解答等理由，主张本协议无效，或要求撤销本协议。\n  3.您承诺接受并遵守本协议的约定。如果您不同意本协议的约定，您应立即停止使用大肚婆服务。\n  4.大肚婆有权根据需要不时地制订、修改本协议及各类规则，并以公示的方式进行公告，不再单独通知您。变更后的协议和规则一经发布后，立即自动生效。如您不同意相关变更，应立即停止使用大肚婆服务。如您继续使用大肚婆服务，即表示您接受经修订的协议。\n\n注册 \n 1、注册者资格 在您完成注册程序或以其他大肚婆允许的方式实际使用平台服务时，您应当是具备完全民事权利能力和完全民事行为能力的自然人。若您不具备前述主体资格，则您及您的监护人应承担因此而导致的一切后果，且大肚婆有权注销（永久冻结）您的会员资格。\n  2、会员 \n （1）在您按照页面提示填写信息、提供资料、阅读并同意本协议并完成全部注册程序后或以其他大肚婆允许的方式实际使用平台服务时，您即成为大肚婆会员（亦称会员）。\n （2）在注册时，您应当按照法律法规要求，或注册页面的提示真实准确提供您的详细资料，并及时更新，以使之真实、及时、完整、准确。如有合理理由认为您提供的资料错误、不实或不完整的，平台有权通过电话或者短信、邮件等方式向您发出询问及/或要求改正的通知，并有权直接删除相应资料的处理，直至中止、终止对您提供部分或全部服务。大肚婆对此不承担任何责任，您将承担因此产生的任何直接或间接支出。\n （3）您应当准确填写并及时更新您提供的电子邮件地址、联系电话、联系地址、邮政编码等联系方式，以便大肚婆与您进行有效联系，因通过这些联系方式无法与您取得联系，导致您在使用平台服务过程中产生任何损失或增加费用的，应由您完全独自承担。\n \n 大肚婆服务 \n 1.大肚婆向会员提供在线护理服务的基本信息，同时提供在线交流、在线预订及第三方支付服务（以下简称“本服务”）。除非本服务条款另有其他明示规定，增加或强化目前本服务的任何新功能，包括所推出的新产品，均受到本服务条款之规范。\n  2. 平台仅仅是提供护理师、护理产品、用户的信息服务平台，用户通过在线确认选择护理师、护理产品及支付，与护理师建立上门护理服务合同关系。您应了解且明白，大肚婆所有信息均为护理师和产品厂家自行提供，尽管大肚婆在该等信息发布之前已对信息作了必要核查，但您务必自行核查发布信息的准确性、真实性以及合法性。大肚婆并不对所展示信息的准确性、真实性和合法性承担保证责任。如您发现该等展示的信息为虚假、违法信息，请立即告知大肚婆或者向新时代举报，我们将采取删除与屏蔽，以及其他相应的技术和法律手段阻止此类信息的发布。 \n  3.用户通过平台获取护理师信息后，在线下与护理师进行护理服务交易时，请务必遵守中国相关法律法规和本公司的规定。查验提供服务护理师的合法有效身份证明、资质证件、健康证等相关文件，以保护自身利益。大肚婆不对会员在线下的服务行为（包括但不限于用户通过大肚婆与护理室进行的线下服务行为以及用户私下接触护理师而不通过大肚婆而是私下向护理师付款等）引起的任何性质的纠纷负有任何性质的协助义务或承担任何形式的责任。会员应当通过法律途径自行解决其与护理师因此产生的任何纠纷。\n 4.护理师为您提供完服务后，您需要点击确认结束，您和护理师的服务合同履行完毕。 \n  5.您通过大肚婆支付的款项，大肚婆仅仅是暂时替护理师进行保管，大肚婆将根据与护理师之间的约定按期向护理师返还。如护理师的原因或者护理产品质量问题给您造成损害，一经核查属实，大肚婆将在您通过大肚婆支付款项范围内先行赔付您的损失。\n  6.您了解并同意，大肚婆有义务应政府部门（包括司法及行政部门）和合作方的要求，向其提供您在大肚婆填写的注册信息和交易纪录等必要信息。 \n \n  大肚婆使用规范 \n  在大肚婆上使用服务过程中，您承诺遵守以下约定： \n  1、在使用平台服务过程中实施的所有行为均遵守国家法律、法规等规范性文件及平台规定和要求，不违背社会公共利益或公共道德，不损害他人合法权益，不提出不合法、不合理要求，不违反本协议及相关规则。您如果违反前述承诺，产生任何法律后果的，您应以自己的名义独立承担所有的法律责任，并确保平台免于因此产生任何损失。\n  2、不以虚构或歪曲事实的方式不恰当评价护理师，尊重护理师的人权和劳动成果，如选择在大肚婆合作的其他门店提供服务，还应当遵守该门店的规定，如由于您的原因给大肚婆合作的门店造成损失，您应当承担全部赔偿责任。 \n  协议终止 \n  1.您自行删除大肚婆软件或者自行退出大肚婆，将视为您自愿中止或终止与大肚婆的合作关系。\n  2. 出现以下情况时，大肚婆有权封闭您的账户：\n （a）您注册信息中的主要内容不真实或不准确或不及时或不完整；\n  （b）您提供的联系方式错误或无法正常联系到您，且没有其他方式可以与您进行联系； \n  （c）护理师向您提供服务时，您提出不合理要求；\n （d）您与护理师私下达成服务协议，或者私下支付护理师费用。\n \n  其他 \n 本协议之效力、解释、变更、执行与争议解决均适用中华人民共和国法律。因本协议产生的争议，由新时代注册地有管辖权的人民法院解决。";
    
    [self.view addSubview:textView];

}


#pragma mark -拨打电话方法
-(void)DeletetellConFunc:(id)sender{

    UIWebView * callWebview = [[UIWebView alloc] init];
    NSString *tel = [NSString stringWithFormat:@"tel:%@",[USER_DEFAULT valueForKey:@"phone"]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:tel]]];

    [[UIApplication sharedApplication].keyWindow addSubview:callWebview];
    
}


-(void)deleteBackFunc:(id)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
