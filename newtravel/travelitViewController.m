//
//  travelitViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/20.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "travelitViewController.h"
#import "Masonry.h"
#import "moretripViewController.h"
@interface travelitViewController ()<UITableViewDataSource,UITableViewDelegate>

    {
        NSArray *_rowArray;
        NSArray *_sectionArray;
        NSMutableDictionary *_showDic;//用来判断分组展开与收缩的
        NSMutableArray *picarray;
        BOOL isequal;
    }

@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) UITableView *traveltableView;
@property (nonatomic,strong) UIImageView *arrowimageView;
@property (nonatomic,strong) UITableView *righttableview;
@property (nonatomic,strong) NSMutableArray *rightarr;
@property (nonatomic,strong) NSMutableArray *rightpicarr;
@property (nonatomic,strong) NSMutableDictionary *m_dict;
@property (nonatomic,strong) NSMutableArray *arr1;
@property (nonatomic,strong) NSMutableArray *arr2;
@property (nonatomic,strong) NSMutableArray *arr3;

@property (nonatomic,strong) UIImageView *imageview1;
@property (nonatomic,strong) UIImageView *imageview2;
@property (nonatomic,strong) UIImageView *imageview3;


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
    _m_dict=[NSMutableDictionary dictionary];
    
    self.arr1 = [NSMutableArray arrayWithObjects:@"贝斯特酒店",@"拉斯国际购物中心",@"金门大桥", nil];
    [self.m_dict setObject:self.arr1 forKey:@"首都国际机场"];
    self.arr2 = [NSMutableArray arrayWithObjects:@"喜来登酒店",@"暴风城",@"萨格拉斯",@"伊利丹", nil];
    [self.m_dict setObject:self.arr2 forKey:@"德拉诺"];
    self.arr3 = [NSMutableArray arrayWithObjects:@"基尔加丹",@"萨尔",@"古尔丹",@"阿尔萨斯",@"奥格瑞姆",@"杜隆坦",nil];
    [self.m_dict setObject:self.arr3 forKey:@"永恒之井"];
    
    picarray = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"酒店图标"],[UIImage imageNamed:@"购物图标"],[UIImage imageNamed:@"景点图标"], nil];
    
    self.rightarr = [NSMutableArray arrayWithObjects:@"展开行程",@"好友排名",@"优质行程" ,nil];
    self.rightpicarr = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"展开行程图标"],[UIImage imageNamed:@"好友排名图标"],[UIImage imageNamed:@"优质行程图标"], nil];
    isequal = YES;
    [self.view addSubview:self.righttableview];
    
    [self.view addSubview:self.imageview1];
    [self.view addSubview:self.imageview2];
    [self.view addSubview:self.imageview3];
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
    self.righttableview.frame = CGRectMake(UIScreenWidth-120, 64-100, 100, 100);
    
    self.imageview1.frame = CGRectMake(25, 94, 30, 30);
    self.imageview2.frame = CGRectMake(25, 180, 30, 30);
    self.imageview3.frame = CGRectMake(25, 266, 30, 30);
    
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

-(UITableView *)righttableview
{
    if(!_righttableview)
    {
        _righttableview = [[UITableView alloc] init];
        _righttableview.dataSource = self;
        _righttableview.delegate = self;
        _righttableview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"展开栏"]];
        
    }
    return _righttableview;
}

-(UIImageView *)imageview1
{
    if(!_imageview1)
    {
        _imageview1 = [[UIImageView alloc] init];
        _imageview1.image = [UIImage imageNamed:@"点图标"];
    }
    return _imageview1;
}

-(UIImageView *)imageview2
{
    if(!_imageview2)
    {
        _imageview2 = [[UIImageView alloc] init];
        _imageview2.image = [UIImage imageNamed:@"景点图标"];
    }
    return _imageview2;
}

