//
//  NetWorkRequest.h
//  网络封装
//
//  Created by lanou3g on 14-4-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
@class NetWorkRequest;

//  网络请求成功block
typedef void(^NetworkRequestSuccessedHandler)(void);
//  网络请求失败block
typedef void(^NetworkRequestFailedHandler)(NSError *error);
//  网络请求进度block
typedef void(^NetworkRequestProgressHandler)(NSInteger progress);


@protocol NetWorkRequestDelegate <NSObject>
@optional
//network请求成功
- (void)netWorkRequest:(NetWorkRequest *)request SuccessfulReceiveData:(NSData *)data;

//network请求失败
- (void)netWorkRequest:(NetWorkRequest *)request didFailed:(NSError *)error;

//获取network下载进度
- (void)netWorkRequest:(NetWorkRequest *)request withProgress:(CGFloat)progress;


@end



@interface NetWorkRequest : NSObject<NSURLConnectionDataDelegate>

@property (nonatomic,assign) id<NetWorkRequestDelegate> delegate;

//声明两个方法,对外提供接口,分别实现GET请求方式和POST请求方式
//实现GET请求
- (void)requestForGETWithUrl:(NSString *)urlString;

//实现POST请求
- (void)requestForPOSTWithUrl:(NSString *)urlString postData:(NSData *)postData;

//取消网络请求
- (void)cancelRequest;

//  使用block实现网络请求结果回调
- (void)networdRquestSuccessedHandler:(NetworkRequestSuccessedHandler)successedHandler failedHandler:(NetworkRequestFailedHandler)failedHandler progressHandler:(NetworkRequestProgressHandler)progressHandler;

@end
