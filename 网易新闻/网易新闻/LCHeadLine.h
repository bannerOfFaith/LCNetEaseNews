//
//  LCHeadLine.h
//  网易新闻
//
//  Created by 李洋 on 16/6/14.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCHeadLine : NSObject

/**
 *  图片
 */
@property (nonatomic, copy) NSString *imgsrc;

/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;

/**
 *  快速创建模型
 */
+ (instancetype)headLineWithDict:(NSDictionary *)dict;

/**
 *  返回加载的网络数据
 *
 *  @param success 完成回调
 *  @param failed  失败回调
 */
+ (void)loadNetworkingDataWithSuccess:(void (^)(NSArray *headLines))success failed:(void (^)(NSError *error))failed;

@end
