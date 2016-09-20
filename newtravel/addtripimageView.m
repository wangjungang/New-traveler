//
//  addtripimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/20.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "addtripimageView.h"
@interface addtripimageView()
@property (nonatomic,strong) UIImageView *picimageview;
@end

@implementation addtripimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.picimageview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _picimageview.frame = CGRectMake(30, 30, self.frame.size.width-60, self.frame.size.height-60);
}

-(UIImageView *)picimageview
{
    if(!_picimageview)
    {
        _picimageview = [[UIImageView alloc] init];
        _picimageview.image = [UIImage imageNamed:@"行程图标"];
    }
    return _picimageview;
}



@end
