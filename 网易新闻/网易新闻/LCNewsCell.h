//
//  LCNewsCell.h
//  网易新闻
//
//  Created by 李洋 on 16/6/16.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LCNews;
@interface LCNewsCell : UITableViewCell
/**
 *  数据模型
 */
@property (nonatomic, strong) LCNews *news;
@end
