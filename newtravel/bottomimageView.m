//
//  bottomimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/23.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "bottomimageView.h"
@interface bottomimageView()
@property (nonatomic,strong) UILabel *m_label;
@end
@implementation bottomimageView

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
    self.m_label.frame = CGRectMake(10, 5, 180, 30);
}

#pragma mark - getters

-(UILabel *)m_label
{
    if(!_m_label)
    {
        _m_label = [[UILabel alloc] init];
        _m_label.text = @"点击图片写游记";
        _m_label.textColor = [UIColor whiteColor];
        
    }
    return _m_label;
}

@end
