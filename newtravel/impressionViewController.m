//
//  impressionViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/7.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "impressionViewController.h"
#import "impressTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
@interface impressionViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *impresstableview;
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) NSMutableArray *impresspicarr;
@end
static NSString *kcellname = @"name1";
@implementation impressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"晶格状态栏背景"] forBarMetrics:0];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"印象";
    
    NSString *str1 = @"http://pic11.nipic.com/20101205/213291_184733098980_2.jpg";
    NSString *str2 = @"http://sc.jb51.net/uploads/allimg/150414/11-150414121036148.jpg";
    NSString *str3 = @"http://img1.3lian.com/2015/w7/90/d/1.jpg";
    
    NSURL *url1 = [NSURL URLWithString:str1];
    NSURL *url2 = [NSURL URLWithString:str2];
    NSURL *url3 = [NSURL URLWithString:str3];
    
    self.impresspicarr = [NSMutableArray arrayWithObjects:url1,url2,url3,nil];
    
    [self.view addSubview:self.titlelabel];
    [self.view addSubview:self.impresstableview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titlelabel.frame = CGRectMake(20, 10+64, 80, 40);
    self.impresstableview.frame = CGRectMake(0, 64+50, UIScreenWidth, UIScreenHeight-170);
}

#pragma mark - getters

-(UITableView *)impresstableview
{
    if(!_impresstableview)
    {
        _impresstableview = [[UITableView alloc] init];
        _impresstableview.dataSource = self;
        _impresstableview.delegate = self;
    }
    return _impresstableview;
}

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"游记薄";
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel;
}

#pragma mark - DataSource -- Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.impresspicarr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    impressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname];
    if (!cell) {
        cell = [[impressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname];
    }
    [cell.impreseimageview sd_setImageWithURL:self.impresspicarr[indexPath.row]];
    return cell;
}
//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

//cell点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击了cell");
}

@end
