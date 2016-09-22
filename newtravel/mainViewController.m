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
#import "pictripimageView.h"
#import "navigationimageView.h"
#import "managementimageView.h"
#import "moretripViewController.h"
#import "travelitViewController.h"
#import "imagecollectionViewController.h"
#import "tripnavViewController.h"
#import "tripmanageViewController.h"
static NSString *kcellname = @"name1";
@interface mainViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
{
    BOOL isequal;
    
    UIPageControl *pageControl; //指示当前处于第几个引导页
    UIScrollView *scrollView; //用于存放并显示引导页
    UIImageView *imageViewOne;
    UIImageView *imageViewTwo;
    UIImageView *imageViewThree;
}
@property (nonatomic,strong) UIImageView *backimageView;
@property (nonatomic,strong) UIButton *qrcodeBtn;
@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) NSString *addressStr;
@property (nonatomic,strong) tripimageView *trimView;
@property (nonatomic,strong) pictripimageView *picView;
@property (nonatomic,strong) navigationimageView *navView;
@property (nonatomic,strong) managementimageView *manageView;
@property (nonatomic,strong) UITextField *searchtext;
@property (nonatomic,strong) UITableView *addresstableView;
@property (nonatomic,strong) NSMutableArray *addressarr;


@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    isequal = YES;
    self.addressarr = [NSMutableArray arrayWithObjects:@"北京",@"上海",@"广州",@"深圳",@"天津",@"杭州",@"南京",@"重庆",@"西安", nil];
    [self.view addSubview:self.backimageView];
    [self.view addSubview:self.qrcodeBtn];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"晶格状态栏背景"] forBarMetrics:0];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫描"] style:UIBarButtonItemStylePlain target:self action:@selector(nextpus)];
    
    [self.navigationItem setTitleView:self.searchtext];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"address"style:UIBarButtonItemStylePlain target:self action:@selector(leftpusClick)];
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress5)];
    [self.view addGestureRecognizer:singleTap1];
    
    [self.view addSubview:self.trimView];
    [self.view addSubview:self.picView];
    [self.view addSubview:self.navView];
    [self.view addSubview:self.manageView];
    [self.view addSubview:self.addbtn];
    
    [self leftpop];
    [self.view addSubview:self.addresstableView];
    
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
    self.searchtext.frame = CGRectMake(UIScreenWidth/3, 26, UIScreenWidth/2, 30);
    
    [self.trimView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(UIScreenWidth/3.5, UIScreenWidth/3.5));
        make.top.equalTo(self.view).with.offset(180);
        make.left.equalTo(self.view).with.offset(UIScreenWidth/6);
        
    }];
    
    [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.trimView).with.offset(10+UIScreenWidth/3.5);
        make.bottom.equalTo(self.trimView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(UIScreenWidth/2.8, UIScreenWidth/2.8));
        
    }];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trimView).with.offset(UIScreenWidth/3.5+10);
        make.right.equalTo(self.trimView).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(UIScreenWidth/3, UIScreenWidth/3));

    }];
    
    [self.manageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.trimView).with.offset(UIScreenWidth/3.5);
        make.left.equalTo(self.trimView).with.offset(10+UIScreenWidth/3.5);
        make.size.mas_equalTo(CGSizeMake(UIScreenWidth/3.8, UIScreenWidth/3.8));

    }];
    [self.addbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(45);
        make.bottom.equalTo(self.view).with.offset(-94);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
   // self.addresstableView.frame = CGRectMake(20, 64-150, 60, 150);
    self.addresstableView.frame = CGRectMake(0, 0-250, UIScreenWidth, 250);
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

-(UITextField *)searchtext
{
    if(!_searchtext)
    {
        _searchtext = [[UITextField alloc] init];
        _searchtext.delegate = self;
        _searchtext.backgroundColor = [UIColor whiteColor];
        _searchtext.placeholder = @"请输入地址";
    }
    return _searchtext;
}

-(tripimageView *)trimView
{
    if(!_trimView)
    {
        _trimView = [[tripimageView alloc] init];
        _trimView.image = [UIImage imageNamed:@"旅行行程底纹"];
        
        _trimView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1)];
        [_trimView addGestureRecognizer:singleTap1];
    }
    return _trimView;
}

