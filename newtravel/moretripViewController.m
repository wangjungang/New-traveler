//
//  moretripViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/20.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "moretripViewController.h"
#import "Masonry.h"
@interface moretripViewController ()
@property (nonatomic,strong) UIButton *delbtn;
@end

@implementation moretripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [self.view addSubview:self.delbtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.delbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(45);
        make.bottom.equalTo(self.view).with.offset(-94);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];}

#pragma mark - getters

-(UIButton *)delbtn
{
    if(!_delbtn)
    {
        _delbtn = [[UIButton alloc] init];
        [_delbtn setImage:[UIImage imageNamed:@"关闭图标"] forState:UIControlStateNormal];
        [_delbtn addTarget:self action:@selector(delbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delbtn;
}

#pragma mark - 点击事件

-(void)delbtnclick
{
    NSLog(@"点击关闭图标");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
