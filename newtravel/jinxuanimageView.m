//
//  jinxuanimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/23.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "jinxuanimageView.h"
@interface jinxuanimageView()
@property (nonatomic,strong) UILabel *m_label;
@end
@implementation jinxuanimageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.m_label];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.m_label.frame = CGRectMake(5, 3, 24, 48);
}

#pragma mark - getters

-(UILabel *)m_label
{
    if(!_m_label)
    {
        _m_label = [[UILabel alloc] init];
        _m_label.text = @"精\n选";
        _m_label.adjustsFontSizeToFitWidth = YES;
       // _m_label.font = [UIFont fontWithName:@"Helvetica" size:10];
        _m_label.numberOfLines = [_m_label.text length];
    }
    return _m_label;
}



@end
