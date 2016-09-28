//
//  numberimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/28.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "numberimageView.h"

@interface numberimageView()
@property (nonatomic,strong) UILabel *numberlabel;
@end

@implementation numberimageView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.numberlabel];
        [self addSubview:self.numbertext];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.numberlabel.frame = CGRectMake(10, 5, 90, 40);
    self.numbertext.frame = CGRectMake(100, 5, UIScreenWidth-110, 40);
}

#pragma mark - getters

-(UITextField *)numbertext
{
    if(!_numbertext)
    {
        _numbertext = [[UITextField alloc] init];
        _numbertext.layer.masksToBounds = YES;
        //_numbertext.layer.borderWidth = 1.0f;
        //_numbertext.layer.cornerRadius = 8;
        _numbertext.clearButtonMode = UITextFieldViewModeWhileEditing;
        _numbertext.returnKeyType =UIReturnKeyGo;
    }
    return _numbertext;
}

-(UILabel *)numberlabel
{
    if(!_numberlabel)
    {
        _numberlabel = [[UILabel alloc] init];
        _numberlabel.text = @"手机号";
        _numberlabel.adjustsFontSizeToFitWidth = YES;
        _numberlabel.layer.masksToBounds = YES;
//        _numberlabel.layer.borderWidth = 0.4f;
    }
    return _numberlabel;
}




@end

