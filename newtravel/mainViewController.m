//
//  mainViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/7.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "mainViewController.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "tripimageView.h"
@interface mainViewController ()<UISearchBarDelegate>
@property (nonatomic,strong) UIImageView *backimageView;
@property (nonatomic,strong) UIButton *qrcodeBtn;
@property (nonatomic,strong) UIButton *addressBtn;
@property (nonatomic,strong) UISearchBar *searchBar;
@property (nonatomic,strong) NSString *addressStr;
@property (nonatomic,strong) tripimageView *trimView;
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backimageView];
    [self.view addSubview:self.qrcodeBtn];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"晶格状态栏背景"] forBarMetrics:0];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫描"] style:UIBarButtonItemStylePlain target:self action:@selector(nextpus)];
    [self.navigationController.view addSubview:self.searchBar];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"address"style:UIBarButtonItemStylePlain target:self action:@selector(leftpusClick)];
    
    [self.view addSubview:self.trimView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidDisappear:(BOOL)animated
{
    self.hidesBottomBarWhenPushed = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.backimageView.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight);
    self.searchBar.frame = CGRectMake(UIScreenWidth/3, 24, UIScreenWidth/2, 30);
    self.trimView.frame = CGRectMake(UIScreenWidth/6, 180, UIScreenWidth/3.5, UIScreenWidth/3.5);
    
}

#pragma mark - getters

-(UIImageView *)backimageView
{
    if(!_backimageView)
    {
        _backimageView = [[UIImageView alloc] init];
        _backimageView.image = [UIImage imageNamed:@"背景图片4"];
        
    }
    return _backimageView;
}

-(UISearchBar *)searchBar
{
    if(!_searchBar)
    {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self;
        _searchBar.backgroundImage = [UIImage imageNamed:@"搜索框"];
        
    }
    return _searchBar;
}


-(tripimageView *)trimView
{
    if(!_trimView)
    {
        _trimView = [[tripimageView alloc] init];
        _trimView.image = [UIImage imageNamed:@"旅行行程底纹"];
    }
    return _trimView;
}


#pragma mark - 实现方法

-(void)nextpus
{
    
}

-(void)leftpusClick
{

}

@end
