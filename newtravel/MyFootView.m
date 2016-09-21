//
//  MyFootView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/21.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "MyFootView.h"

@implementation MyFootView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-10);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.backgroundColor = [UIColor yellowColor];
        [self addSubview:_titleLab];
        
    }
    return self;
}
@end
