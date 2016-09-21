//
//  imageCollectionViewCell.h
//  OralEdu
//
//  Created by 王俊钢 on 16/6/30.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class imageCollectionViewCell;
@protocol imageCollectionCellDelegate <NSObject>

-(void)moveImageBtnClick:(imageCollectionViewCell *)aCell;

@end

@interface imageCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UIImageView *imageview;
@property(nonatomic ,strong)UILabel *text;
@property(nonatomic ,strong)UIButton *btn;
@property(nonatomic,strong)UIButton * close;
@property(nonatomic,strong)NSString *nameStr;
@property(nonatomic,strong)NSString *nameUrl;
@property(nonatomic,assign)id<imageCollectionCellDelegate>delegate;

-(void)changeView;
-(void)releaseView;

@end
