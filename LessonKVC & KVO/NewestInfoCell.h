//
//  NewestInfoCell.h
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-20.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsItem;

@interface NewestInfoCell : UITableViewCell

@property (nonatomic, strong) NewsItem *item;   //  单条新闻数据

@end
