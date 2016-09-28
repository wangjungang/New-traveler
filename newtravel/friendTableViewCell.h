//
//  friendTableViewCell.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class friendlistModel;
@interface friendTableViewCell : UITableViewCell
@property (nonatomic,strong) UIButton *rightbtn;

-(void)setdatafriend:(friendlistModel *)friendlist;
@end
