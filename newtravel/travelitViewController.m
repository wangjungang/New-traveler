//
//  travelitViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/20.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "travelitViewController.h"
#import "Masonry.h"

@interface travelitViewController ()<UITableViewDataSource,UITableViewDelegate>

    {
        NSArray *_rowArray;
        NSArray *_sectionArray;
        NSMutableDictionary *_showDic;//用来判断分组展开与收缩的
        NSMutableArray *picarray;
    }

@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) UITableView *traveltableView;
@property (nonatomic,strong) UIImageView *arrowimageView;
@end

@implementation travelitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫描"] style:UIBarButtonItemStylePlain target:self action:@selector(nextpus)];
    [self.navigationController.navigationBar setTitleTextAttributes:
  @{NSFontAttributeName:[UIFont systemFontOfSize:19],
    NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = @"旅行行程";
    [self leftpop];
    [self.view addSubview:self.traveltableView];
    [self.view addSubview:self.addbtn];
    _sectionArray = [NSArray arrayWithObjects:@"首都国际机场",@"洛杉矶国际机场",@"贝斯特酒店",@"胡佛水坝", nil];
    
    _rowArray = [NSArray arrayWithObjects:@"贝斯特酒店",@"拉斯国际购物中心",@"金门大桥", nil];

    picarray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"酒店图标"],[UIImage imageNamed:@"购物图标"],[UIImage imageNamed:@"景点图标"], nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.addbtn.frame = CGRectMake(20, UIScreenHeight-130, 60, 60);
    self.traveltableView.frame = CGRectMake(80, 64, UIScreenWidth-120, UIScreenHeight-164);
}

#pragma mark - getters

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

-(UITableView *)traveltableView
{
    if(!_traveltableView)
    {
        _traveltableView = [[UITableView alloc] init];
        _traveltableView.dataSource = self;
        _traveltableView.delegate = self;
        //_traveltableView.backgroundColor = [UIColor lightGrayColor];
        _traveltableView.tableFooterView = [[UIView alloc]init];
    }
    return _traveltableView;
}

-(UIImageView *)arrowimageView
{
    if(!_arrowimageView)
    {
        _arrowimageView = [[UIImageView alloc] init];
        _arrowimageView.image = [UIImage imageNamed:@"展开箭头1"];
    }
    return _arrowimageView;
}

#pragma mark - 实现方法
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

-(void)addbtnclick
{
    
}

-(void)nextpus
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_rowArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"这个自己命名"];
    if(cell==NULL){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"这个自己命名"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
    }
    
    cell.textLabel.text = _rowArray[indexPath.row];
    cell.imageView.image = picarray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",indexPath.section]]) {
        return 44;
    }
    return 0;
}
//section头部高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
//section尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 40;
}
//section头部显示的内容

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    header.backgroundColor = UIColorFromRGB(0X27A18E);
    UIImageView *picview = [[UIImageView alloc] init];
    picview.frame = CGRectMake(10, 5, 20, 25);
    picview.image = [UIImage imageNamed:@"定位"];
    [header addSubview:picview];
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 5, 150, 20)];
    self.arrowimageView.frame = CGRectMake(self.traveltableView.frame.size.width-30, 8, 15, 12);

    myLabel.text = _sectionArray[section];
    myLabel.textColor = [UIColor whiteColor];
    [header addSubview:myLabel];
    [header addSubview:self.arrowimageView];
    // 单击的 Recognizer ,收缩分组cell
    header.tag = section;
    
    UITapGestureRecognizer *singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(SingleTap:)];
    singleRecognizer.numberOfTapsRequired = 1; //点击的次数 =1:单击
    [singleRecognizer setNumberOfTouchesRequired:1];//1个手指操作
    [header addGestureRecognizer:singleRecognizer];//添加一个手势监测；
    
    return header;
}

#pragma mark 展开收缩section中cell 手势监听
-(void)SingleTap:(UITapGestureRecognizer*)recognizer{
    NSInteger didSection = recognizer.view.tag;
    
    if (!_showDic) {
        _showDic = [[NSMutableDictionary alloc]init];
    }
    
    NSString *key = [NSString stringWithFormat:@"%ld",didSection];
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@"1" forKey:key];
        
    }else{
        [_showDic removeObjectForKey:key];
    }
    [self.traveltableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
}


@end
