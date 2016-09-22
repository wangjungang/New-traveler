//
//  tripmanageViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/22.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "tripmanageViewController.h"

@interface tripmanageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *managetableview;
@property (nonatomic,strong) NSMutableArray *manage_arr;
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
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.managetableview.frame = CGRectMake(0, 0, UIScreenWidth, UIScreenHeight-64);
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.manage_arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname1];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname1];
    cell.textLabel.text = self.manage_arr[indexPath.row];
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 100;
            break;
        case 1:
            return 60;
            break;
        case 2:
            return 80;
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
