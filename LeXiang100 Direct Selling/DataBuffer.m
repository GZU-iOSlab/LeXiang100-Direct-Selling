//
//  DataBuffer.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-2.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "DataBuffer.h"

@implementation DataBuffer
@synthesize a1;
@synthesize a11;
@synthesize a111;
@synthesize keys;
@synthesize dataSource;
- (id)init{
    a1 = [[NSMutableArray alloc]initWithObjects:@"热点业务",@"资费套餐",@"增值业务",@"手机报",@"营销活动",@"家庭产品",@"基础服务",@"集团业务",@"优惠活动", nil];
    a11 = [[NSMutableArray alloc]initWithObjects:@"描述1",@"流量加油包3元",@"流量加油包10元",@"流量加油包20元",@"闲时流量包",@"WLAN包月20元",@"国内一卡多号",@"手机名片",@"农情气象",@"短信转发有礼",@"文史天地彩信版", nil];
    a111 = [[NSMutableArray alloc]initWithObjects:@"描述",@"当您产生高额流量后  3元",@"当您产生高额流量后  10元",@"当您产生高额流量后  20元",@"每月5元包含300M流量",@"在国内wlan不限时长", @"使用一张sim卡",@"把签名写到手机上",@"提供准确气象信息",@"转发赚取积分点",@"文史天地手机杂志",nil];
    keys = [[NSMutableArray alloc]initWithObjects:@"热点业务",@"资费套餐",@"动感地带套餐",@"神州行套餐",@"全球通套餐",@"增值业务", nil];
    //@"增值业务",@"手机报",@"营销活动",@"家庭产品",@"基础服务",@"集团业务",@"优惠活动",@"流量加油包3元",@"流量加油包10元",@"流量加油包20元",@"闲时流量包",@"WLAN包月20元",@"国内一卡多号",@"手机名片",@"农情气象",@"短信转发有礼",@"文史天地彩信版"
    //NSArray * serviceKind = [NSArray arrayWithObjects:@"热点业务",@"资费套餐",@"增值业务",@"手机报",@"营销活动",@"家庭产品",@"基础服务",@"集团业务",@"优惠活动", nil];
    NSArray * hotService = [NSArray arrayWithObjects:@"流量加油包3元",@"流量加油包10元",@"流量加油包20元",@"闲时流量包",@"WLAN包月20元",@"国内一卡多号",@"手机名片",@"农情气象",@"短信转发有礼",@"文史天地彩信版", nil];
    
    NSArray * expensesPackages = [NSArray arrayWithObjects:@"动感地带套餐",@"神州行套餐",@"全球通套餐", nil];
    NSArray * packages1 = [NSArray arrayWithObjects:@"随便套餐18元",@"随便套餐28元",@"随便套餐48元",@"随便套餐68元",@"随便套餐88元",@"随便套餐108元",@"随便套餐148元",@"动感地带G3网聊套餐16元", nil];
    NSArray * packages2 = [NSArray arrayWithObjects:@"大众套餐8元",@"大众套餐18元",@"大众套餐48元",@"大众套餐68元",@"大众套餐88元", nil];
    NSArray * packages3 = [NSArray arrayWithObjects:@"全球通本地58套餐",@"全球通本地88套餐",@"全球通本地128套餐",@"全球通商旅58套餐",@"全球通商旅88套餐",@"全球通商旅128套餐",@"全球通商旅158套餐",@"全球通商旅188套餐",@"全球通商旅288套餐",@"全球通商旅388套餐",@"全球通商旅588套餐",@"全球通商旅888套餐",@"全球通上网58套餐",@"全球通上网88套餐",@"全球通上网128套餐",@"全球通凤凰咨询包",@"全球通阅读包",@"全球通音乐包",@"全球通尊享包",@"全球通短信包",@"全球通彩信包", nil];
    NSArray * valueAddedService = [NSArray arrayWithObjects:@"移动数据流量套餐",@"短彩信套餐",@"12580综合服务业务",@"手机阅读",@"手机邮箱",@"手机动漫",@"手机视频",@"手机电视",@"手机音乐",@"手机游戏",@"天气预报",@"手机证券",@"通信助手",@"4G套餐", nil];
    //NSArray * valueAddedService1 = [NSArray arrayWithObjects:@"移动数据流量套餐",@"短彩信套餐",@"12580综合服务业务",@"手机阅读",@"手机邮箱",@"手机动漫",@"手机视频",@"手机电视",@"手机音乐",@"手机游戏",@"天气预报",@"手机证券",@"通信助手",@"4G套餐", nil];
//    NSArray * object4 = [NSArray arrayWithObjects:@"Shark",@"Salmon",@"Lion",@"Elephant", nil];
    NSArray * objects = [NSArray arrayWithObjects:hotService,expensesPackages,packages1,packages2,packages3,valueAddedService,nil];
    dataSource = [[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    
    return self;
}

@end
