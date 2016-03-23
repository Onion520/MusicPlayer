//
//  NewestInfoCell.m
//  LessonKVC & KVO
//
//  Created by leesa on 14-8-20.
//  Copyright (c) 2014年 lanou. All rights reserved.
//

#import "NewestInfoCell.h"
#import "UIImageView+UIImageView_WebCache.h"
#import "NewsItem.h"
@interface NewestInfoCell ()

@property (strong, nonatomic) IBOutlet UIImageView *newsPictureImageView;   //  新闻图片
@property (strong, nonatomic) IBOutlet UILabel *timestampLabel; //  时间戳
@property (strong, nonatomic) IBOutlet UILabel *titleLable; //  标题
@property (strong, nonatomic) IBOutlet UILabel *introLabel; //  简介


@end

@implementation NewestInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(NewsItem *)item
{
    if (_item != item) {
        _item = item;
    }
    
    [self.newsPictureImageView setImageWithUrlString:_item.photo];
    self.titleLable.text = _item.title;
    self.introLabel.text = _item.content;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[_item.time doubleValue]];
    
    NSLog(@"date = %@",date);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd  HH:mm:ss" ];
    
    NSString *timerLabelText = [formatter stringFromDate:date];
    
    self.timestampLabel.text = timerLabelText;
    
    
//    self.newsPictureImageView.image set

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
