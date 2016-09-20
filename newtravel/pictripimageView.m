//
//  pictripimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/19.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "pictripimageView.h"

@implementation pictripimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.namelabel];
        [self addSubview:self.pictripview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.pictripview.frame = CGRectMake(self.frame.size.width/4, self.frame.size.height/4.5, UIScreenWidth/8, UIScreenWidth/10);
    
    self.namelabel.frame = CGRectMake(self.frame.size.width/4, self.frame.size.height/1.6, UIScreenWidth/8, UIScreenWidth/15);
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.adjustsFontSizeToFitWidth = YES;
        _namelabel.textAlignment = NSTextAlignmentCenter;
        _namelabel.text = @"行程图集";
        
    }
    return _namelabel;
}

-(UIImageView *)pictripview
{
    if(!_pictripview)
    {
        _pictripview = [[UIImageView alloc] init];
        _pictripview.image = [UIImage imageNamed:@"旅行图集"];
        
    }
    return _pictripview;
}



@end
