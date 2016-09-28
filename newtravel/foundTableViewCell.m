//
//  foundTableViewCell.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "foundTableViewCell.h"
#import "foundModel.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
@implementation foundTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.picimageview];
        [self.contentView addSubview:self.namelabel];
        [self.contentView addSubview:self.addressimageview];
        [self.contentView addSubview:self.addresslabel];
        [self.contentView addSubview:self.distancelabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.picimageview.frame = CGRectMake(20, 10, 60, 60);
    self.namelabel.frame = CGRectMake(90, 15, 40, 30);
    self.addressimageview.frame = CGRectMake(90, 55, 10, 13);
    self.addresslabel.frame = CGRectMake(115, 50, 40, 20);
    self.distancelabel.frame = CGRectMake(UIScreenWidth-120, 20, 100, 40);
}
-(void)setCellDate2:(foundModel *)found
{
    NSURL *url = [NSURL URLWithString:found.picimagestr];
    [self.picimageview sd_setImageWithURL:url];
    self.namelabel.text = found.namestr;
    self.addresslabel.text = found.addressstr;
    self.distancelabel.text = found.distancestr;
}
#pragma mark - getters

-(UIImageView *)picimageview
{
    if(!_picimageview)
    {
        _picimageview = [[UIImageView alloc] init];
        _picimageview.layer.masksToBounds = YES;
        _picimageview.layer.cornerRadius = 30;
    }
    return _picimageview;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.adjustsFontSizeToFitWidth = YES;

    }
    return _namelabel;
}

-(UIImageView *)addressimageview
{
    if(!_addressimageview)
    {
        _addressimageview = [[UIImageView alloc] init];
        _addressimageview.image = [UIImage imageNamed:@"定位"];
    }
    return _addressimageview;
}

-(UILabel *)addresslabel
{
    if(!_addresslabel)
    {
        _addresslabel = [[UILabel alloc] init];
        _addresslabel.adjustsFontSizeToFitWidth = YES;
        _addresslabel.textColor = [UIColor lightGrayColor];
    
    }
    return _addresslabel;
}

-(UILabel *)distancelabel
{
    if(!_distancelabel)
    {
        _distancelabel = [[UILabel alloc] init];
        _distancelabel.adjustsFontSizeToFitWidth = YES;
        _distancelabel.textColor = UIColorFromRGB(0X27A18E);

    }
    return _distancelabel;
}

@end
