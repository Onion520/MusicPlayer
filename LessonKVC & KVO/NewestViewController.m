//
//  ViewController.m
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-12.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "NewestViewController.h"
#import "NetWorkRequest.h"
#import "TestItem.h"
#import <AVFoundation/AVFoundation.h>
#import "NewestInfoCell.h"
#import "NewestScrollViewCell.h"
#import "NewsDataHandle.h"
#import "NewsItem.h"


#define NewestURLStr @"http://box.dwstatic.com/apiNewsList.php?action=l&newsTag=headlineNews&p=1"


@interface NewestViewController ()<NetWorkRequestDelegate,UITableViewDataSource,UITableViewDelegate>

{
//    AVAudioPlayer *player;
    
}

@property (strong, nonatomic) IBOutlet UITableView *newsListTableView;  //  新闻列表
@property (nonatomic, strong) NSArray *newsListDataArray;   //  新闻列表数组
@property (nonatomic, strong) NSArray *newsScrollViewDataArray; //  滚动视图数据数组

@end

@implementation NewestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NetWorkRequest *networkRequest = [[NetWorkRequest alloc] init];
    
    networkRequest.delegate = self;
    
    [networkRequest requestForGETWithUrl:NewestURLStr];
    
    //  启动距离监测
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    //  通知中心添加观察者,观察距离变化
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(sensorStateChange:)
                                          name:UIDeviceProximityStateDidChangeNotification
                                          object:nil];
    
    
}
- (void)sensorStateChange:(NSNotification *)notification
{
    if (YES == [[UIDevice currentDevice] proximityState]) {
        NSLog(@"Device is close to user");
        //在此写设备接近时,要做的操作逻辑代码
    } else {
        NSLog(@"Device is not close to user");
    }
}

#pragma mark - NetworkRquestDelegate
//  网络请求成功
- (void)netWorkRequest:(NetWorkRequest *)request SuccessfulReceiveData:(NSData *)data
{
    //  将获取到的数据传入 DataHandle 中处理并返回需要的数据
    self.newsListDataArray = [[NewsDataHandle shareInstance] newsListItemsWithData:data];
    self.newsScrollViewDataArray = [[NewsDataHandle shareInstance] newsScrollViewDataItemsWithData:data];
    
    [self.newsListTableView reloadData];
    
}
//  网络请求失败
- (void)netWorkRequest:(NetWorkRequest *)request didFailed:(NSError *)error
{
    NSLog(@"error = %@",error);
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super encodeRestorableStateWithCoder:coder];
    
}
- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    [super decodeRestorableStateWithCoder:coder];
}

#pragma mark - UITableViewDelegate DataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 200;
    }
    return 160;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1 + self.newsListDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            NewestScrollViewCell *scrollViewCell = [tableView dequeueReusableCellWithIdentifier:@"scrollViewCell"];
            
            if (scrollViewCell == nil)
            {
                scrollViewCell = [[NewestScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"scrollViewCell"];
            }
            scrollViewCell.photoURLStringArray = self.newsScrollViewDataArray;
            
            [scrollViewCell tapImageViewBlock:^(NSInteger index) {
                NSLog(@"点击第%d",index);
            }];
            
            return scrollViewCell;
        }
            break;
        default:
        {
            NewestInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            NewsItem *item = self.newsListDataArray[indexPath.row - 1];
            infoCell.item = item;
            
            return infoCell;
        }
            break;
    }
    return nil;
}

//- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    NSLog(@"%s, %d",__FUNCTION__, __LINE__);
//}
//
//- (void)viewWillLayoutSubviews
//{
//    NSLog(@"%s, %d",__FUNCTION__, __LINE__);
//}
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    NSLog(@"%s, %d",__FUNCTION__, __LINE__);
//}
//
//- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
//{
//    NSLog(@"%s, %d",__FUNCTION__, __LINE__);
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
