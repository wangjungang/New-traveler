//
//  tripimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/13.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "tripimageView.h"
#import "Masonry.h"

@implementation tripimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.namelabel];
        [self addSubview:self.setimageView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.setimageView.frame = CGRectMake(self.frame.size.width/3.5, self.frame.size.height/4, UIScreenWidth/10, UIScreenWidth/12);
    
    
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.backgroundColor = [UIColor greenColor];
    }
    return _namelabel;
}

-(UIImageView *)setimageView
{
    if(!_setimageView)
    {
        _setimageView = [[UIImageView alloc] init];
        _setimageView.image = [UIImage imageNamed:@"旅行行程"];
    }
    return _setimageView;
}






@end

