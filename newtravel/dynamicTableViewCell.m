//
//  dynamicTableViewCell.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/26.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "dynamicTableViewCell.h"
#import "dynamicModel.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
@interface dynamicTableViewCell()

@end
@implementation dynamicTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.picImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.addImageView];
        [self.contentView addSubview:self.addressLabel];
        [self.contentView addSubview:self.ThumbBtn];
        [self.contentView addSubview:self.commentsBtn];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.picImageView.frame =CGRectMake(15, 15, 50, 50);
    self.nameLabel.frame = CGRectMake(70, 15, 65, 30);
    self.timeLabel.frame = CGRectMake(70, 45, 80, 20);
    self.addImageView.frame = CGRectMake(10, 250-20, 10, 14);
    self.addressLabel.frame = CGRectMake(25, 230, 50, 15);
    self.commentsBtn.frame = CGRectMake(UIScreenWidth-10-30, 220, 40, 25);
    self.ThumbBtn.frame = CGRectMake(UIScreenWidth-70, 220, 40, 25);
    self.contentLabel.frame = CGRectMake(30, 70, UIScreenWidth-60, 30);
    
}

-(void)setCellDate:(dynamicModel *)dymanic
{
    NSURL *url = [NSURL URLWithString:dymanic.picimagestr];
    [self.picImageView sd_setImageWithURL:url];
    self.nameLabel.text = dymanic.namestr;
    self.timeLabel.text = dymanic.timestr;
    self.contentLabel.text = dymanic.commentstr;
    self.addressLabel.text = dymanic.addressstr;
    
    for (int i = 0; i<dymanic.mainimagearray.count; i++)
    {
        self.mainimageview = [[UIImageView alloc] init];
        self.mainimageview.tag=i;
        
        [self.mainimageview sd_setImageWithURL:dymanic.mainimagearray[i]];
        
        if (dymanic.mainimagearray.count==3) {
            CGFloat x = 100;
            self.mainimageview.frame = CGRectMake(i * (x + 15) + 20, 100,x, 110);
            [self.contentView addSubview:self.mainimageview];
        }
        if (dymanic.mainimagearray.count==1) {
            self.mainimageview.frame = CGRectMake( 20, 100,UIScreenWidth-40, 110);
            [self.contentView addSubview:self.mainimageview];
        }
        if (dymanic.mainimagearray.count==2) {
            CGFloat x = 160;
            self.mainimageview.frame = CGRectMake(i * (x + 15) + 20, 100,x, 110);
            [self.contentView addSubview:self.mainimageview];
        }
        
    }

    
}

#pragma mark - getters

-(UIImageView *)picImageView
{
    if(!_picImageView)
    {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.layer.masksToBounds = YES;
        _picImageView.layer.cornerRadius = 25;
       // _picImageView.backgroundColor = [UIColor greenColor];
    }
    return _picImageView;
}

-(UILabel *)nameLabel
{
    if(!_nameLabel)
    {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.adjustsFontSizeToFitWidth = YES;
        
       // _nameLabel.text = @"安妮";
    }
    return _nameLabel;
}

-(UILabel *)timeLabel
{
    if(!_timeLabel)
    {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
       // _timeLabel.text = @"13:50";
    }
    return _timeLabel;
}

-(UIImageView *)addImageView
{
    if(!_addImageView)
    {
        _addImageView = [[UIImageView alloc] init];
        _addImageView.image = [UIImage imageNamed:@"定位2"];
    }
    return _addImageView;
}

-(UILabel *)addressLabel
{
    if(!_addressLabel)
    {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.adjustsFontSizeToFitWidth = YES;
       // _addressLabel.text = @"巴厘岛";
    }
    return _addressLabel;
}

-(UIButton *)ThumbBtn
{
    if(!_ThumbBtn)
    {
        _ThumbBtn = [[UIButton alloc] init];
        [_ThumbBtn setImage:[UIImage imageNamed:@"赞1"] forState:UIControlStateNormal];
    }
    return _ThumbBtn;
}

-(UIButton *)commentsBtn
{
    if(!_commentsBtn)
    {
        _commentsBtn = [[UIButton alloc] init];
        [_commentsBtn setImage:[UIImage imageNamed:@"评论1"] forState:UIControlStateNormal];
    }
    return _commentsBtn;
}

-(UILabel *)contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
       // _contentLabel.text = @"面朝大海，春暖花开......";
        _contentLabel.textColor = UIColorFromRGB(0X27A18E);
        _contentLabel.numberOfLines = 0;
        
    }
    return _contentLabel;
}








@end
