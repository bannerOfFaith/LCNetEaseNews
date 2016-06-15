//
//  ViewController.m
//  网易新闻
//
//  Created by 李洋 on 16/6/14.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCNewsHeadView.h"
#import "LCHeadLine.h"
#import "LCLoopView.h"

@interface LCNewsHeadView ()
/**
 *  记录数据
 */
@property (nonatomic, strong) NSArray *headLines;
/**
 *  无限轮播器
 */
@property (nonatomic, strong) LCLoopView *loopView;
@end

@implementation LCNewsHeadView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LCHeadLine loadNetworkingDataWithSuccess:^(NSArray *headLines) {
        
        // 记录数据
        self.headLines = headLines;
        
        [self.view addSubview:self.loopView];
        
    } failed:^(NSError *error) {
        NSLog(@"%@------",error);
    }];
}
#pragma mark - 懒加载轮播器
- (LCLoopView *)loopView
{
    if (!_loopView)
    {
        NSArray *imgsrcs = [self.headLines valueForKeyPath:@"imgsrc"];
        
        NSArray *titles = [self.headLines valueForKeyPath:@"title"];
        
        _loopView = [[LCLoopView alloc]initWithURLs:imgsrcs titles:titles];
        
        _loopView.frame = self.view.bounds;
        
//        NSLog(@"%@",NSStringFromCGRect(_loopView.frame));
    }
    return _loopView;
}
@end
