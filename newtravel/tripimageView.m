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
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        
    }
    return _namelabel;
}



@end

