//
//  LCLoopCell.m
//  网易新闻
//
//  Created by 李洋 on 16/6/15.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCLoopCell.h"
#import "UIImageView+WebCache.h"

@interface LCLoopCell ()
/**
 *  图片
 */
@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation LCLoopCell

#pragma mark - 自定义cell在初始化的时候回调用下列其中一个方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}
#pragma mark - 初始化控件
- (void)setup {
    self.iconView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.iconView];
}

#pragma mark - 重写setURL为iconView赋值
- (void)setUrl:(NSURL *)url {
    _url = url;
    [self.iconView sd_setImageWithURL:url];
}

#pragma mark - 布局控件
- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = self.bounds;
}

@end
