//
//  myinfoTableViewCell.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/27.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myinfoModel;
@interface myinfoTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *bgimageview;
@property (nonatomic,strong) UIImageView *picimageview;
@property (nonatomic,strong) UIButton *leftbtn;
@property (nonatomic,strong) UIButton *rightbtn;
@property (nonatomic,strong) UILabel *messagelabel;
@property (nonatomic,strong) UILabel * signaturelabel;
-(void)setdatamyinfo:(myinfoModel *)myinfo;
@end
