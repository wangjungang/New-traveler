//
//  myinfoTableViewCell.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "myinfoTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "myinfoModel.h"
@implementation myinfoTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.bgimageview];
        [self.contentView addSubview:self.picimageview];
        [self.contentView addSubview:self.leftbtn];
        [self.contentView addSubview:self.rightbtn];
        [self.contentView addSubview:self.signaturelabel];
        [self.contentView addSubview:self.messagelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.bgimageview.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight/3+10);
    self.picimageview.frame = CGRectMake(UIScreenWidth/2-40, UIScreenHeight/6-70, 80, 80);
    self.leftbtn.frame = CGRectMake(30, 60, 30, 30);
    self.rightbtn.frame = CGRectMake(UIScreenWidth-60, 60, 30, 30);
    self.messagelabel.frame = CGRectMake(UIScreenWidth/2-40, UIScreenHeight/3-90, 80, 30);
    self.signaturelabel.frame = CGRectMake(UIScreenWidth/2-100, UIScreenHeight/3-65, 200, 50);
    
}

-(void)setdatamyinfo:(myinfoModel *)myinfo
{
    NSURL *url = [NSURL URLWithString:myinfo.myinfostr];
    [self.picimageview sd_setImageWithURL:url];
    self.messagelabel.text = myinfo.myinfomessagestr;
    self.signaturelabel.text = myinfo.myinfosignaturestr;
}
#pragma mark - getters

-(UIImageView *)bgimageview
{
    if(!_bgimageview)
    {
        _bgimageview = [[UIImageView alloc] init];
        _bgimageview.image = [UIImage imageNamed:@"QQ截图20160822111924"];
    }
    return _bgimageview;
}

-(UIImageView *)picimageview
{
    if(!_picimageview)
    {
        _picimageview = [[UIImageView alloc] init];
        _picimageview.layer.masksToBounds = YES;
        _picimageview.layer.cornerRadius = 40;
    }
    return _picimageview;
}

-(UIButton *)leftbtn
{
    if(!_leftbtn)
    {
        _leftbtn = [[UIButton alloc] init];
        [_leftbtn setImage:[UIImage imageNamed:@"扫描2"] forState:UIControlStateNormal];
    }
    return _leftbtn;
}

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"通知"] forState:UIControlStateNormal];
    }
    return _rightbtn;
}

-(UILabel *)signaturelabel
{
    if(!_signaturelabel)
    {
        _signaturelabel = [[UILabel alloc] init];
        _signaturelabel.adjustsFontSizeToFitWidth = YES;
        _signaturelabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _signaturelabel;
}

-(UILabel *)messagelabel
{
    if(!_messagelabel)
    {
        _messagelabel = [[UILabel alloc] init];
        _messagelabel.adjustsFontSizeToFitWidth = YES;
        _messagelabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _messagelabel;
}

@end