-(pictripimageView *)picView
{
    if(!_picView)
    {
        _picView = [[pictripimageView alloc] init];
        _picView.image = [UIImage imageNamed:@"图集底纹"];
        _picView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress2)];
        [_picView addGestureRecognizer:singleTap1];
    }
    return _picView;
}

-(navigationimageView *)navView
{
    if(!_navView)
    {
        _navView = [[navigationimageView alloc] init];
        _navView.image = [UIImage imageNamed:@"行程导航底纹"];
        _navView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress3)];
        [_navView addGestureRecognizer:singleTap1];
    }
    return _navView;
}

-(managementimageView *)manageView
{
    if(!_manageView)
    {
        _manageView = [[managementimageView alloc] init];
        _manageView.image = [UIImage imageNamed:@"行程管理底纹"];
        _manageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress4)];
        [_manageView addGestureRecognizer:singleTap1];
    }
    return _manageView;
}

-(UIButton *)addbtn
{
    if(!_addbtn)
    {
        _addbtn = [[UIButton alloc] init];
        [_addbtn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
        [_addbtn addTarget:self action:@selector(addbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addbtn;
}

-(UITableView *)addresstableView
{
    if(!_addresstableView)
    {
        _addresstableView = [[UITableView alloc] init];
        _addresstableView.dataSource = self;
        _addresstableView.delegate = self;
        //_addresstableView.backgroundColor = [UIColor redColor];
        
    }
    return _addresstableView;
}

#pragma mark - 实现方法

-(void)nextpus
{
    
}

-(void)leftpusClick
{
    if (isequal==YES) {
        [UIView animateWithDuration:0.3 animations:^{
            self.addresstableView.transform = CGAffineTransformMakeTranslation(0, 250+64);
            isequal = !isequal;
            [self.view bringSubviewToFront:self.addresstableView];
        }completion:^(BOOL finished) {
            
        }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.addresstableView.transform = CGAffineTransformIdentity;
            isequal = !isequal;
        }completion:^(BOOL finished) {
            
        }];
    }
}

-(void)buttonpress1
{
    NSLog(@"旅行行程");
    travelitViewController *traviVC = [[travelitViewController alloc] init];
    [self.navigationController pushViewController:traviVC animated:YES];
}

-(void)buttonpress2
{
    NSLog(@"行程图集");
    imagecollectionViewController *imageVC = [[imagecollectionViewController alloc] init];
    [self.navigationController pushViewController:imageVC animated:YES];
}

-(void)buttonpress3
{
    NSLog(@"行程导航");
    tripnavViewController *tripnavVC = [[tripnavViewController alloc] init];
    [self.navigationController pushViewController:tripnavVC animated:YES];
}

-(void)buttonpress4
{
    NSLog(@"行程管理");
    tripmanageViewController *tripmanageVC = [[tripmanageViewController alloc] init];
    [self.navigationController pushViewController:tripmanageVC animated:YES];
}

-(void)buttonpress5
{
    [self.searchtext resignFirstResponder];
}

-(void)addbtnclick
{
    NSLog(@"点击加号");
    moretripViewController *moreVC = [[moretripViewController alloc] init];
    
    //moreVC.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];
    
    moreVC.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    moreVC.modalPresentationStyle = UIModalPresentationOverFullScreen;

    [self presentViewController:moreVC animated:YES completion:^{
       // moreVC.view.superview.backgroundColor = [UIColor clearColor];
    }];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - UITableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=nil;
    cell=[tableView dequeueReusableCellWithIdentifier:kcellname];
    //如果重用队列中没有重用的对象，那么就创建一个新的cell
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.addressarr[indexPath.row];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    return cell;
}

//设置cell的高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

//点击cell方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell");
}

//滑动pop
-(void)leftpop
{
    self.navigationController.interactivePopGestureRecognizer.delegate  = (id)self;
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = UIInterfaceOrientationPortrait;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
    
}


@end
