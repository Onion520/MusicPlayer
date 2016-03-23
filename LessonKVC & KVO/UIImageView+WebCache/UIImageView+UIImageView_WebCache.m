//
//  UIImageView+UIImageView_WebCache.m
//  网络编程(网络封装) 作业
//
//  Created by lanou3g on 14-4-25.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "UIImageView+UIImageView_WebCache.h"

@implementation UIImageView (UIImageView_WebCache)

- (void)setImageWithUrlString:(NSString *)urlString
{
    
    NSString * file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * filePath = [file stringByAppendingPathComponent:[urlString stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        self.image = image;
        return;
    }
    
    NSURL * url = [NSURL URLWithString:urlString];
    dispatch_queue_t myConcurrentQueue = dispatch_queue_create("xiaokeQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(myConcurrentQueue, ^{
        NSData * imageData = [NSData dataWithContentsOfURL:url];
        UIImage * image = [UIImage imageWithData:imageData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = image;
            [imageData writeToFile:filePath atomically:YES];
        });
        
    });
}

+ (NSString *)imagePath:(NSString *)imagePath
{
    NSString * file = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    NSString * filePath = [file stringByAppendingPathComponent:[imagePath stringByReplacingOccurrencesOfString:@"/" withString:@"_"]];
    return filePath;
}

@end
