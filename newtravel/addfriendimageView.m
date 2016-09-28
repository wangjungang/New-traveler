//
//  addfriendimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/28.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "addfriendimageView.h"

@implementation addfriendimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.addbtn];
        [self addSubview:self.Modifybtn];
        [self addSubview:self.backbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.addbtn.frame = CGRectMake(50, 30, 80, 80);
    self.Modifybtn.frame = CGRectMake(UIScreenWidth-130, 30, 80, 80);
    self.backbtn.frame = CGRectMake(UIScreenWidth-35, 50, 40, 40);
}

#pragma mark - getters

-(UIButton *)addbtn
{
    if(!_addbtn)
    {
        _addbtn = [[UIButton alloc] init];
        [_addbtn setImage:[UIImage imageNamed:@"添加好友"] forState:UIControlStateNormal];
    }
    return _addbtn;
}

-(UIButton *)Modifybtn
{
    if(!_Modifybtn)
    {
        _Modifybtn = [[UIButton alloc] init];
        [_Modifybtn setImage:[UIImage imageNamed:@"修改备注"] forState:UIControlStateNormal];
    }
    return _Modifybtn;
}

-(UIButton *)backbtn
{
    if(!_backbtn)
    {
        _backbtn = [[UIButton alloc] init];
        [_backbtn setImage:[UIImage imageNamed:@"关闭2"] forState:UIControlStateNormal];
    }
    return _backbtn;
}


@end
