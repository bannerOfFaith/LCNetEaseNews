//
//  LCNewsViewController.m
//  网易新闻
//
//  Created by 李洋 on 16/6/16.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCNewsViewController.h"
#import "LCNews.h"
#import "LCNewsCell.h"
@interface LCNewsViewController ()
/**
 *  网络数据数组
 */
@property (nonatomic, strong) NSArray *news;
@end

@implementation LCNewsViewController
#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LCNews loadNetworkingSuccess:^(NSArray *news) {
        
        NSLog(@"%@",news);
        
        self.news = news;
        
        [self.tableView reloadData];
        
    } failed:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 数据源协议
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCNewsCell *cell = nil;
    
    LCNews *news = self.news[indexPath.row];
    
    if (news.imgextra) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"threeImageCell" forIndexPath:indexPath];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:@"news" forIndexPath:indexPath];
    }
    
    // 传数据给cell
    cell.news = news;
    
    return cell;
}
#pragma mark - 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LCNews *news = self.news[indexPath.row];
    if (news.imgextra) {
        return 120.0;
    }else {
        return 90.0;
    }
}
@end
