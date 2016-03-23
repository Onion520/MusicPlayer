//
//  NewsItem.h
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-20.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;

@end
