//
//  LCHomeViewController.m
//  网易新闻
//
//  Created by 李洋 on 16/6/17.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCHomeViewController.h"
#import "LCTextLabel.h"
#import "LCChannel.h"
#import "LCNewsViewCell.h"
@interface LCHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
/**
 *  频道view
 */
@property (nonatomic, weak) IBOutlet UIScrollView *channelView;

@property (nonatomic, weak) IBOutlet UICollectionView *newsView;

@property (nonatomic, weak) IBOutlet UICollectionViewFlowLayout *layout;

/**
 *  频道数据
 */
@property (nonatomic, strong) NSArray *channels;
/**
 *  控制器缓存池
 */
@property (nonatomic, strong) NSMutableDictionary *channelVcs;
/**
 *  当前选中按钮
 */
@property (nonatomic, strong) LCTextLabel *currentTextLabel;
@end

@implementation LCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置频道view
    [self setupChannel];

}
#pragma mark - 设置collectionView的layout
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self setupLayout];
}
/**
 *  设置collectionView的layout
 */
- (void)setupLayout {
    
    // 设置item的大小
    self.layout.itemSize = self.newsView.bounds.size;
    
    // 隐藏滚动条
    self.newsView.showsHorizontalScrollIndicator = NO;
    self.newsView.showsVerticalScrollIndicator = NO;
    
    // 设置item的行列间距
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    
    // 设置滚动方法
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置分页模式
    self.newsView.pagingEnabled = YES;
}
#pragma mark - collectionView数据源协议
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LCNewsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"channel" forIndexPath:indexPath];
    
    LCChannel *channel = self.channels[indexPath.item];
    
    // 判断缓存池中是否存在控制器
    if (self.channelVcs[channel.tid]) {
        // 存在就直接使用这个控制器的View
        cell.newsVc = self.channelVcs[channel.tid];
        return cell;
    }
    
    //创建sb
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"LCNewsViewController" bundle:nil];
    // 获得sb的控制器
    LCNewsViewController *vc = sb.instantiateInitialViewController;
    
    // 记录控制器,控制器的view是另一个控制器view的子类,那么这个控制器也要成为那个控制器的子类
    [self addChildViewController:vc];
    
    vc.URLSetring = channel.URLString;
    
    cell.newsVc = vc;
    
    // 存入缓存池
    [self.channelVcs setObject:vc forKey:channel.tid];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    return cell;
}
#pragma mark - collectionView的代理协议
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 获取偏移值
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 计算当前在哪一cell
    NSInteger channelPage = offsetX / scrollView.bounds.size.width;
    
    // 修改textlabel的选中状态
    LCTextLabel *label = self.channelView.subviews[channelPage];
    
    [self didTextLabelSelect:label];
}
#pragma mark - 设置频道view
- (void)setupChannel {
    /**
     *  ios8.0以后系统会自动设置scrollView的偏移量
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 隐藏滚动条
    self.channelView.showsHorizontalScrollIndicator = NO;
    self.channelView.showsVerticalScrollIndicator = NO;
    
    CGFloat labelX = 0;
    
    NSInteger index = 0;
    
    
    for (LCChannel *channel in self.channels) {
        LCTextLabel *label = [LCTextLabel channelWithText:channel];
        
        // 设置tag值
        label.tag = index++;
        
        __weak typeof(label) weakLabel = label;
        
//        NSLog(@"%f",labelX);
        
        label.didTextLabel = ^{
            // 点击跳转控制器
            [self didTextLabel:weakLabel.tag];
            
            // 设置label的选中状态
            [self didTextLabelSelect:weakLabel];
            
        };
        
        // 设置label的frame
        CGFloat labelH = self.channelView.bounds.size.height;
        CGFloat labelW = label.frame.size.width;
        CGFloat labelY = 0;
        label.frame = CGRectMake(labelX , labelY, labelW, labelH);
        // 添加到频道view中
        [self.channelView addSubview:label];
        // 获取下一个label的x值
        labelX += labelW;
        
    }
    // 设置频道view的实际滚动范围
    self.channelView.contentSize = CGSizeMake(labelX, 0);
    
    // 设置默认频道
    LCTextLabel *label = [self.channelView.subviews firstObject];
    
    [self didTextLabelSelect:label];
}
/**
 *  设置label的选中状态
 */
- (void)didTextLabelSelect:(LCTextLabel *)label {
    // 先把上一个的选中的label设置为原版状态,再来设置选中label的选中状态
    self.currentTextLabel.textColor = [UIColor blackColor];
    self.currentTextLabel.transform = CGAffineTransformMakeScale(1, 1);
    
    self.currentTextLabel = label;
    self.currentTextLabel.textColor = [UIColor orangeColor];
    CGFloat scale = ((CGFloat)(18 - 14) / 14) + 1;
    self.currentTextLabel.transform = CGAffineTransformMakeScale(scale, scale);
    
    // 设置频道view的偏移值
    // 判断选中的label的x值是否大有频道view中心点,如果大于就往中心点移动
    CGFloat center = self.channelView.center.x;
    CGFloat labelX = label.center.x;
    // 获取最大偏移值
    CGFloat maxOffsetX = self.channelView.contentSize.width - self.channelView.bounds.size.width;
    // 获取偏移值
    CGFloat offsetX = labelX - center;
    if (labelX > center) {
        offsetX = offsetX < maxOffsetX ? offsetX : maxOffsetX;
        [self.channelView setContentOffset:CGPointMake(offsetX , 0) animated:YES];
    } else {
        [self.channelView setContentOffset:CGPointMake(0 , 0) animated:YES];
    }
    
}
/**
 * 点击跳转控制器
 */
- (void)didTextLabel:(NSInteger)index {
    [self.newsView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
#pragma mark - 懒加载
- (NSArray *)channels {
    if (!_channels) {
        _channels = [LCChannel channels];
    }
    return _channels;
}
- (NSMutableDictionary *)channelVcs {
    if (!_channelVcs) {
        _channelVcs = [NSMutableDictionary dictionary];
    }
    return _channelVcs;
}
@end
