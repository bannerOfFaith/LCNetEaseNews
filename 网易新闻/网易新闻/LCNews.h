//
//  LCNews.h
//  网易新闻
//
//  Created by 李洋 on 16/6/16.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCNews : NSObject
/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  多张图片
 */
@property (nonatomic, strong) NSArray *imgextra;
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  详情
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  跟贴数
 */
@property (nonatomic, copy) NSString *replyCount;
/**
 *  判断是否是大图
 */
@property (nonatomic, assign) BOOL imgType;
/**
 *  加载新闻详情要使用的id
 */
@property (nonatomic, copy) NSString *docid;
/**
 *  加载详细新闻的url字符串
 */
@property (nonatomic, copy) NSString *detailURLString;
/**
 *  快速创建模型
 */
+ (instancetype)newsWithDict:(NSDictionary *)dict;

/**
 *  返回加载的网络数据
 *
 *  @param success 完成回调
 *  @param failed  失败回调
 */
+ (void)loadNetworkingWithURLString:(NSString *)URLString success:(void (^)(NSArray *news))success failed:(void (^)(NSError *error))failed;

@end
