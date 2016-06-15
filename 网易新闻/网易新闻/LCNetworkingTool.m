//
//  LCNetworkingTool.m
//  网易新闻
//
//  Created by 李洋 on 16/6/14.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCNetworkingTool.h"

@implementation LCNetworkingTool

+ (instancetype)sharedNetworkingTool
{
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/nc/"];
        instance = [[self alloc]initWithBaseURL:url];
    });
    return instance;
}

@end
