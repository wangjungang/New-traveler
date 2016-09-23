//
//  manageTableViewCell2.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/22.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "manageTableViewCell2.h"
#import "dialimageView.h"
#import "jinxuanimageView.h"
@implementation manageTableViewCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.m_label];
        [self.contentView addSubview:self.triangleimageView];
        [self.contentView addSubview:self.dialView];
        [self.contentView addSubview:self.jinxuanview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.m_label.frame = CGRectMake(30, 10, 70, 30);
    self.triangleimageView.frame = CGRectMake(110, 20, 10, 10);
    self.dialView.frame = CGRectMake(UIScreenWidth/2-UIScreenHeight/6.8, (UIScreenHeight/2.6-UIScreenHeight/3.4)/2, UIScreenHeight/3.4, UIScreenHeight/3.4);
    self.jinxuanview.frame = CGRectMake(10, UIScreenHeight/2.6-70, 30, 60);
}

-(UILabel *)m_label
{
    if(!_m_label)
    {
        _m_label = [[UILabel alloc] init];
        _m_label.adjustsFontSizeToFitWidth = YES;
        _m_label.textAlignment = NSTextAlignmentCenter;
        _m_label.text = @"我的行程";
    }
    return _m_label;
}

-(UIImageView *)triangleimageView
{
    if(!_triangleimageView)
    {
        _triangleimageView = [[UIImageView alloc] init];
        _triangleimageView.image = [UIImage imageNamed:@"展开三角"];
    }
    return _triangleimageView;
}

-(dialimageView *)dialView
{
    if(!_dialView)
    {
        _dialView = [[dialimageView alloc] init];
        _dialView.image = [UIImage imageNamed:@"行程表盘"];
    }
    return _dialView;
}

-(jinxuanimageView *)jinxuanview
{
    if(!_jinxuanview)
    {
        _jinxuanview = [[jinxuanimageView alloc] init];
        _jinxuanview.image = [UIImage imageNamed:@"精选底纹"];
    }
    return _jinxuanview;
}





@end
