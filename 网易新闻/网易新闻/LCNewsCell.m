//
//  LCNewsCell.m
//  网易新闻
//
//  Created by 李洋 on 16/6/16.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCNewsCell.h"
#import "LCNews.h"
#import "UIButton+WebCache.h"
@interface LCNewsCell ()
/**
 *  图片按钮
 */
@property (nonatomic, weak) IBOutlet UIButton *iconBtn;
/**
 *  新闻标题
 */
@property (nonatomic, weak) IBOutlet UILabel *newsTitle;
/**
 *  详情
 */
@property (nonatomic, weak) IBOutlet UILabel *detailTitle;
/**
 *  跟帖数
 */
@property (nonatomic, weak) IBOutlet UILabel *replyCount;
/**
 *  多张图片
 */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *imgextra;

@end

@implementation LCNewsCell

/**
 *  重写setNews用来设置子控件
 */
- (void)setNews:(LCNews *)news {
    _news = news;
    
    // 判断是否有多张图片
    if (news.imgextra) {
        [self.imgextra enumerateObjectsUsingBlock:^(UIButton *iconBtn, NSUInteger idx, BOOL * _Nonnull stop) {
            [iconBtn sd_setImageWithURL:[NSURL URLWithString:news.imgextra[idx]] forState:UIControlStateNormal];
        }];
    }
    
    [self.iconBtn sd_setImageWithURL:[NSURL URLWithString:news.imgsrc] forState:UIControlStateNormal];
    self.newsTitle.text = news.title;
    self.detailTitle.text = news.digest;
    self.replyCount.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
}

@end
