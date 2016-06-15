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
/**
 *  标题
 */
@property (nonatomic, strong) UILabel *title;
/**
 *  页码计数器
 */
@property (nonatomic, strong) UIPageControl *pageCtl;
/**
 *  计时器
 */
@property (nonatomic, strong) NSTimer *timer;
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
        self.title.text = titles[0];
        self.pageCtl.numberOfPages = URLs.count;
        // 初始化结束在设置初始位置
        dispatch_async(dispatch_get_main_queue(), ^{
            // 判断图片数量是否大于1
            if (self.URLs.count > 1) {
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.URLs.count inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
                
                [self startTimer];
            }
        });
        
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
#pragma mark - 初始化控件
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
    
    // 创建标题label
    self.title = [[UILabel alloc]init];
    self.title.font = [UIFont systemFontOfSize:14.0];
    self.title.textColor = [UIColor whiteColor];
    [self addSubview:self.title];
    
    // 创建页码计数器
    self.pageCtl = [[UIPageControl alloc]init];
    self.pageCtl.hidesForSinglePage = YES;
    self.pageCtl.currentPageIndicatorTintColor = [UIColor blueColor];
    self.pageCtl.pageIndicatorTintColor = [UIColor orangeColor];
    self.pageCtl.backgroundColor = [UIColor grayColor];
    [self addSubview:self.pageCtl];
    // 设置计时器属性
    self.enableTimer = YES;
    self.timerInterval = 2.0;
}
#pragma mark - 计时器
/**
 *  启动计时器
 */
- (void)startTimer {
    if (!self.enableTimer) return;
    if (self.URLs.count <= 1) return;
    if (self.timer) return;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timerInterval target:self selector:@selector(loop) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 *  滚动图片
 */
- (void)loop {
    // 获取当前偏移
    CGFloat offsetX = self.collectionView.contentOffset.x;
    
    // 获取宽度
    CGFloat width = self.collectionView.bounds.size.width;
    
    // 计算得到当前页码
    NSInteger page = offsetX / width;
    
    // 修改偏移
    [self.collectionView setContentOffset:CGPointMake((page + 1) * width, 0) animated:YES];
}
/**
 *  删除计时器
 */
- (void)removeTimer {
    [self.timer invalidate];
    self.timer = nil;
}
#pragma mark - 代理协议
/**
 *  减速动画结束的时候调用这个方法
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //NSLog(@"%s", __FUNCTION__);
    // 获取偏移量
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 获取collectionView的宽
    CGFloat width = scrollView.bounds.size.width;
    
    // 计算当前页数
    NSInteger page = offsetX / width;
    
    NSLog(@"%zd",page);
    
    // 判断是否当前是否为第一页(最后一页)
    if (page == 0 || page == [self.collectionView numberOfItemsInSection:0] - 1) {
        page = page > 1 ?  page % self.URLs.count : self.URLs.count;
        self.collectionView.contentOffset = CGPointMake(page * width, 0);
    }
    
    self.title.text = self.titles[page % self.titles.count];
    
    self.pageCtl.currentPage = page % self.URLs.count;
    
}

/**
 *  当滚动动画结束时调用 (通过定时器滚动,并非手动拖拽)
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
//    NSLog(@"%s", __FUNCTION__);
    [self scrollViewDidEndDecelerating:scrollView];
}
/**
 *  开始拖动时候调用
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 停止计时器
    [self removeTimer];
}
/**
 *  停止拖拽的时候启动计时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}
#pragma mark - 数据源协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.URLs.count > 1 ? self.URLs.count * 3 : self.URLs.count;
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
    
    // 获取collectionView的宽高
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    CGFloat pageCtlW = [self.pageCtl sizeForNumberOfPages:self.URLs.count].width;
    
    // 设置边距
    CGFloat margin = 5;
    
    // 设置标题的frame
    CGFloat titleH = 30;
    CGFloat titleW = width - 3 * margin - pageCtlW;
    CGFloat titleX = margin;
    CGFloat titleY = height - titleH;
    self.title.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 设置分页计数器的frame
    CGFloat pageCtlH = titleH;
    CGFloat pageCtlX = width - pageCtlW - margin;
    CGFloat pageCtlY = titleY;
    self.pageCtl.frame = CGRectMake(pageCtlX, pageCtlY, pageCtlW, pageCtlH);
}
- (void)dealloc
{
    [self removeTimer];
}
@end
