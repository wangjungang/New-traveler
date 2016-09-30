//
//  friendViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/13.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "friendViewController.h"
#import "friendTableViewCell.h"
#import "rankingTableViewCell.h"
#import "friendlistModel.h"
#import "rankingTableViewCell.h"
#import "rankingModel.h"
#import "addfriendimageView.h"
@interface friendViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableDictionary *_showDic;//用来判断分组展开与收缩的
}
@property (nonatomic,strong) UIImageView *bgimageView;
@property (nonatomic,strong) UIButton *backbtn;
@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UITableView *friendtableview;
@property (nonatomic,strong) NSMutableArray *friendarray;
@property (nonatomic,strong) NSMutableArray *rankingarray;
@property (nonatomic,strong) addfriendimageView *addView;
@end

static NSString *kcellname1 = @"name1";
static NSString *kcellname2 = @"name2";

@implementation friendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [self.view addSubview:self.bgimageView];
    [self.view addSubview:self.backbtn];
    [self.view addSubview:self.addbtn];
    [self.view addSubview:self.titlelabel];
    [self.view addSubview:self.friendtableview];
    [self.view addSubview:self.addView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.backbtn.frame = CGRectMake(20, 20, 50, 50);
    self.addbtn.frame = CGRectMake(UIScreenWidth-70, 20, 50, 50);
    self.titlelabel.frame = CGRectMake(UIScreenWidth/2-40, 20, 80, 50);
    self.friendtableview.frame = CGRectMake(0, 70, UIScreenWidth, UIScreenHeight-70);
    self.addView.frame = CGRectMake(0, -120, UIScreenWidth, 120);
}

-(void)datafromweb
{
    self.friendarray = [NSMutableArray array];
    
    friendlistModel *model1 = [[friendlistModel alloc] init];
    model1.friendpicimageurlstr = @"http://p.3761.com/pic/84201393378242.jpg";
    model1.friendnamestr = @"恩佐";
    [self.friendarray addObject:model1];
    
    friendlistModel *model2 = [[friendlistModel alloc] init];
    model2.friendpicimageurlstr = @"http://p.3761.com/pic/84201393378242.jpg";
    model2.friendnamestr = @"南你";
    [self.friendarray addObject:model2];
    
    friendlistModel *model3 = [[friendlistModel alloc] init];
    model3.friendpicimageurlstr = @"http://p.3761.com/pic/84201393378242.jpg";
    model3.friendnamestr = @"兰溪";
    [self.friendarray addObject:model3];
    

    friendlistModel *model4 = [[friendlistModel alloc] init];
    model4.friendpicimageurlstr = @"http://p.3761.com/pic/84201393378242.jpg";
    model4.friendnamestr = @"晨曦";
    [self.friendarray addObject:model4];

    
    friendlistModel *model5 = [[friendlistModel alloc] init];
    model5.friendpicimageurlstr = @"http://p.3761.com/pic/84201393378242.jpg";
    model5.friendnamestr = @"普家";
    [self.friendarray addObject:model5];
    
    self.rankingarray = [NSMutableArray array];
    
    rankingModel *ranking1 = [[rankingModel alloc] init];
    ranking1.rankingpicimagestr = @"http://p.3761.com/pic/84201393378242.jpg";
    ranking1.rankingnamestr = @"兰溪";
    ranking1.rankingnumberstr = @"23433";
    ranking1.rightimagestr = @"排名榜第4";
    [self.rankingarray addObject:ranking1];
    
    rankingModel *ranking2 = [[rankingModel alloc] init];
    ranking2.rankingpicimagestr = @"http://p.3761.com/pic/84201393378242.jpg";
    ranking2.rankingnamestr = @"普家";
    ranking2.rankingnumberstr = @"3433";
    ranking2.rightimagestr = @"排名榜第4";
    [self.rankingarray addObject:ranking2];

    rankingModel *ranking3 = [[rankingModel alloc] init];
    ranking3.rankingpicimagestr = @"http://p.3761.com/pic/84201393378242.jpg";
    ranking3.rankingnamestr = @"晨曦";
    ranking3.rankingnumberstr = @"2633";
    ranking3.rightimagestr = @"排名榜第4";
    [self.rankingarray addObject:ranking3];
    
    rankingModel *ranking4 = [[rankingModel alloc] init];
    ranking4.rankingpicimagestr = @"http://p.3761.com/pic/84201393378242.jpg";
    ranking4.rankingnamestr = @"恩佐";
    ranking4.rankingnumberstr = @"2332";
    ranking4.rightimagestr = @"排名榜第4";
    [self.rankingarray addObject:ranking4];
    
}

#pragma mark - getters

