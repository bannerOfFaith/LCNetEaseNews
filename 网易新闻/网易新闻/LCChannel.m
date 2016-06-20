//
//  LCChannel.m
//  网易新闻
//
//  Created by 李洋 on 16/6/17.
//  Copyright © 2016年 李洋. All rights reserved.
//

#import "LCChannel.h"

@implementation LCChannel

+ (instancetype)channelWithDict:(NSDictionary *)dict {
    LCChannel *channel = [[self alloc]init];
    
    [channel setValuesForKeysWithDictionary:dict];
    
    return channel;
}

- (void)setTid:(NSString *)tid {
    _tid = [tid copy];
    _URLString = [NSString stringWithFormat:@"article/headline/%@/0-20.html",tid];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

+ (NSArray *)channels {
    
    
    // 获取json二进制
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"topic_news.json" ofType:nil]];
    
    // 二进制转化为字典
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // 获取字典的的第一个键
    NSString *rootkey = dict.keyEnumerator.nextObject;
    
    // 获取数据
    NSArray *array = dict[rootkey];
    
    // 字典转换模型
    NSMutableArray *channels = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        LCChannel *channel = [LCChannel channelWithDict:dict];
        
        [channels addObject:channel];
    }];
    
    //返回数据数组
    return [channels sortedArrayUsingComparator:^NSComparisonResult(LCChannel *obj1, LCChannel * obj2) {
        return [obj1.tid compare:obj2.tid];
    }];
}

@end
