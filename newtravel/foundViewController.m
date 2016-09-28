//
//  foundViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/7.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "foundViewController.h"
#import "dynamicTableViewCell.h"
#import "dynamicModel.h"
#import "jinxuanimageView.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "foundTableViewCell.h"
#import "foundModel.h"
@interface foundViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    int height;
    int width;
}
@property (nonatomic,strong) UIImageView *titlebgimageview;
@property (nonatomic,strong) UIButton *btn01;
@property (nonatomic,strong) UIButton *btn02;
@property (nonatomic,strong) UILabel *dynamicLabel;
@property (nonatomic,strong) UILabel *nearLabel;

@property (nonatomic,strong) UITableView *dynamicTableView;
@property (nonatomic,strong) NSMutableArray *dynamicarray;
@property (nonatomic,strong) NSMutableArray *foundarray;
@property (nonatomic,strong) UITextField *pingluntext;

@property (nonatomic,strong) UITableView *foundTableView;
@property (nonatomic,strong) jinxuanimageView *tuijianView;
@property (nonatomic,strong) UIImageView *foundimageview1;
@property (nonatomic,strong) UIImageView *foundimageview2;
@end

static NSString *kcellname1 = @"name1";
static NSString *kcellname2 = @"name2";
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
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textfiledremove)];
    [self.view addGestureRecognizer:singleTap1];
    
    [self dataformweb];
    
    [self.view addSubview:self.titlebgimageview];
    [self.view addSubview:self.btn01];
    [self.view addSubview:self.btn02];
    [self.view addSubview:self.dynamicLabel];
    [self.view addSubview:self.nearLabel];
    [self.view addSubview:self.dynamicTableView];
    
    [self.view addSubview:self.pingluntext];
    //增加监听，当键盘出现或改变时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [self.foundTableView setHidden:YES];
    [self.view addSubview:self.foundTableView];
    [self.tuijianView setHidden:YES];
    [self.view addSubview:self.foundimageview1];
    [self.view addSubview:self.foundimageview2];
    [self.view addSubview:self.tuijianView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.titlebgimageview.frame = CGRectMake(0, 64, UIScreenWidth, 70);
    self.btn01.frame = CGRectMake(UIScreenWidth/4-10, 69, 40, 40);
    self.btn02.frame = CGRectMake(UIScreenWidth/2+UIScreenWidth/4-10, 69, 40, 40);
    self.dynamicLabel.frame = CGRectMake(UIScreenWidth/4-10, 109, 40, 20);
    self.nearLabel.frame = CGRectMake(UIScreenWidth/2+UIScreenWidth/4-10, 109, 40, 20);
    self.dynamicTableView.frame = CGRectMake(0, 134, UIScreenWidth, UIScreenHeight-134-56);
    self.foundTableView.frame = CGRectMake(0, 134, UIScreenWidth, UIScreenHeight-134-200);
    self.tuijianView.frame = CGRectMake(15, UIScreenHeight-190, 30, 60);
    
    self.foundimageview1.frame = CGRectMake(15, UIScreenHeight-190, UIScreenWidth/2-30, 130);
    
    self.foundimageview2.frame = CGRectMake(UIScreenWidth/2+15, UIScreenHeight-190, UIScreenWidth/2-30, 130);
}

