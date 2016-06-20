//
//  LCTextLabel.m
//  网易新闻
//
//  Created by 李洋 on 16/6/17.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCTextLabel.h"
#import "LCChannel.h"

@interface LCTextLabel ()

@property (nonatomic, strong) LCChannel *channel;

@end

@implementation LCTextLabel

#define LCNormalSize 14
#define LCSelectedSize 18

+ (instancetype)channelWithText:(LCChannel *)channel {
    
    // 创建频道label
    LCTextLabel *textLabel = [[self alloc]init];
    
    // 开启用户可交互
    textLabel.userInteractionEnabled = YES;
    
    textLabel.channel = channel;
    
    // 文字居中
    textLabel.textAlignment = NSTextAlignmentCenter;
    
    // 设置字体大小
    textLabel.font = [UIFont systemFontOfSize:LCSelectedSize];
    
    // 设置文字
    textLabel.text = channel.tname;
    
    // 设置自适应
    [textLabel sizeToFit];
    
    // 再次设置字体
    textLabel.font = [UIFont systemFontOfSize:LCNormalSize];
    
    return textLabel;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSAssert(self.didTextLabel != nil, @"新闻频道view的label的点击回调不能为空");
    
    self.didTextLabel();
}
@end
