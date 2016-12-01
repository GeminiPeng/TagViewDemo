//
//  ViewController.m
//  TagViewDemo
//
//  Created by Pengbo on 2016/12/1.
//  Copyright © 2016年 Pengbo. All rights reserved.
//
#define kItemHeight 26
#define kMinimumLineSpacing 5
#define kMinimumInteritemSpacing 5

#define kSectionEdgeInsetsLeft 15
#define kSectionEdgeInsetsBottom 0
#define kSectionEdgeInsetsTop 5
#define kSectionEdgeInsetsRight 15

#define kMarginTop 134

#import "ViewController.h"
#import "TagCell.h"
#import "TagModel.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic,strong)NSMutableArray *oroginDataList;
@property (nonatomic,strong)NSMutableArray *selectedList;
@property (nonatomic,strong)NSMutableArray *unSelectedList;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.oroginDataList = [TagModel initData];
    
    for (int i=0; i<self.oroginDataList.count; i++) {
        if (i<8) {
            [self.selectedList addObject:self.oroginDataList[i]];
        }else {
            [self.unSelectedList addObject:self.oroginDataList[i]];
        }
    }
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger items = 1;
    if (section == 0) {
        items = [self.selectedList count];
    }else if (section == 1) {
        items = [self.unSelectedList count];
    }
    return items;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"tagCell" forIndexPath:indexPath];
    TagModel *model;
    if (indexPath.section==0) {
        model = self.selectedList[indexPath.row];
    }else if (indexPath.section == 1){
        model = self.unSelectedList[indexPath.row];
    }
    [cell setTitleString:model.text andColor:model.color];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView * view;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    }
    return view;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    UIEdgeInsets inset = UIEdgeInsetsMake(kSectionEdgeInsetsTop, kSectionEdgeInsetsLeft, 5, kSectionEdgeInsetsRight);
    if (section == 0) {
        if (self.selectedList.count == 0) {
            inset = UIEdgeInsetsMake(5, 15, 31, 15);
        }
    }else if (section == 1){
        if (self.unSelectedList.count == 0) {
            inset = UIEdgeInsetsMake(5, 15, 93, 15);
        }
    }
    return inset;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kMinimumLineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kMinimumInteritemSpacing;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = CGSizeZero;
    TagModel *model;
    if (indexPath.section == 0) {
        model = self.selectedList[indexPath.row];
    }else if (indexPath.section == 1){
        model = self.unSelectedList[indexPath.row];
    }
    size = [self calculateCellSize:model.text];
    return size;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(0, CGFLOAT_MIN);
    }
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 30);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //insert回到原来位置
        TagModel *model = self.selectedList[indexPath.row];
        NSInteger index = [self getObjectInListIndex:model];
        
        [self.unSelectedList insertObject:model atIndex:index];
        [self.selectedList removeObjectAtIndex:indexPath.row];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:index inSection:1];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
    }else if (indexPath.section == 1){
        [self.selectedList addObject:self.unSelectedList[indexPath.row]];
        [self.unSelectedList removeObjectAtIndex:indexPath.row];
        
        NSIndexPath *newIndexPath =[NSIndexPath indexPathForItem:self.selectedList.count-1 inSection:0];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
    }
}


#pragma mark- utils
//查询对象插入到原来合适的位置
- (NSInteger )getObjectInListIndex:(TagModel *)m{
    if (m) {
        [self.unSelectedList addObject:m];
        [self.unSelectedList sortUsingComparator:^NSComparisonResult(TagModel *obj1, TagModel *obj2) {
            NSInteger index1 = obj1.index;
            NSInteger index2 = obj2.index;
            return index1 > index2;
        }];
        NSInteger index = [self.unSelectedList indexOfObject:m];
        [self.unSelectedList removeObject:m];
        return index;
    }
    return [self.unSelectedList count]+1;
}

//通过text获取tag
- (TagModel *)getObjetInList:(NSString *)str {
    for (TagModel*model in self.oroginDataList) {
        if ([model.text isEqualToString:str]) {
            return model;
        }
    }
    return nil;
}

//计算cell size

- (CGSize)calculateCellSize:(NSString *)content {
//    CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(MAXFLOAT, kItemHeight) lineBreakMode:NSLineBreakByCharWrapping];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:content];
    NSRange allRange = [content rangeOfString:content];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0]range:allRange];
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [attrStr boundingRectWithSize:CGSizeMake(MAXFLOAT, kItemHeight) options:options context:nil].size;
    size.height = kItemHeight;
    size.width = floorf(size.width+20);
    return size;
}

#pragma mark- getter/setter
- (NSMutableArray *)selectedList {
    if (_selectedList == nil) {
        _selectedList = [NSMutableArray new];
    }
    return _selectedList;
}

- (NSMutableArray *)unSelectedList {
    if (_unSelectedList == nil) {
        _unSelectedList = [NSMutableArray new];
    }
    return _unSelectedList;
}

- (NSMutableArray *)oroginDataList {
    if (_oroginDataList == nil) {
        _oroginDataList = [NSMutableArray new];
    }
    return _oroginDataList;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
