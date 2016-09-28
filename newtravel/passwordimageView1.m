//
//  passwordimageView1.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/28.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "passwordimageView1.h"
@interface passwordimageView1()
@property (nonatomic,strong) UILabel *passwordlabel;
@end
@implementation passwordimageView1
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.passwordtext1];
        [self addSubview:self.passwordlabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.passwordlabel.frame = CGRectMake(10, 5, 90, 40);
    self.passwordtext1.frame = CGRectMake(100, 5, UIScreenWidth-110, 40);

}

#pragma mark - getters

-(UILabel *)passwordlabel
{
    if(!_passwordlabel)
    {
        _passwordlabel = [[UILabel alloc] init];
        _passwordlabel.adjustsFontSizeToFitWidth = YES;
        _passwordlabel.text = @"创建密码";
    }
    return _passwordlabel;
}

-(UITextField *)passwordtext1
{
    if(!_passwordtext1)
    {
        _passwordtext1 = [[UITextField alloc] init];
        _passwordtext1.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordtext1.returnKeyType =UIReturnKeyGo;
        _passwordtext1.secureTextEntry = YES;
    }
    return _passwordtext1;
}




@end
