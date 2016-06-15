//
//  LCLoopView.h
//  网易新闻
//
//  Created by 李洋 on 16/6/15.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCLoopView : UIView

/**
 *  新闻头条
 *
 *  @param URLs   图片数组
 *  @param titles 标题数组
 */
- (instancetype)initWithURLs:(NSArray <NSString *>*)URLs titles:(NSArray <NSString *>*)titles;

@end
