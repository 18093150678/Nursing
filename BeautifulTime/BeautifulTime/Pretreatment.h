//
//  Pretreatment.h
//  BeautifulTime
//
//  Created by MyBockPro on 16/11/4.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#ifndef Pretreatment_h
#define Pretreatment_h


#define SIZE_WIDTH [UIScreen mainScreen].bounds.size.width		//屏幕宽度
#define SIZE_HEIGHT [UIScreen mainScreen].bounds.size.height	//屏幕高度

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]
//wx.lzsg120.com:8081
//118.180.7.92:8088
//http://ddp.lzsg120.com
#define newurl                 @"http://ddp.lzsg120.com"


#define GetServeriPUrl         @"http://ddp.lzsg120.com/service_img_url.do";

#define Index_SrcoImageUrl     @"service_ad_list.do";
#define Index_menuUrl          @"service_index_diy.do";
#define Index_ProductList      @"service_product_list.do";

#pragma mark -产品id查询查询产品
#define product_urls           @"service_product_info.do?";

#pragma mark -问问问题列表
#define QuesttionUrl           @"service_wenwen_list.do";

#pragma mark -2次支付接口
#define ios_orderinfo          @"order/ios_orderinfo.do?";

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]

#pragma mark －登陆接口
#define LogingUrl              @"service_login.do";

#define TelCodeUrl             @"service_send_code.do";

#pragma mark -收货地址保存接口
#define service_address_save   @"service_address_save.do";

#pragma mark -地址列表
#define service_address_list   @"service_address_list.do";

#pragma mark -删除收获地址
#define service_address_del    @"service_address_del.do";

#pragma mark -修改收货地址
#define service_address_edit   @"service_address_edit.do";

#pragma mark -保存问问
#define service_wenwen_save    @"service_wenwen_save.do";

#pragma mark -订单列表  0-未支付 1-已支付 3-已完成  过期参数 guoqi 0-未过期 1-已过期  product_number参数含义-购买数量
//order_time 下单时间 pro_color -标签名称
#define service_order_list     @"service_order_list.do"

#pragma mark -微信统一下单接口
#define WX_orderUrl            @"order/iosorder.do?"

#pragma mark -appid
#define wxappid                @"wx002c4c8100c6173c";

#pragma mark －资讯分类地址
#define service_news_type      @"service_news_type.do";

#pragma mark -资讯列表
#define service_news_list      @"service_news_list.do";

#pragma mark -预约时间列表
#define service_time_list      @"service_time_list.do";

#pragma mark -意见反馈
#define service_feedback_save  @"service_feedback_save.do";

#pragma mark -待就诊列表，参数user_id
#define service_Waitingtreatment  @"yy_djz_list.do";

#pragma mark -取消就诊列表，参数user_id
#define service_Canceltreatment   @"yy_yqx_list.do";

#pragma mark -取消预约 参数2个，id订单id，user_id用户id
#define service_Cancelfunc        @"cancel_yuyue.do";

#pragma mark -我的报告单
#define service_Report            @"mycenter/my_bgd.htm";

#pragma mark -我的积分 参数列表 user_id 用户id
#define service_integral          @"service_jifen_list.do";

#pragma mark -约检查
#define service_yjc               @"service_yjc_list.do";

#pragma mark -首页三图接口
#define service_index_diy         @"service_index_diy.do";


#pragma mark -编辑个人信息接口
#define ios_edit_userinfo         @"ios_edit_userinfo.do";

#pragma mark -收藏接口
#define ios_favorite_add          @"ios_favorite_add.do";

#pragma mark -医生列表
#define ios_doctor_list           @"ios_doctor_list.do";

#pragma mark -孕期数据接口 参数uid
#define ios_wsym                  @"ios_wsym.do";

#pragma mark -用户头像图片地址 参数user_id 图片参数 filename
#define service_header_save       @"service_header_save.do";

#pragma mark -用户信息接口
#define service_userinfo          @"service_userinfo.do";

#pragma mark -支付宝支付获取订单地址
#define Alipay_orderUrl           @"order/iosorder1.do?"


#pragma mark -支付宝支付完成状态变更地址
#define iosorderupdate            @"order/iosorderupdate.do"


#pragma mark -问问标签
#define service_section_list      @"service_section_list.do"

#pragma mark -用户优惠券列表
#define ios_my_coupon             @"ios_my_coupon.do"

#endif /* Pretreatment_h */
