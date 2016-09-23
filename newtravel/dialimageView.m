//
//  dialimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/23.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "dialimageView.h"

@implementation dialimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mileagelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.mileagelabel.frame = CGRectMake(UIScreenHeight/6.8-40, UIScreenHeight/6.8-20, 80, 40);
}

-(UILabel *)mileagelabel
{
    if(!_mileagelabel)
    {
        _mileagelabel = [[UILabel alloc] init];
        _mileagelabel.text = @"3625Km";
        _mileagelabel.adjustsFontSizeToFitWidth = YES;
        _mileagelabel.textColor = UIColorFromRGB(0X27A18E);
        _mileagelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _mileagelabel;
}


@end
