//
//  NewsDataHandle.m
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-20.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "NewsDataHandle.h"
#import "NewsItem.h"

@implementation NewsDataHandle

+ (id)shareInstance
{
    
    static NewsDataHandle *handle = nil;
    
    @synchronized(self)
    {
        if (handle == nil)
        {
            handle = [[self alloc] init];
        }
        return handle;
    }
}


- (NSArray *)newsListItemsWithData:(NSData *)data
{
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSArray *newsArray = [dic objectForKey:@"data"];
    NSMutableArray *newsItemArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *obj in newsArray) {
        
        NewsItem *item = [[NewsItem alloc] init];
        
        [item setValuesForKeysWithDictionary:obj];
        
        [newsItemArray addObject:item];
    }
    
    return newsItemArray;
}


- (NSArray *)newsScrollViewDataItemsWithData:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    NSLog(@"dic = %@",dic);
    
    NSArray *newsArray = [dic objectForKey:@"headerline"];
    NSMutableArray *newsScrollViewItemArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *obj in newsArray) {
        NSString *photoURLStr = [obj objectForKey:@"photo"];
        [newsScrollViewItemArray addObject:photoURLStr];
    }
    
    return newsScrollViewItemArray;
}

@end
