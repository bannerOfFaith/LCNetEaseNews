//
//  LCLoopView.m
//  网易新闻
//
//  Created by 李洋 on 16/6/15.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCLoopView.h"
#import "LCLoopViewLayout.h"
#import "LCLoopCell.h"

@interface LCLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  图片数组
 */
@property (nonatomic, strong) NSArray *URLs;
/**
 *  标题数组
 */
@property (nonatomic, strong) NSArray *titles;
/**
 *  无限轮播器
 */
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation LCLoopView

/**
 *  新闻头条
 *
 *  @param URLs   图片数组
 *  @param titles 标题数组
 */
- (instancetype)initWithURLs:(NSArray <NSString *>*)URLs titles:(NSArray <NSString *>*)titles {
    if (self = [super init]){
        // 初始化控件
        self.URLs = URLs;
        self.titles = titles;
//        NSLog(@"%@--%@",self.URLs,self.titles);
    }
    return self;
}
#pragma mark - 自定义初始化会调用下面的其中一个方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
#pragma mark - 创建一个collectionView
/**
 *  初始化控件
 */
- (void)setup{
    // 创建layout
    LCLoopViewLayout *layout = [[LCLoopViewLayout alloc]init];
    
    // 创建一个collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    // 注册cell
    [collectionView registerClass:[LCLoopCell class] forCellWithReuseIdentifier:@"loop"];
    
    // 设置数据源和代理
    collectionView.dataSource = self;
    collectionView.delegate = self;
    
    // 设置collectionView背景色
    collectionView.backgroundColor = [UIColor whiteColor];
    
//    // 设置collectinView的frame
//    collectionView.frame = self.bounds;
//    
//    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    
    // 添加到self中
    [self addSubview:collectionView];
    self.collectionView = collectionView;
}
#pragma mark - 代理协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%s", __FUNCTION__);
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"%s",__func__);
}
#pragma mark - 数据源协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.URLs.count * 3;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LCLoopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"loop" forIndexPath:indexPath];
    
//    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    cell.url = [NSURL URLWithString:self.URLs[indexPath.item % self.URLs.count]];
    
    return cell;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 设置collectinView的frame
    self.collectionView.frame = self.bounds;
}
@end
