//
//  LCChannel.h
//  网易新闻
//
//  Created by 李洋 on 16/6/17.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCChannel : NSObject
/**
 *  频道名
 */
@property (nonatomic, copy) NSString *tname;
/**
 *  频道标识:标识越小越重要
 */
@property (nonatomic, copy) NSString *tid;
/**
 *  url字符串
 */
@property (nonatomic, copy) NSString *URLString;

+ (instancetype)channelWithDict:(NSDictionary *)dict;

/**
 *  返回频道数据数组
 */
+ (NSArray *)channels;

@end
