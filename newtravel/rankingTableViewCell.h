//
//  rankingTableViewCell.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class rankingModel;

@interface rankingTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *picimageview;
@property (nonatomic,strong) UILabel *namelabel;
@property (nonatomic,strong) UILabel *numberlabel;
@property (nonatomic,strong) UIImageView *rightimageview;
-(void)setrankingdata:(rankingModel *)rankingmodel;
@end
