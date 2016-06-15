//
//  LCHeadLine.m
//  网易新闻
//
//  Created by 李洋 on 16/6/14.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCHeadLine.h"
#import "LCNetworkingTool.h"
@implementation LCHeadLine
/**
 *  快速创建模型
 */
+ (instancetype)headLineWithDict:(NSDictionary *)dict
{
    LCHeadLine *headLine = [[self alloc]init];
    
    [headLine setValuesForKeysWithDictionary:dict];
    
    return headLine;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{}
/**
 *  返回加载的网络数据
 *
 *  @param success 完成回调
 *  @param failed  失败回调
 */
+ (void)loadNetworkingDataWithSuccess:(void (^)(NSArray *headLines))success failed:(void (^)(NSError *error))failed
{
    NSAssert(success != nil, @"完成回调一定不能为空");
    [[LCNetworkingTool sharedNetworkingTool] GET:@"ad/headline/0-4.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *responseObject) {
        
        // 获取字典的第一个键名
        NSString *dictName = responseObject.keyEnumerator.nextObject;
        
        // 拿到对应的值
        NSArray *headLineArray = responseObject[dictName];
        
        // 字典转模型
        NSMutableArray *headLines = [NSMutableArray array];
        
        [headLineArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LCHeadLine *headLine = [LCHeadLine headLineWithDict:obj];
            
            [headLines addObject:headLine];
        }];
        
        success(headLines.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
}
@end
