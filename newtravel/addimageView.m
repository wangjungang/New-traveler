//
//  addimageView.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/23.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "addimageView.h"
@interface addimageView()
@property (nonatomic,strong) UILabel *label1;
@property (nonatomic,strong) UILabel *label2;
@property (nonatomic,strong) UILabel *label3;
@property (nonatomic,strong) UILabel *label4;
@property (nonatomic,strong) UILabel *label5;
@end

@implementation addimageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.btn1];
        [self addSubview:self.btn2];
        [self addSubview:self.btn3];
        [self addSubview:self.btn4];
        [self addSubview:self.btn5];
        [self addSubview:self.closebtn];
        [self addSubview:self.label1];
        [self addSubview:self.label2];
        [self addSubview:self.label3];
        [self addSubview:self.label4];
        [self addSubview:self.label5];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.closebtn.frame = CGRectMake(10, 100, 50, 50);
    self.btn1.frame = CGRectMake(20, 10, 50, 50);
    self.btn2.frame = CGRectMake(UIScreenWidth/2-100, 10, 50, 50);
    self.btn3.frame = CGRectMake(UIScreenWidth/2-25, 10, 50, 50);
    self.btn4.frame = CGRectMake(UIScreenWidth-140, 10, 50, 50);
    self.btn5.frame = CGRectMake(UIScreenWidth-70, 10, 50, 50);
    
    self.label1.frame = CGRectMake(20, 70, 50, 30);
    self.label2.frame = CGRectMake(UIScreenWidth/2-100, 70, 50, 30);
    self.label3.frame = CGRectMake(UIScreenWidth/2-25, 70, 50, 30);
    self.label4.frame = CGRectMake(UIScreenWidth-140, 70, 50, 30);
    self.label5.frame = CGRectMake(UIScreenWidth-70, 70, 50, 30);
}

#pragma mark - getters

-(UIButton *)closebtn
{
    if(!_closebtn)
    {
        _closebtn = [[UIButton alloc] init];
        [_closebtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        
    }
    return _closebtn;
}

-(UIButton *)btn1
{
    if(!_btn1)
    {
        _btn1 = [[UIButton alloc] init];
        [_btn1 setImage:[UIImage imageNamed:@"实时路况"] forState:UIControlStateNormal];
    }
    return _btn1;
}

-(UIButton *)btn2
{
    if(!_btn2)
    {
        _btn2 = [[UIButton alloc] init];
        [_btn2 setImage:[UIImage imageNamed:@"修改行程"] forState:UIControlStateNormal];
    }
    return _btn2;
}

-(UIButton *)btn3
{
    if(!_btn3)
    {
        _btn3 = [[UIButton alloc] init];
        [_btn3 setImage:[UIImage imageNamed:@"刷新行程"] forState:UIControlStateNormal];
    }
    return _btn3;
}

-(UIButton *)btn4
{
    if(!_btn4)
    {
        _btn4 = [[UIButton alloc] init];
        [_btn4 setImage:[UIImage imageNamed:@"我的收藏"] forState:UIControlStateNormal];
    }
    return _btn4;
}

-(UIButton *)btn5
{
    if(!_btn5)
    {
        _btn5 = [[UIButton alloc] init];
        [_btn5 setImage:[UIImage imageNamed:@"周边推荐"] forState:UIControlStateNormal];
    }
    return _btn5;
}

-(UILabel *)label1
{
    if(!_label1)
    {
        _label1 = [[UILabel alloc] init];
        _label1.backgroundColor = [UIColor clearColor];
        _label1.text = @"实时路况";
        _label1.adjustsFontSizeToFitWidth = YES;
        _label1.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label1;
}

-(UILabel *)label2
{
    if(!_label2)
    {
        _label2 = [[UILabel alloc] init];
        _label2.backgroundColor = [UIColor clearColor];
        _label2.text = @"修改行程";
        _label2.adjustsFontSizeToFitWidth = YES;
        _label2.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label2;
}

-(UILabel *)label3
{
    if(!_label3)
    {
        _label3 = [[UILabel alloc] init];
        _label3.backgroundColor = [UIColor clearColor];
        _label3.text = @"刷新行程";
        _label3.adjustsFontSizeToFitWidth = YES;
        _label3.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label3;
}

-(UILabel *)label4
{
    if(!_label4)
    {
        _label4 = [[UILabel alloc] init];
        _label4.backgroundColor = [UIColor clearColor];
        _label4.text = @"我的收藏";
        _label4.adjustsFontSizeToFitWidth = YES;
        _label4.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label4;
}

-(UILabel *)label5
{
    if(!_label5)
    {
        _label5 = [[UILabel alloc] init];
        _label5.backgroundColor = [UIColor clearColor];
        _label5.text = @"周边推荐";
        _label5.adjustsFontSizeToFitWidth = YES;
        _label5.textAlignment = NSTextAlignmentCenter;
        
    }
    return _label5;
}


@end
