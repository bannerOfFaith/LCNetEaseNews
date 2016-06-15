//
//  LCNetworkingTool.h
//  网易新闻
//
//  Created by 李洋 on 16/6/14.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface LCNetworkingTool : AFHTTPSessionManager

/**
 *  提供单利的创建方法
 */
+ (instancetype)sharedNetworkingTool;

@end
