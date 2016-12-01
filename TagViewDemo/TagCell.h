//
//  TagCell.h
//  TagViewDemo
//
//  Created by Pengbo on 2016/12/1.
//  Copyright © 2016年 Pengbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *label;
-(void)setTitleString:(NSString *)title andColor:(NSString *)color;
@end
