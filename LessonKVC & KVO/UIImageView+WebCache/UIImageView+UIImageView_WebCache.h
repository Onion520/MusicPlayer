//
//  UIImageView+UIImageView_WebCache.h
//  网络编程(网络封装) 作业
//
//  Created by lanou3g on 14-4-25.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (UIImageView_WebCache)

- (void)setImageWithUrlString:(NSString *)urlString;

+ (NSString *)imagePath:(NSString *)imagePath;

@end
