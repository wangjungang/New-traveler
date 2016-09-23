//
//  manageTableViewCell1.h
//  newtravel
//
//  Created by 王俊钢 on 16/9/22.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface manageTableViewCell1 : UITableViewCell<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *rollScrollView;
@property (nonatomic, strong) NSMutableArray *imageArray;
@property (nonatomic, strong) UIImageView *rollImgView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end
