//
//  TagModel.h
//  TagViewDemo
//
//  Created by Pengbo on 2016/12/1.
//  Copyright © 2016年 Pengbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TagModel : NSObject
@property (strong,nonatomic)NSString * text;
@property (strong,nonatomic)NSString * color;
@property (nonatomic)NSInteger index;

+(NSMutableArray *)initData;
@end
