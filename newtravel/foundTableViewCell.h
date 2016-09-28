//
//  foundTableViewCell.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class foundModel;
@interface foundTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *picimageview;
@property (nonatomic,strong) UIImageView *addressimageview;
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UILabel *addresslabel;
@property (nonatomic,strong) UILabel *distancelabel;

-(void)setCellDate2:(foundModel *)found;
@end
