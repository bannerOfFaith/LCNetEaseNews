//
//  LCNews.m
//  网易新闻
//
//  Created by 李洋 on 16/6/16.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCNews.h"
#import "LCNetworkingTool.h"

@implementation LCNews
/**
 *  快速创建模型
 */
+ (instancetype)newsWithDict:(NSDictionary *)dict {
    LCNews *news = [[LCNews alloc]init];
    
    [news setValuesForKeysWithDictionary:dict];
    
    if (news.imgextra) {
        // 字典转换字符串
        NSMutableArray *imgextra = [NSMutableArray array];
        
        [news.imgextra enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *imgsrc = obj[@"imgsrc"];
            [imgextra addObject:imgsrc];
        }];
        
        news.imgextra = imgextra.copy;
        
        //    NSLog(@"%@",news.imgextra);
    }
    
    return news;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

/**
 *  返回加载的网络数据
 *
 *  @param success 完成回调
 *  @param failed  失败回调
 */
+ (void)loadNetworkingSuccess:(void (^)(NSArray *news))success failed:(void (^)(NSError *error))failed {
    NSAssert(success != nil, @"完成回调一定不能为空");
    
    [[LCNetworkingTool sharedNetworkingTool] GET:@"article/headline/T1348647853363/0-20.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        // 拿到字典第一个键
        NSString *rootkey = responseObject.keyEnumerator.nextObject;
        
        // 获取键对应的数据
        NSArray *array = responseObject[rootkey];
        
        // 字典转换模型
        NSMutableArray *news = [NSMutableArray array];
        
        [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LCNews *new = [LCNews newsWithDict:obj];
            
            [news addObject:new];
        }];
        
//        NSLog(@"%@",news);
        
        // 设置block
        success(news.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
    
}
@end
