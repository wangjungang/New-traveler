//
//  MyHeadView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/21.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "MyHeadView.h"

@implementation MyHeadView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(10, 0, self.frame.size.width, self.frame.size.height);
        //_titleLab.textAlignment = NSTextAlignmentCenter;
        //_titleLab.backgroundColor = [UIColor redColor];
        
        [self addSubview:_titleLab];
        
    }
    return self;
}
@end
