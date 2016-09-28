//
//  rankingTableViewCell.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "rankingTableViewCell.h"
#import "rankingModel.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
@implementation rankingTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.picimageview];
        [self.contentView addSubview:self.namelabel];
        [self.contentView addSubview:self.numberlabel];
        [self.contentView addSubview:self.rightimageview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.picimageview.frame = CGRectMake(20, 10, 40, 40);
    self.namelabel.frame = CGRectMake(70, 10, 60, 30);
    self.numberlabel.frame = CGRectMake(70, 45, 60, 15);
    self.rightimageview.frame = CGRectMake(UIScreenWidth-45, 15, 30, 30);
}

-(void)setrankingdata:(rankingModel *)rankingmodel
{
    NSURL *url = [NSURL URLWithString:rankingmodel.rankingpicimagestr];
    [self.picimageview sd_setImageWithURL:url];
    self.namelabel.text = rankingmodel.rankingnamestr;
    self.numberlabel.text = rankingmodel.rankingnumberstr;
    self.rightimageview.image = [UIImage imageNamed:rankingmodel.rightimagestr];
}

#pragma mark - getters

-(UIImageView *)picimageview
{
    if(!_picimageview)
    {
        _picimageview = [[UIImageView alloc] init];
       // _picimageview.backgroundColor = [UIColor greenColor];
        _picimageview.layer.masksToBounds = YES;
        _picimageview.layer.cornerRadius = 20;
    }
    return _picimageview;
}

-(UILabel *)namelabel
{
    if(!_namelabel)
    {
        _namelabel = [[UILabel alloc] init];
        _namelabel.adjustsFontSizeToFitWidth = YES;
        //_namelabel.backgroundColor = [UIColor redColor];
    }
    return _namelabel;
}

-(UILabel *)numberlabel
{
    if(!_numberlabel)
    {
        _numberlabel = [[UILabel alloc] init];
        _numberlabel.adjustsFontSizeToFitWidth = YES;
        //_numberlabel.backgroundColor = [UIColor greenColor];
    }
    return _numberlabel;
}

-(UIImageView *)rightimageview
{
    if(!_rightimageview)
    {
        _rightimageview = [[UIImageView alloc] init];
       // _rightimageview.backgroundColor = [UIColor greenColor];
    }
    return _rightimageview;
}






@end
