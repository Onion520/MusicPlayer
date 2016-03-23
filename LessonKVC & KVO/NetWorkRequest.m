//
//  NetWorkRequest.m
//  网络封装
//
//  Created by lanou3g on 14-4-23.
//  Copyright (c) 2014年 lanou3g. All rights reserved.
//

#import "NetWorkRequest.h"

@interface NetWorkRequest ()
{
    CGFloat _totalLength;
}

@property (nonatomic,retain) NSMutableData * receiveData;
@property (nonatomic,retain) NSURLConnection * connection;

@end

@implementation NetWorkRequest

- (void)dealloc
{
    self.receiveData = nil;
    self.connection = nil;
//    [super dealloc];
}

//实现GET请求
- (void)requestForGETWithUrl:(NSString *)urlString
{
    //封装URL对象
    NSURL * url = [NSURL URLWithString:urlString];
    //创建网络请求
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    //设置GET请求
    [request setHTTPMethod:@"GET"];
    
    //建立异步连接,使用设置delegate方式实现
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    
    
    
}

//实现POST请求
- (void)requestForPOSTWithUrl:(NSString *)urlString postData:(NSData *)postData
{
    //封装URL对象
    NSURL * url = [NSURL URLWithString:urlString];
    //创建网络请求
    NSMutableURLRequest * request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    //设置POST请求
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [request setValue:@"" forHTTPHeaderField:@"Accept-Encoding"];
    
    //建立异步连接,使用设置delegate方式实现
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
//    NSURLConnection sendAsynchronousRequest:request queue:<#(NSOperationQueue *)#> completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
//    }
}

//取消网络请求
- (void)cancelRequest
{
    [_connection cancel];
    self.connection = nil;
    self.delegate = nil;
}


- (void)networdRquestSuccessedHandler:(NetworkRequestSuccessedHandler)successedHandler failedHandler:(NetworkRequestFailedHandler)failedHandler progressHandler:(NetworkRequestProgressHandler)progressHandler
{
    
}


#pragma mark ------------------ 异步连接代理方法 网络连接状态 -------------------
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error = %@",error);
    if ([_delegate respondsToSelector:@selector(netWorkRequest:didFailed:)]) {
        [_delegate netWorkRequest:self didFailed:error];
    }
    
    self.receiveData = nil;
}



- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *httpURLResponse = (NSHTTPURLResponse *)response;
    
    NSLog(@"response = %@",httpURLResponse.allHeaderFields);
    
//    _totalLength = [httpURLResponse.allHeaderFields ];

    NSLog(@"response header = %lu",(unsigned long)[httpURLResponse description].length );
    
    
    self.receiveData = [NSMutableData data];
    _totalLength = [response expectedContentLength];
    
}



- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
    
    //计算当前的下载进度
    CGFloat progress = _receiveData.length/_totalLength;
    //通知代理,执行代理方法,获取当前的下载进度
    if ([_delegate respondsToSelector:@selector(netWorkRequest:withProgress:)]) {
        [_delegate netWorkRequest:self withProgress:progress];
    }
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([_delegate respondsToSelector:@selector(netWorkRequest:SuccessfulReceiveData:)]) {
        [_delegate netWorkRequest:self SuccessfulReceiveData:_receiveData];
    }
    
    self.receiveData = nil;
}



@end
