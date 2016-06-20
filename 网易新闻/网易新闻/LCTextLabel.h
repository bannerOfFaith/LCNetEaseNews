//
//  LCTextLabel.h
//  网易新闻
//
//  Created by 李洋 on 16/6/17.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCChannel;
@interface LCTextLabel : UILabel

/**
 *  点击回调
 */
@property (nonatomic, copy) void (^didTextLabel)();

+ (instancetype)channelWithText:(LCChannel *)channel;

@end
