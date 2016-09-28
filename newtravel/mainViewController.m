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
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "qrcodeViewController.h"
#import "loginViewController.h"
static NSString *kcellname = @"name1";
@interface mainViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UIScrollViewAccessibilityDelegate,CLLocationManagerDelegate,MKMapViewDelegate>
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

@property(strong,nonatomic) CLLocationManager *myLocationManager;
@property(strong,nonatomic) CLGeocoder *myGeocoder;
@property(strong,nonatomic) CLLocation *myLocation;

@property (nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic,strong) UIButton *loginbtn;
@end

@implementation mainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self positioning];

    
    isequal = YES;
    self.addressarr = [NSMutableArray arrayWithObjects:@"北京",@"上海",@"广州",@"深圳",@"天津",@"杭州",@"南京",@"重庆",@"西安", nil];
    [self.view addSubview:self.backimageView];
    [self.view addSubview:self.qrcodeBtn];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"晶格状态栏背景"] forBarMetrics:0];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"扫描"] style:UIBarButtonItemStylePlain target:self action:@selector(nextpus2)];
    
    [self.navigationItem setTitleView:self.searchtext];
    
  
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
    [self.view addSubview:self.loginbtn];
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
    
    self.loginbtn.frame = CGRectMake(UIScreenWidth-200, UIScreenHeight-250, 100, 100);
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
        _searchtext.layer.masksToBounds = YES;
        _searchtext.layer.cornerRadius = 6;
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
       _addresstableView.userInteractionEnabled = YES;

    }
    return _addresstableView;
}

-(UIButton *)loginbtn
{
    if(!_loginbtn)
    {
        _loginbtn = [[UIButton alloc] init];
        [_loginbtn setTitle:@"登陆" forState:UIControlStateNormal];
        [_loginbtn addTarget:self action:@selector(logininbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginbtn;
}


#pragma mark - 实现方法

-(void)nextpus2
{
    qrcodeViewController *qrcodevc = [[qrcodeViewController alloc] init];
    [self.navigationController pushViewController:qrcodevc animated:YES];
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

-(void)logininbtnclick
{
    loginViewController *longinVC = [[loginViewController alloc] init];
    [self presentViewController:longinVC animated:YES completion:^{
        
    }];
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



-(void)positioning
{
    self.locationManager=[[CLLocationManager alloc] init];
    self.locationManager.delegate=self;
    self.locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    self.locationManager.distanceFilter=10;
    
    [self.locationManager requestWhenInUseAuthorization];//使用程序其间允许访问位置数据（iOS8定位需要）
    
    [self.locationManager startUpdatingLocation];//开启定位
}

- (void)locate{
    // 判断定位操作是否被允许
    if([CLLocationManager locationServicesEnabled]) {
        //定位初始化
        _locationManager=[[CLLocationManager alloc] init];
        _locationManager.delegate=self;
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        _locationManager.distanceFilter=10;
        [_locationManager startUpdatingLocation];//开启定位
    }else {
        //提示用户无法进行定位操作
        //        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@提示 message:@定位不成功 ,请确认开启定位 delegate:nil cancelButtonTitle:@取消 otherButtonTitles:@确定, nil];
        //        [alertView show];
        
    }
    // 开始定位
    [_locationManager startUpdatingLocation];
}

#pragma mark - CoreLocation Delegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //此处locations存储了持续更新的位置坐标值，取最后一个值为最新位置，如果不想让其持续更新位置，则在此方法中获取到一个值之后让locationManager stopUpdatingLocation
    CLLocation *currentLocation = [locations lastObject];
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //NSLog(@%@,placemark.name);//具体位置
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
             self.addressStr = city;
             NSLog(@"定位完成:%@",self.addressStr);
             self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:self.addressStr style:UIBarButtonItemStylePlain target:self action:@selector(leftpusClick)];
             
            // self.address_label.text = self.addressStr;
             //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
             [manager stopUpdatingLocation];
         }else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];
}


@end
