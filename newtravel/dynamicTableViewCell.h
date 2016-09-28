//
//  dynamicTableViewCell.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/26.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "dynamicModel.h"
@interface dynamicTableViewCell : UITableViewCell

@property (nonatomic,strong) UIImageView *picImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIImageView *addImageView;
@property (nonatomic,strong) UILabel *addressLabel;
@property (nonatomic,strong) UIButton *ThumbBtn;
@property (nonatomic,strong) UIButton *commentsBtn;

@property (nonatomic,strong) UIImageView *mainimageview;



-(void)setCellDate:(dynamicModel *)dymanic;
@end
