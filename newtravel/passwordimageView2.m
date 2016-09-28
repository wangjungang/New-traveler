//
//  passwordimageView1.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/28.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "passwordimageView2.h"
@interface passwordimageView2()
@property (nonatomic,strong) UILabel *passwordlabel;
@end
@implementation passwordimageView2
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.passwordtext2];
        [self addSubview:self.passwordlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.passwordlabel.frame = CGRectMake(10, 5, 90, 40);
    self.passwordtext2.frame = CGRectMake(100, 5, UIScreenWidth-110, 40);
    
}

#pragma mark - getters

-(UILabel *)passwordlabel
{
    if(!_passwordlabel)
    {
        _passwordlabel = [[UILabel alloc] init];
        _passwordlabel.adjustsFontSizeToFitWidth = YES;
        _passwordlabel.text = @"确认密码";
    }
    return _passwordlabel;
}

-(UITextField *)passwordtext2
{
    if(!_passwordtext2)
    {
        _passwordtext2 = [[UITextField alloc] init];
        _passwordtext2.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordtext2.returnKeyType =UIReturnKeyGo;
        _passwordtext2.secureTextEntry = YES;
    }
    return _passwordtext2;
}




@end
