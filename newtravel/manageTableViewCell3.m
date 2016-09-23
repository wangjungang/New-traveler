//
//  manageTableViewCell3.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/22.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "manageTableViewCell3.h"

@implementation manageTableViewCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.leftimageView];
        [self addSubview:self.rightimageView];
    }
    return self;
}

-(void)layoutSubviews
{
    self.leftimageView.frame = CGRectMake(5, 0, UIScreenWidth/2-5,  UIScreenHeight-64*2-UIScreenHeight/5-UIScreenHeight/2.6);
    self.rightimageView.frame = CGRectMake(UIScreenWidth/2+5, 0, UIScreenWidth/2-10,  UIScreenHeight-64*2-UIScreenHeight/5-UIScreenHeight/2.6);
    
}

-(UIImageView *)leftimageView
{
    if(!_leftimageView)
    {
        _leftimageView = [[UIImageView alloc] init];
        _leftimageView.image = [UIImage imageNamed:@"图1"];
    }
    return _leftimageView;
}

-(UIImageView *)rightimageView
{
    if(!_rightimageView)
    {
        _rightimageView = [[UIImageView alloc] init];
        _rightimageView.image = [UIImage imageNamed:@"图2"];
    }
    return _rightimageView;
}


@end
