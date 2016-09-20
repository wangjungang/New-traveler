//
//  writetripimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/20.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "writetripimageView.h"
@interface writetripimageView()
@property (nonatomic,strong) UIImageView *writeView;
@end

@implementation writetripimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.writeView];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
     self.writeView.frame = CGRectMake(30, 30, self.frame.size.width-60, self.frame.size.height-60);
}

-(UIImageView *)writeView
{
    if(!_writeView)
    {
        _writeView = [[UIImageView alloc] init];
        _writeView.image = [UIImage imageNamed:@"写印象图标"];
    }
    return _writeView;
}


@end
