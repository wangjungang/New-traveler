//
//  navigationimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/19.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "navigationimageView.h"

@interface navigationimageView()
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UIImageView *picimageview;
@end

@implementation navigationimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.namelabel];
        [self addSubview:self.picimageview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.picimageview.frame = CGRectMake(self.frame.size.width/4, self.frame.size.height/4.5, UIScreenWidth/8, UIScreenWidth/10);
    
    self.namelabel.frame = CGRectMake(self.frame.size.width/4, self.frame.size.height/1.6, UIScreenWidth/8, UIScreenWidth/15);
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.textAlignment = NSTextAlignmentCenter;
        _namelabel.text = @"行程导航";
        _namelabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _namelabel;
}

-(UIImageView *)picimageview
{
    if(!_picimageview)
    {
        _picimageview = [[UIImageView alloc] init];
        _picimageview.image = [UIImage imageNamed:@"行程导航"];
    }
    return _picimageview;
}




@end
