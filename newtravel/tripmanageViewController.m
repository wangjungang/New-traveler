//
//  tripmanageViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/22.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "tripmanageViewController.h"
#import "manageTableViewCell1.h"
#import "manageTableViewCell2.h"
#import "manageTableViewCell3.h"
#import "addimageView.h"
@interface tripmanageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *managetableview;
@property (nonatomic,strong) NSMutableArray *manage_arr;
@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) addimageView *addview;
@end
static NSString *kcellname1 = @"name1";
static NSString *kcellname2 = @"name2";
static NSString *kcellname3 = @"name3";
@implementation tripmanageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"行程管理";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:self.managetableview];
    self.manage_arr = [NSMutableArray arrayWithObjects:@"1",@"2",@"3",nil];
    [self.view addSubview:self.addbtn];
    [self.view addSubview:self.addview];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.managetableview.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-64);
    self.addbtn.frame = CGRectMake(10, UIScreenHeight-120, 50, 50);
    self.addview.frame = CGRectMake(0, UIScreenHeight-10, UIScreenWidth, 150);
}

#pragma mark - getters

-(UITableView *)managetableview
{
    if(!_managetableview)
    {
        _managetableview = [[UITableView alloc] init];
        _managetableview.dataSource = self;
        _managetableview.delegate = self;
        _managetableview.backgroundColor = [UIColor lightGrayColor];
    }
    return _managetableview;
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

-(addimageView *)addview
{
    if(!_addview)
    {
        _addview = [[addimageView alloc] init];
        _addview.image = [UIImage imageNamed:@"展开框底纹"];
        _addview.userInteractionEnabled = YES;
        [_addview.closebtn addTarget:self action:@selector(addviewclosebtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_addview.btn1 addTarget:self action:@selector(btn01click) forControlEvents:UIControlEventTouchUpInside];
        [_addview.btn2 addTarget:self action:@selector(btn02click) forControlEvents:UIControlEventTouchUpInside];
        [_addview.btn3 addTarget:self action:@selector(btn03click) forControlEvents:UIControlEventTouchUpInside];
        [_addview.btn4 addTarget:self action:@selector(btn04click) forControlEvents:UIControlEventTouchUpInside];
        [_addview.btn5 addTarget:self action:@selector(btn05click) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _addview;
}

#pragma mark - 实现方法

-(void)addbtnclick
{
    NSLog(@"点击了加号");
    
    [UIView animateWithDuration:0.3 animations:^{
        self.addview.transform =CGAffineTransformMakeTranslation(0, -200);
    }completion:^(BOOL finished) {
    
    }];
}

-(void)addviewclosebtnclick
{
    NSLog(@"点击关闭");
    [UIView animateWithDuration:0.3 animations:^{
        self.addview.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}
//实时路况
-(void)btn01click
{
    NSLog(@"实时路况");
}
//修改行程
-(void)btn02click
{
    NSLog(@"修改行程");
}
//刷新行程
-(void)btn03click
{
    NSLog(@"刷新行程");
}
//我的收藏
-(void)btn04click
{
    NSLog(@"我的收藏");
}
//周边推荐
-(void)btn05click
{
    NSLog(@"周边推荐");
}
#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // return self.manage_arr.count;
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
       if (indexPath.row==0) {
           manageTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:kcellname1];
           

        cell = [[manageTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname1];
           return cell;
    }
    if (indexPath.row==1) {
        manageTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:kcellname2];
        
        
        cell = [[manageTableViewCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname2];
        return cell;
    }
    if (indexPath.row==2) {
        manageTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:kcellname3];
        cell = [[manageTableViewCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname3];
        return cell;
    }
    return nil;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return UIScreenHeight/5;
            break;
        case 1:
            return UIScreenHeight/2.6;
            break;
        case 2:
            return UIScreenHeight-64*2-UIScreenHeight/5-UIScreenHeight/2.6;
            break;
        default:
            break;
    }
    return 0;
}

//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell");
}
@end
