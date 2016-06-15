//
//  LCLoopViewLayout.m
//  网易新闻
//
//  Created by 李洋 on 16/6/15.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCLoopViewLayout.h"

@implementation LCLoopViewLayout
/**
 *  在准备完毕布局后会调用这个方法
 */
- (void)prepareLayout {
    [super prepareLayout];
    // 设置item的大小
    self.itemSize = self.collectionView.bounds.size;
    
    // 设置item的行列间距
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    
    // 设置item的滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 隐藏滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = 0;
    
    // 启动翻页效果
    self.collectionView.pagingEnabled = YES;
}

@end
