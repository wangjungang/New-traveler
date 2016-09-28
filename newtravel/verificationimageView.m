//
//  verificationimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/28.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "verificationimageView.h"
@interface verificationimageView()
@property (nonatomic,strong) UILabel *verifocalabel;
@end

@implementation verificationimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.verificationtext];
        [self addSubview:self.verifocalabel];
        [self addSubview:self.sendbtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.verifocalabel.frame = CGRectMake(10, 5, 90, 40);
    self.verificationtext.frame = CGRectMake(100, 5, UIScreenWidth-210, 40);
    self.sendbtn.frame = CGRectMake(UIScreenWidth-90, 5, 80, 40);
    
}

#pragma mark - getters

-(UITextField *)verificationtext
{
    if(!_verificationtext)
    {
        _verificationtext = [[UITextField alloc] init];
        _verificationtext.clearButtonMode = UITextFieldViewModeWhileEditing;
        _verificationtext.returnKeyType =UIReturnKeyGo;
    }
    return _verificationtext;
}

-(UIButton *)sendbtn
{
    if(!_sendbtn)
    {
        _sendbtn = [[UIButton alloc] init];
        _sendbtn.layer.masksToBounds = YES;
        _sendbtn.layer.borderWidth = 0.4f;
        [_sendbtn.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [_sendbtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
    return _sendbtn;
}

-(UILabel *)verifocalabel
{
    if(!_verifocalabel)
    {
        _verifocalabel = [[UILabel alloc] init];
        _verifocalabel.adjustsFontSizeToFitWidth = YES;
        _verifocalabel.text = @"验证码";
    }
    return _verifocalabel;
}





@end