-(UIImageView *)imageview3
{
    if(!_imageview3)
    {
        _imageview3 = [[UIImageView alloc]init];
        _imageview3.image = [UIImage imageNamed:@"酒店图标"];
    }
    return _imageview3;
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
    moretripViewController *moreVC = [[moretripViewController alloc] init];
    moreVC.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    moreVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:moreVC animated:YES completion:^{
        
    }];
}

-(void)nextpus
{
    if (isequal==YES) {
        [UIView animateWithDuration:0.3 animations:^{
            self.righttableview.transform = CGAffineTransformMakeTranslation(0, 100);
            isequal = !isequal;
            [self.view bringSubviewToFront:self.righttableview];
        }completion:^(BOOL finished) {
            
        }];
    }else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.righttableview.transform = CGAffineTransformIdentity;
            isequal = !isequal;
        }completion:^(BOOL finished) {
            
        }];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.traveltableView) {
//    return [_sectionArray count];
        
    return [self.m_dict allKeys].count;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.traveltableView) {
       // return _rowArray.count;
        //拿到数组中key的内容
        NSArray *array=[self.m_dict allKeys];
        //根据分组下标确定哪个key
        NSString *key=array[section];
        //通过key把对应的value拿到
        NSArray *value=self.m_dict[key];
        return [value count];
    }
    else
    {
        return self.rightarr.count;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.traveltableView) {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"这个自己命名"];
        if(cell==NULL){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"这个自己命名"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset=UIEdgeInsetsZero;
            cell.clipsToBounds = YES;
        }
        if (indexPath.section==2) {
            cell.imageView.image = picarray[indexPath.row];
        }
        //拿到字典中数组key的内容
        NSArray *array=[self.m_dict allKeys];
        //根据分组下标确定哪个key
        NSString *key=array[indexPath.section];
        //通过key把对应的value拿到
        NSArray *value=self.m_dict[key];
        
        cell.textLabel.text=value[indexPath.row];
        return cell;

    }
    else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"right"];
        if (cell==NULL) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"right"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset=UIEdgeInsetsZero;
            cell.clipsToBounds = YES;
            
        }
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
        cell.textLabel.text = self.rightarr[indexPath.row];
        cell.imageView.image = self.rightpicarr[indexPath.row];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView==self.traveltableView) {
        if ([_showDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]]) {
            return 44;
        }
        return 0;
    }
    else
    {
        return 30;
    }
}
//section头部高度

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView==self.traveltableView) {
        return 40;
    }
    else
    {
    return 0;
    }
}
//section尾部高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.traveltableView) {
        return 40;
    }
    else
    {
        return 0;
    }}
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

    myLabel.text =  [self.m_dict allKeys][section];
    
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
    
    NSString *key = [NSString stringWithFormat:@"%ld",(long)didSection];
    if (![_showDic objectForKey:key]) {
        [_showDic setObject:@"1" forKey:key];
        
    }else{
        [_showDic removeObjectForKey:key];
    }
    [self.traveltableView reloadSections:[NSIndexSet indexSetWithIndex:didSection] withRowAnimation:UITableViewRowAnimationFade];
    NSString *str = [_showDic objectForKey:key];

    if (didSection==0&&[str isEqualToString:@"1"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageview2.transform =CGAffineTransformMakeTranslation(0, 44*self.arr1.count+44);
        }completion:^(BOOL finished) {
            
        }];
        [UIView animateWithDuration:0.3 animations:^{
            self.imageview3.transform =CGAffineTransformMakeTranslation(0, 44*self.arr2.count+44);
        }completion:^(BOOL finished) {
            
        }];
        
    }
    if (didSection==0&&![str isEqualToString:@"1"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageview2.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        [UIView animateWithDuration:0.3 animations:^{
            self.imageview3.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    if (didSection==1&&[str isEqualToString:@"1"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageview3.transform =CGAffineTransformMakeTranslation(0, 44*self.arr2.count+44);
        }completion:^(BOOL finished) {
            
        }];
        
    }
    if (didSection==1&&![str isEqualToString:@"1"]) {
        [UIView animateWithDuration:0.3 animations:^{
            self.imageview3.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.m_dict allKeys][section];
}



@end
