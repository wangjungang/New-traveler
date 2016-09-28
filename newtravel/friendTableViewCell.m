//
//  friendTableViewCell.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "friendTableViewCell.h"
#import "friendlistModel.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
@implementation friendTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.rightbtn];
               
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.rightbtn.frame = CGRectMake(UIScreenWidth-45, 15, 30, 30);
}

-(void)setdatafriend:(friendlistModel *)friendlist
{
    NSURL *url = [NSURL URLWithString:friendlist.friendpicimageurlstr];
    [self.imageView sd_setImageWithURL:url];
    self.textLabel.text = friendlist.friendnamestr;
}

#pragma mark - getters

-(UIButton *)rightbtn
{
    if(!_rightbtn)
    {
        _rightbtn = [[UIButton alloc] init];
        [_rightbtn setImage:[UIImage imageNamed:@"赞"] forState:UIControlStateNormal];
    }
    return _rightbtn;
}



@end
