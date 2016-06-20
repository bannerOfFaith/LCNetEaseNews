//
//  LCNewsViewCell.m
//  网易新闻
//
//  Created by 李洋 on 16/6/18.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCNewsViewCell.h"
#import "LCNewsViewController.h"
#import "LCChannel.h"

@interface LCNewsViewCell ()

@end

@implementation LCNewsViewCell

- (void)setNewsVc:(LCNewsViewController *)newsVc {
    _newsVc = newsVc;
    [self.contentView addSubview:newsVc.view];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.newsVc.view.frame = self.bounds;
}


@end
