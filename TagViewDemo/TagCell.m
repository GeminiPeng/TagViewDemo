//
//  TagCell.m
//  TagViewDemo
//
//  Created by Pengbo on 2016/12/1.
//  Copyright © 2016年 Pengbo. All rights reserved.
//

#import "TagCell.h"

@implementation TagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _bgView.layer.cornerRadius = 13;
}

- (void)setTitleString:(NSString *)title andColor:(NSString *)color {
    [self.label setText:title];
    _bgView.backgroundColor = [self randomColor];
}

- (UIColor *)randomColor {
    
    CGFloat hue = (arc4random() %256 /256.0);
    CGFloat saturation = (arc4random()%128 / 256.0) + 0.5;
    CGFloat brightness = (arc4random()%128 / 256.0) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
