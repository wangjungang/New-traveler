//
//  impressTableViewCell.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/23.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "impressTableViewCell.h"
#import "bottomimageView.h"

@interface impressTableViewCell()
@property (nonatomic,strong) bottomimageView *bottomview;
@end


@implementation impressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self addSubview:self.impreseimageview];
        [self addSubview:self.bottomview];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.impreseimageview.frame = CGRectMake(30, 20, UIScreenWidth-60, 200-40);
    self.bottomview.frame = CGRectMake(30, 140, UIScreenHeight-60, 40);
}

#pragma mark - getters

-(UIImageView *)impreseimageview
{
    if(!_impreseimageview)
    {
        _impreseimageview = [[UIImageView alloc] init];
        _impreseimageview.layer.masksToBounds = YES;
        _impreseimageview.layer.cornerRadius = 8;
    }
    return _impreseimageview;
}

-(bottomimageView *)bottomview
{
    if(!_bottomview)
    {
        _bottomview = [[bottomimageView alloc] init];
       // _bottomview.backgroundColor = [UIColor whiteColor];
        _bottomview.image = [UIImage imageNamed:@"标签栏"];
       // _bottomview.alpha = 0.6;
    }
    return _bottomview;
}



@end
