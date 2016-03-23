//
//  newsScrollViewCell.h
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-20.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TapImageViewActionBlock)(NSInteger index);

@interface NewestScrollViewCell : UITableViewCell

@property (nonatomic, strong) NSArray *photoURLStringArray; //  图片URL数据数组

- (void)tapImageViewBlock:(TapImageViewActionBlock)didClickImageViewBlock;

@end
