//
//  newsScrollViewCell.m
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-20.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "NewestScrollViewCell.h"
#import "UIImageView+WebCache/UIImageView+UIImageView_WebCache.h"

@interface NewestScrollViewCell ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *showImageViewScrollView;    //  展示图片轮播图
@property (nonatomic, strong) UIPageControl *showImageViewPageControl;  //  展示图片

@property (nonatomic, copy) TapImageViewActionBlock tapImageViewBlock;

@end

@implementation NewestScrollViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createSubViews];
        [self addTimer];
        
        NSLog(@"self.frame = %@",NSStringFromCGRect(self.contentView.frame));
    }
    return self;
}


//  创建cell子视图
- (void)createSubViews
{
    //  创建scrollView
    [self createScrollView];
    
    //  创建pageControl
    [self createPageControl];
}

//  添加定时器, 实现轮播图
- (void)addTimer
{
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(runTimer) userInfo:nil repeats:YES];
}

//  创建scrollView
- (void)createScrollView
{
    self.showImageViewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    
    self.showImageViewScrollView.contentSize = CGSizeMake(320*5, 0);
    //  锁定滑动方向
    self.showImageViewScrollView.directionalLockEnabled = NO;
    //  弹跳效果
    self.showImageViewScrollView.bounces = NO;
    //  分页效果
    self.showImageViewScrollView.pagingEnabled = YES;
    //  滚动条
    self.showImageViewScrollView.showsHorizontalScrollIndicator = NO;
    self.showImageViewScrollView.showsVerticalScrollIndicator = NO;
    
    self.showImageViewScrollView.delegate = self;
    
    //  scrollView 上面添加imageView
    for (int i = 0; i < 5; i++)
    {
        UIImageView *picImageView = [[UIImageView alloc] initWithFrame:CGRectMake(320*i, 0, 320, self.showImageViewScrollView.frame.size.height)];
        picImageView.tag = 100+i;
        [self.showImageViewScrollView addSubview:picImageView];
        
        picImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        
        [picImageView addGestureRecognizer:tap];
        
    }
    [self.contentView addSubview:self.showImageViewScrollView];
}

//图片轻拍手势
- (void)handleTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"sss");
    NSInteger index = tap.view.tag - 100;
    self.tapImageViewBlock(index);
}


- (void)tapImageViewBlock:(TapImageViewActionBlock)didClickImageViewBlock
{
    self.tapImageViewBlock = didClickImageViewBlock;
}

//  创建pageControl
- (void)createPageControl
{
    self.showImageViewPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(120,180, 80, 20)];
    
    //  页数
    self.showImageViewPageControl.numberOfPages = 5;
    self.showImageViewPageControl.backgroundColor = [UIColor clearColor];
    //  页码控制点颜色
    self.showImageViewPageControl.pageIndicatorTintColor = [UIColor grayColor];
    self.showImageViewPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //  pageControl 添加目标事件
    [self.showImageViewPageControl addTarget:self action:@selector(didClickPageControlActionWith:) forControlEvents:UIControlEventValueChanged];
    
    [self.contentView addSubview:self.showImageViewPageControl];
    

}

//  pageControl 点击相应事件
- (void)didClickPageControlActionWith:(UIPageControl *)sender
{
    NSInteger currentPage = self.showImageViewPageControl.currentPage;
    CGPoint offsetPoint = CGPointMake(currentPage * 320, 0);
    
    //  根据当前currentPage 滚动scrollView
    [self.showImageViewScrollView setContentOffset:offsetPoint animated:YES];
}

//  定时器响应方法
- (void)runTimer
{
    if (self.showImageViewPageControl.currentPage == 4) {
        self.showImageViewPageControl.currentPage = 0;
    } else {
        self.showImageViewPageControl.currentPage++;
    }
    
    NSInteger currentPage = self.showImageViewPageControl.currentPage;
    CGPoint offsetPoint = CGPointMake(320*currentPage, 0);
    
    //  scrollView偏移到当前currentPage
    [self.showImageViewScrollView setContentOffset:offsetPoint animated:YES];
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //  计算scrollView的contentOffset 设置pageControl的currentPage
    CGPoint offsetPoint = scrollView.contentOffset;
    self.showImageViewPageControl.currentPage = offsetPoint.x / 320;
}


- (void)setPhotoURLStringArray:(NSArray *)photoURLStringArray
{
    if (_photoURLStringArray != photoURLStringArray) {
        _photoURLStringArray = photoURLStringArray;
    }
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *picImageView = (UIImageView *)[self.contentView viewWithTag:100+i];
        [picImageView setImageWithUrlString:_photoURLStringArray[i]];
    }
    NSLog(@"photo array = %@",_photoURLStringArray);
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
