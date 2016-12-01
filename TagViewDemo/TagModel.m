//
//  TagModel.m
//  TagViewDemo
//
//  Created by Pengbo on 2016/12/1.
//  Copyright © 2016年 Pengbo. All rights reserved.
//

#import "TagModel.h"

@implementation TagModel

+(NSMutableArray *)initData {
    NSMutableArray *marray = [[NSMutableArray alloc]init];
    for (int i=0; i<[self arrayText].count; i++) {
        TagModel * tagM = [[TagModel alloc]init];
        tagM.index = i;
        tagM.text = [self arrayText][i];
        [marray addObject:tagM];
    }
    return marray;
}

+ (NSArray *)arrayText {
    return @[@"帅气",@"完美大人",@"好给力",@"好厉害",@"编程高手",@"设计师",@"有品位",@"色彩玩家",@"颜值高",@"善于沟通",@"牛逼闪闪",@"哈哈",@"潜力股",@"富二代",@"跑车一族",@"牛叉",@"泡妞高手",@"萝莉控",@"爱喝啤酒吃烧烤",@"外星人",@"妹子",@"妞妞",@"瓦窑",@"王美丽",@"土豪",@"冲锋枪啊"];
}
@end
