//
//  NewsDataHandle.h
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-20.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDataHandle : NSObject

/**
 *  数据处理单例对象
 *
 *  @return
 */
+ (id)shareInstance;

/**
 *  获取新闻列表数据
 *
 *  @param dic 传入数据字典
 *
 *  @return 新闻数据数组
 */
- (NSArray *)newsListItemsWithData:(NSData *)data;

/**
 *  获取滚动视图数据
 *
 *  @param dic 传入源数据字典
 *
 *  @return 滚动视图数据数组
 */
- (NSArray *)newsScrollViewDataItemsWithData:(NSData *)data;

@end
