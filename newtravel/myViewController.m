//
//  myViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/7.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "myViewController.h"
#import "myinfoTableViewCell.h"
#import "setViewController.h"
#import "myinfoModel.h"
#import "friendViewController.h"
@interface myViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    myinfoModel *infomodel;
}
@property (nonatomic,strong) UITableView *myinfotableview;
@end
static NSString *kcellname1 = @"name1";
static NSString *kcellname2 = @"name2";
static NSString *kcellname3 = @"name3";
@implementation myViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES];
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

    [self datafromweb];
    
    [self.view addSubview:self.myinfotableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.myinfotableview.frame = CGRectMake(0, -20, UIScreenWidth, UIScreenHeight-35);
}

-(void)datafromweb
{
    infomodel = [[myinfoModel alloc] init];
    infomodel.myinfostr = @"http://img2.myhsw.cn/2015-12-29/q9z0b418.jpg";
    infomodel.myinfomessagestr = @"a simple woman";
    infomodel.myinfosignaturestr = @"梦想，并不奢侈，只要你够勇敢";
}

#pragma mark - getters

-(UITableView *)myinfotableview
{
    if(!_myinfotableview)
    {
        _myinfotableview = [[UITableView alloc] init];
        _myinfotableview.dataSource = self;
        _myinfotableview.delegate = self;
       
    }
    return _myinfotableview;
}

#pragma mark - UITableViewDataSource-UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 1;
    }
    else if (section==1)
    {
        return 2;
    }
    else
    {
    return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0) {
        myinfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname1];
        cell = [[myinfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname1];
        [cell setdatamyinfo:infomodel];
        [cell.leftbtn addTarget:self action:@selector(leftbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [cell.rightbtn addTarget:self action:@selector(rightbtnclick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else if (indexPath.section==1)
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname2];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname2];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.textLabel.text = @"全部行程";
            cell.imageView.image = [UIImage imageNamed:@"全部行程"];
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"我的订单";
            cell.imageView.image = [UIImage imageNamed:@"我的订单"];
        }
        return cell;
    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname3];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname3];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (indexPath.row==0) {
            cell.textLabel.text = @"我的好友";
            cell.imageView.image = [UIImage imageNamed:@"我的好友"];
        }
        if (indexPath.row==1) {
            cell.textLabel.text = @"设置";
            cell.imageView.image = [UIImage imageNamed:@"设置"];
        }
        return cell;
    }
    return nil;
}

//cell高度

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section==0)
    {
        return UIScreenHeight/3;
    }
    else if (indexPath.section==1)
    {
        return 60;
    }
    else
    {
        return 60;
    }
    
}

/**
 *  1.告诉tableview一共有多少组
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return 3;
}
/**
 *  第section组头部显示什么标题
 *
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // return @"标题";
    if (0 == section) {
        return nil;
    }else if (section==1)
    {
        return @"  ";
    }
    else
    {
        return @"  ";
    }
}
//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==1&&indexPath.row==0) {
        
    }
    if (indexPath.section==1&&indexPath.row==1) {
        
    }
    if (indexPath.section==2&&indexPath.row==0) {
        self.hidesBottomBarWhenPushed=YES;
        friendViewController *friendVC = [[friendViewController alloc] init];
        [self.navigationController pushViewController:friendVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    if (indexPath.section==2&&indexPath.row==1) {
        setViewController *setVC = [[setViewController alloc] init];
        [self.navigationController pushViewController:setVC animated:YES];
    }
    
}
#pragma mark - 实现方法

-(void)leftbtnclick
{
    NSLog(@"扫描");
}

-(void)rightbtnclick
{
    NSLog(@"通知");
}

@end