-(void)dataformweb
{
    self.dynamicarray = [NSMutableArray array];
    
    dynamicModel *model1 = [[dynamicModel alloc] init];
    model1.picimagestr = @"http://v1.qzone.cc/avatar/201401/31/20/11/52eb92dd6bcdf173.jpg%21200x200.jpg";
    model1.namestr = @"安妮";
    model1.timestr = @"12:30";
    model1.commentstr = @"面朝大海，春暖花开";
    model1.addressstr = @"巴厘岛";
    model1.mainimagearray = [NSMutableArray arrayWithObjects:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/h%3D200/sign=1e8feb8facd3fd1f2909a53a004f25ce/c995d143ad4bd113eff4cf935eafa40f4bfb0551.jpg"],[NSURL URLWithString:@"http://www.bz55.com/uploads1/allimg/120312/1_120312100435_8.jpg"], nil];
    
    [self.dynamicarray addObject:model1];
    
    dynamicModel *model2 = [[dynamicModel alloc] init];
    model2.picimagestr = @"http://v1.qzone.cc/avatar/201408/02/21/04/53dce1f65bc39427.png%21200x200.jpg";
    model2.namestr = @"陆伽";
    model2.timestr = @"13:30";
    model2.commentstr = @"梦想在远方";
    model2.addressstr = @"法意瑞";
    model2.mainimagearray = [NSMutableArray arrayWithObjects:[NSURL URLWithString:@"http://e.hiphotos.baidu.com/image/h%3D200/sign=1e8feb8facd3fd1f2909a53a004f25ce/c995d143ad4bd113eff4cf935eafa40f4bfb0551.jpg"],[NSURL URLWithString:@"http://www.bz55.com/uploads1/allimg/120312/1_120312100435_8.jpg"],[NSURL URLWithString:@"http://www.bz55.com/uploads1/allimg/120312/1_120312100435_8.jpg"], nil];
    
    [self.dynamicarray addObject:model2];
    
    
    self.foundarray = [NSMutableArray array];
    foundModel *foundmodel1 = [[foundModel alloc] init];
    foundmodel1.picimagestr = @"http://v1.qzone.cc/avatar/201408/02/21/04/53dce1f65bc39427.png%21200x200.jpg";
    foundmodel1.namestr = @"安妮";
    foundmodel1.addressstr = @"伦敦眼";
    foundmodel1.distancestr = @"离我最近";
    [self.foundarray addObject:foundmodel1];
    
    foundModel *foundmodel2 = [[foundModel alloc] init];
    foundmodel2.picimagestr = @"http://v1.qzone.cc/avatar/201306/13/02/02/51b8b79b33a6d057.jpg%21200x200.jpg";
    foundmodel2.namestr = @"皮卡丘";
    foundmodel2.addressstr = @"塔桥";
    foundmodel2.distancestr = @"2300KM";
    [self.foundarray addObject:foundmodel2];
    
    foundModel *foundmodel3 = [[foundModel alloc] init];
    foundmodel3.picimagestr = @"http://v1.qzone.cc/avatar/201311/26/19/22/5294845a4cd92974.jpg%21200x200.jpg";
    foundmodel3.namestr = @"向阳";
    foundmodel3.addressstr = @"白金汉宫";
    foundmodel3.distancestr = @"3200KM";
    [self.foundarray addObject:foundmodel3];
    
    
    foundModel *foundmodel4 = [[foundModel alloc] init];
    foundmodel4.picimagestr = @"http://v1.qzone.cc/avatar/201306/13/02/02/51b8b79b33a6d057.jpg%21200x200.jpg";
    foundmodel4.namestr = @"倾城";
    foundmodel4.addressstr = @"牛津大学";
    foundmodel4.distancestr = @"2500KM";
    [self.foundarray addObject:foundmodel4];
    
    foundModel *foundmodel5 = [[foundModel alloc] init];
    foundmodel5.picimagestr = @"http://v1.qzone.cc/avatar/201306/13/02/02/51b8b79b33a6d057.jpg%21200x200.jpg";
    foundmodel5.namestr = @"童话";
    foundmodel5.addressstr = @"大本钟";
    foundmodel5.distancestr = @"1900KM";
    [self.foundarray addObject:foundmodel5];

}

#pragma mark - getters

-(UIButton *)btn01
{
    if(!_btn01)
    {
        _btn01 = [[UIButton alloc] init];
        [_btn01 setImage:[UIImage imageNamed:@"动态图标"] forState:UIControlStateNormal];
        [_btn01 addTarget:self action:@selector(btn01click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn01;
}

-(UIButton *)btn02
{
    if(!_btn02)
    {
        _btn02 = [[UIButton alloc] init];
        [_btn02 setImage:[UIImage imageNamed:@"捡伴图标"] forState:UIControlStateNormal];
        [_btn02 addTarget:self action:@selector(btn02click) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn02;
}

-(UIImageView *)titlebgimageview
{
    if(!_titlebgimageview)
    {
        _titlebgimageview = [[UIImageView alloc] init];
        _titlebgimageview.image = [UIImage imageNamed:@"标签栏4"];
    }
    return _titlebgimageview;
}

-(UILabel *)dynamicLabel
{
    if(!_dynamicLabel)
    {
        _dynamicLabel = [[UILabel alloc] init];
        _dynamicLabel.adjustsFontSizeToFitWidth = YES;
        _dynamicLabel.text = @"动态";
        _dynamicLabel.textAlignment = NSTextAlignmentCenter;
        _dynamicLabel.textColor = UIColorFromRGB(0X27A18E);
    }
    return _dynamicLabel;
}

-(UILabel *)nearLabel
{
    if(!_nearLabel)
    {
        _nearLabel = [[UILabel alloc] init];
        _nearLabel.adjustsFontSizeToFitWidth = YES;
        _nearLabel.text = @"捡伴";
        _nearLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nearLabel;
}

-(UITableView *)dynamicTableView
{
    if(!_dynamicTableView)
    {
        _dynamicTableView = [[UITableView alloc] init];
        _dynamicTableView.dataSource = self;
        _dynamicTableView.delegate = self;
    }
    return _dynamicTableView;
}

-(UITextField *)pingluntext
{
    if(!_pingluntext)
    {
        _pingluntext = [[UITextField alloc] init];
        _pingluntext.delegate = self;
        _pingluntext.backgroundColor = [UIColor whiteColor];
        _pingluntext.layer.masksToBounds = YES;
        _pingluntext.layer.cornerRadius = 5;
        _pingluntext.layer.borderWidth = 1.0f;
    }
    return _pingluntext;
}

-(UITableView *)foundTableView
{
    if(!_foundTableView)
    {
        _foundTableView = [[UITableView alloc] init];
        _foundTableView.dataSource = self;
        _foundTableView.delegate = self;
    }
    return _foundTableView;
}

-(jinxuanimageView *)tuijianView
{
    if(!_tuijianView)
    {
        _tuijianView = [[jinxuanimageView alloc] init];
        _tuijianView.m_label.text = @"推\n荐";
        _tuijianView.image = [UIImage imageNamed:@"精选底纹"];
    }
    return _tuijianView;
}

-(UIImageView *)foundimageview1
{
    if(!_foundimageview1)
    {
        _foundimageview1 = [[UIImageView alloc] init];
        NSURL *url = [NSURL URLWithString:@"http://img05.tooopen.com/images/20140825/sy_69521589479.jpg"];
        [_foundimageview1 sd_setImageWithURL:url];
        [_foundimageview1 setHidden:YES];
        _foundimageview1.layer.masksToBounds = YES;
        _foundimageview1.layer.cornerRadius = 6;
    }
    return _foundimageview1;
}

-(UIImageView *)foundimageview2
{
    if(!_foundimageview2)
    {
        _foundimageview2 = [[UIImageView alloc] init];
        NSURL *url = [NSURL URLWithString:@"http://pic.58pic.com/58pic/10/96/96/58PIC3I58PICwcD.jpg"];
        [_foundimageview2 sd_setImageWithURL:url];
        [_foundimageview2 setHidden:YES];
        _foundimageview2.layer.masksToBounds = YES;
        _foundimageview2.layer.cornerRadius = 6;
    }
    return _foundimageview2;
}

#pragma mark - 实现方法

-(void)btn01click
{
    self.dynamicLabel.textColor = UIColorFromRGB(0X27A18E);
    self.nearLabel.textColor = [UIColor blackColor];
    self.title = @"动态";
    [self.dynamicTableView setHidden:NO];
    [self.foundTableView setHidden:YES];
    [self.tuijianView setHidden:YES];
    [self.foundimageview1 setHidden:YES];
    [self.foundimageview2 setHidden:YES];
    [self.btn01 setImage:[UIImage imageNamed:@"动态图标"] forState:UIControlStateNormal];
    [self.btn02 setImage:[UIImage imageNamed:@"捡伴图标"] forState:UIControlStateNormal];

}

-(void)btn02click
{
    self.nearLabel.textColor =  UIColorFromRGB(0X27A18E);
    self.dynamicLabel.textColor = [UIColor blackColor];
    self.title = @"捡伴";
    [self.dynamicTableView setHidden:YES];
    [self.foundTableView setHidden:NO];
    [self.tuijianView setHidden:NO];
    [self.foundimageview1 setHidden:NO];
    [self.foundimageview2 setHidden:NO];
    [self.btn01 setImage:[UIImage imageNamed:@"动态图标2"] forState:UIControlStateNormal];
    [self.btn02 setImage:[UIImage imageNamed:@"捡伴图标2"] forState:UIControlStateNormal];
    
}

#pragma mark UITableViewDataSource--UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.dynamicTableView)
    {
        return self.dynamicarray.count;
    }
    else
    {
        return self.foundarray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.dynamicTableView)
    {
        dynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname1];
        cell = [[dynamicTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname1];
        
        [cell setCellDate:self.dynamicarray[indexPath.row]];
        
        [cell.ThumbBtn addTarget:self action:@selector(dianzanbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [cell.commentsBtn addTarget:self action:@selector(pinglunbtnclick) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        foundTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcellname2];
        cell = [[foundTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kcellname2];
        [cell setCellDate2:self.foundarray[indexPath.row]];
        return cell;
    }

}

//cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.dynamicTableView) {
        return 250;
    }
    else
    {
        return 80;
    }
}

#pragma mark cell方法
-(void)dianzanbtnclick
{
    NSLog(@"点赞");
}

-(void)pinglunbtnclick
{
    NSLog(@"评论");
    [self.pingluntext becomeFirstResponder];
    [self.pingluntext setHidden:NO];
    self.pingluntext.frame = CGRectMake(5, UIScreenHeight-height-40, UIScreenWidth-10, 40);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - 观察者

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    /*
     iphone 6:
     中文
     2014-12-31 11:16:23.643 Demo[686:41289] 键盘高度是  258
     2014-12-31 11:16:23.644 Demo[686:41289] 键盘宽度是  375
     英文
     2014-12-31 11:55:21.417 Demo[1102:58972] 键盘高度是  216
     2014-12-31 11:55:21.417 Demo[1102:58972] 键盘宽度是  375
     
     iphone  6 plus：
     英文：
     2014-12-31 11:31:14.669 Demo[928:50593] 键盘高度是  226
     2014-12-31 11:31:14.669 Demo[928:50593] 键盘宽度是  414
     中文：
     2015-01-07 09:22:49.438 Demo[622:14908] 键盘高度是  271
     2015-01-07 09:22:49.439 Demo[622:14908] 键盘宽度是  414
     
     iphone 5 :
     2014-12-31 11:19:36.452 Demo[755:43233] 键盘高度是  216
     2014-12-31 11:19:36.452 Demo[755:43233] 键盘宽度是  320
     
     ipad Air：
     2014-12-31 11:28:32.178 Demo[851:48085] 键盘高度是  264
     2014-12-31 11:28:32.178 Demo[851:48085] 键盘宽度是  768
     
     ipad2 ：
     2014-12-31 11:33:57.258 Demo[1014:53043] 键盘高度是  264
     2014-12-31 11:33:57.258 Demo[1014:53043] 键盘宽度是  768
     */
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
     height = keyboardRect.size.height;
     width = keyboardRect.size.width;
    NSLog(@"键盘高度是  %d",height);
    NSLog(@"键盘宽度是  %d",width);
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [self.pingluntext setHidden:YES];
}

-(void)textfiledremove
{
    [self.pingluntext resignFirstResponder];
}

@end