-(UIImageView *)bgimageView
{
    if(!_bgimageView)
    {
        _bgimageView = [[UIImageView alloc] init];
        _bgimageView.frame = [UIScreen mainScreen].bounds;
        _bgimageView.image = [UIImage imageNamed:@"BG2"];
    }
    return _bgimageView;
}

-(UIButton *)backbtn
{
    if(!_backbtn)
    {
        _backbtn = [[UIButton alloc] init];
        [_backbtn setImage:[UIImage imageNamed:@"返回2"] forState:UIControlStateNormal];
        [_backbtn addTarget:self action:@selector(backbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backbtn;
}

-(UIButton *)addbtn
{
    if(!_addbtn)
    {
        _addbtn = [[UIButton alloc] init];
        [_addbtn setImage:[UIImage imageNamed:@"加好友图标"] forState:UIControlStateNormal];
        [_addbtn addTarget:self action:@selector(addbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addbtn;
}

-(UILabel *)titlelabel
{
    if(!_titlelabel)
    {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.text = @"好友列表";
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        _titlelabel.textColor = [UIColor whiteColor];
        _titlelabel.backgroundColor = [UIColor clearColor];
    }
    return _titlelabel;
}

-(UITableView *)friendtableview
{
    if(!_friendtableview)
    {
        _friendtableview = [[UITableView alloc] init];
        _friendtableview.dataSource = self;
        _friendtableview.delegate = self;
        _friendtableview.tableFooterView = [[UIView alloc]init];
        _friendtableview.backgroundColor = [UIColor clearColor];
    }
    return _friendtableview;
}

-(addfriendimageView *)addView
{
    if(!_addView)
    {
        _addView = [[addfriendimageView alloc] init];
        _addView.image = [UIImage imageNamed:@"展开栏底纹"];
        _addView.userInteractionEnabled = YES;
        [_addView.backbtn addTarget:self action:@selector(addviewbackbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addView;
}

#pragma mark - 实现方法

-(void)backbtnclick
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addbtnclick
{
    [UIView animateWithDuration:0.3 animations:^{
        self.addView.transform =CGAffineTransformMakeTranslation(0, 120);
    }completion:^(BOOL finished) {
        
    }];
}

-(void)addviewbackbtnclick
{
    [UIView animateWithDuration:0.3 animations:^{
        self.addView.transform = CGAffineTransformIdentity;
    }completion:^(BOOL finished) {
        
    }];
}

#pragma mark - UITableViewDataSource--UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"numberOfSectionsInTableView");
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return self.friendarray.count;
    }
    else
    {
    return self.rankingarray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        friendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname1];
        cell = [[friendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.layer.cornerRadius = 30;
        [cell setdatafriend:self.friendarray[indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    else
    {
        rankingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname2];
        cell = [[rankingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.separatorInset=UIEdgeInsetsZero;
        cell.clipsToBounds = YES;
        [cell setrankingdata:self.rankingarray[indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) {
        return 60;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // return @"标题";
    if (0 == section) {
        return @"好友列表";
    }else
    {
        return @"好友排名";
    }
        
}

//section头部高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

//section头部显示的内容
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    header.backgroundColor = UIColorFromRGB(0X27A18E);
   // header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"底纹2"]];
    
    UILabel *myLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 15, 150, 20)];
   
    
    if (section==0) {
         myLabel.text = @"全部好友";
    }
    if (section==1) {
        myLabel.text = @"好友排名";
    }
    
    myLabel.textColor = [UIColor whiteColor];
    [header addSubview:myLabel];
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
    
    NSString *key = [NSString stringWithFormat:@"%ld",(long)didSection];
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@"1" forKey:key];
        
    }else{
        [_showDic removeObjectForKey:key];
    }
    [self.friendtableview reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
//    NSString *str = [_showDic objectForKey:key];
    
    
}
//是否允许编辑行，默认是YES

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//修改删除按钮为中文的删除

-(NSString*)tableView:(UITableView*)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath*)indexPath
{
    return@"删除";
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一个删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        NSLog(@"点击了删除");
    
        friendTableViewCell *cell = [[friendTableViewCell alloc] init];
        rankingTableViewCell *cell2 = [[rankingTableViewCell alloc] init];
        
        if (indexPath.section==0) {
      
            // 2. 更新UI
            [_friendarray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            cell=[self.friendtableview cellForRowAtIndexPath:indexPath];
            
//            [self.friendtableview reloadData];
        }
        if (indexPath.section==1) {
            cell2=[self.friendtableview cellForRowAtIndexPath:indexPath];
            
//            [self.friendtableview reloadData];
            // 2. 更新UI
            [_rankingarray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        }];
    
    deleteRowAction.backgroundColor = [UIColor clearColor];
    
    return @[deleteRowAction];
}

@end
