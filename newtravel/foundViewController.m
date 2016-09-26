//
//  foundViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/7.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "foundViewController.h"

@interface foundViewController ()
@property (nonatomic,strong) UIButton *btn01;
@property (nonatomic,strong) UIButton *btn02;
@end

@implementation foundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"晶格状态栏背景"] forBarMetrics:0];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"动态";
    
    [self.view addSubview:self.btn01];
    [self.view addSubview:self.btn02];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark - getters

-(UIButton *)btn01
{
    if(!_btn01)
    {
        _btn01 = [[UIButton alloc] init];
        
        [_btn01 addTarget:self action:@selector(btn01click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn01;
}

-(UIButton *)btn02
{
    if(!_btn02)
    {
        _btn02 = [[UIButton alloc] init];
        
        [_btn02 addTarget:self action:@selector(btn02click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn02;
}




#pragma mark - 实现方法

-(void)btn01click
{
    
}

-(void)btn02click
{
    
}
@end
