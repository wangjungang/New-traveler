//
//  imageCollectionViewCell.m
//  OralEdu
//
//  Created by 王俊钢 on 16/6/30.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "imageCollectionViewCell.h"

@interface imageCollectionViewCell()

@property (nonatomic,strong)UIView          *hubView;
@property (nonatomic,strong)UIButton        *deleteBtn;

@end


@implementation imageCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageview = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, CGRectGetWidth(self.frame)-10, CGRectGetWidth(self.frame)-10)];
        self.nameUrl=[[NSString alloc]init];
        self.nameStr=[[NSString alloc]init];
        [self addSubview:self.imageview];
        //        self.text = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imageview.frame), CGRectGetWidth(self.frame)-10, 20)];
        //        self.text.textAlignment = NSTextAlignmentCenter;
        //        [self addSubview:self.text];
        
        //[self changeView];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)closeBtn:(UIButton *)sender{
    //    if (_delegate && [_delegate respondsToSelector:@selector(moveImageBtnClick:)]) {
    //        [_delegate moveImageBtnClick:self];
    //    }
    [[NSNotificationCenter defaultCenter]postNotificationName:@"clickToDelete" object:self];
    
}
-(void)hideLoginView{
    if (_delegate && [_delegate respondsToSelector:@selector(moveImageBtnClick:)]) {
        [_delegate moveImageBtnClick:self];
    }
}

-(void)changeView{
    //    [self addSubview:self.hubView];
    //    [self addSubview:self.deleteBtn];
    self.close  = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage * image = [UIImage imageNamed:@"delete"];
    [self.close setImage:image forState:UIControlStateNormal];
    [self.close setFrame:CGRectMake(self.frame.size.width-image.size.width, 0, image.size.width, image.size.height)];
    [self.close sizeToFit];
    [self.close addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.close];
    
}
-(void)releaseView{
    [self.close removeFromSuperview];
}

-(UIView *)hubView{
    if(!_hubView){
        _hubView = [[UIView alloc]initWithFrame:self.bounds];
        _hubView.backgroundColor = [UIColor blackColor];
        _hubView.alpha = 0.7f;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideLoginView)];
        [_hubView addGestureRecognizer:tap];
    }
    return _hubView;
}
-(UIButton *)deleteBtn{
    if(!_deleteBtn){
        _deleteBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage * image = [UIImage imageNamed:@"delete"];
        [_deleteBtn setImage:image forState:UIControlStateNormal];
        [_deleteBtn setFrame:CGRectMake(self.frame.size.width-image.size.width, 0, image.size.width, image.size.height)];
        [_deleteBtn sizeToFit];
        [_deleteBtn addTarget:self action:@selector(closeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBtn;
}

@end
