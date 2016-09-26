//
//  imagecollectionViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/21.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "imagecollectionViewController.h"
#import "imageCollectionViewCell.h"
#import "MyHeadView.h"
#import "MyFootView.h"
@interface imagecollectionViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,imageCollectionCellDelegate,UICollectionViewDelegateFlowLayout>
{
     BOOL isEdit;
}
@property (nonatomic,strong) UIImageView *bgimageview;
@property (nonatomic,strong) UICollectionView *image_collectionview;
@property (nonatomic,strong) NSMutableArray *image_array;

@property (nonatomic,strong) NSMutableArray *image_arr1;
@property (nonatomic,strong) NSMutableArray *image_arr2;
@property (nonatomic,strong) NSMutableArray *image_arr3;
@property (nonatomic,strong) imageCollectionViewCell *cell;

@end
static NSString *collectionview = @"imagecell";
@implementation imagecollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图集";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.view addSubview:self.bgimageview];

    
    
    self.image_arr1 = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"1-2"],[UIImage imageNamed:@"1-3"], [UIImage imageNamed:@"2-2"],[UIImage imageNamed:@"2-3"],[UIImage imageNamed:@"2-5"],[UIImage imageNamed:@"3-1"],nil];
    self.image_arr2 = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"1-2"],[UIImage imageNamed:@"1-3"], [UIImage imageNamed:@"2-2"],[UIImage imageNamed:@"2-3"],[UIImage imageNamed:@"2-5"],[UIImage imageNamed:@"3-1"],nil];
    self.image_arr3 = [NSMutableArray arrayWithObjects:[UIImage imageNamed:@"1-2"],[UIImage imageNamed:@"1-3"], [UIImage imageNamed:@"2-2"],[UIImage imageNamed:@"2-3"],[UIImage imageNamed:@"2-5"],nil];
    
    self.image_array = [NSMutableArray arrayWithObjects:self.image_arr1,self.image_arr2,self.image_arr3, nil];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"新建图标"] style:UIBarButtonItemStylePlain target:self action:@selector(addbtnclick)];
    
    [self.view addSubview:self.image_collectionview];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.bgimageview.frame = [UIScreen mainScreen].bounds;
    [self addTheCollectionView];
}

//创建uicollectionview

-(void)addTheCollectionView{
    
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.image_collectionview = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight-64*2) collectionViewLayout:flowLayout];
    flowLayout.sectionInset = UIEdgeInsetsMake(20,0,0,0);
    //设置代理
    self.image_collectionview.delegate = self;
    self.image_collectionview.dataSource = self;
    self.image_collectionview.backgroundColor = [UIColor clearColor];
    //注册cell和ReusableView（相当于头部）
    _image_collectionview.allowsMultipleSelection = YES;//默认为NO,是否可以多选
    
#pragma mark -- 头尾部大小设置
    //设置头部并给定大小
    [flowLayout setHeaderReferenceSize:CGSizeMake(UIScreenWidth, 50)];
//    //设置尾部并给定大小
//    [flowLayout setFooterReferenceSize:CGSizeMake(UIScreenWidth, 50)];
    
#pragma mark -- 注册单元格
    [_image_collectionview registerClass:[imageCollectionViewCell class] forCellWithReuseIdentifier:collectionview];
    
#pragma mark -- 注册头部视图
    [self.image_collectionview registerClass:[MyHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//#pragma mark -- 注册尾部视图
//    [self.image_collectionview registerClass:[MyFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    
    [self.view addSubview:self.image_collectionview];
    
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   // return self.image_array.count;
      return [[self.image_array objectAtIndex:section]count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionview forIndexPath:indexPath];
    _cell.delegate = self;
    [_cell releaseView];
//    if(isEdit==YES){
//        [_cell changeView];
//    }else{
//        
//        [_cell releaseView];
//    }
//    _cell.nameStr=self.name_arr[indexPath.item];
//    _cell.nameUrl=self.url_arr[indexPath.item];
    
//          recipeImageView.image = [UIImage imagedNamed:[recipeImages[indexPath.section] objectAtIndex:indexPath.row]];
    
    _cell.imageview.image = [self.image_array[indexPath.section] objectAtIndex:indexPath.row];
    
    return _cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((UIScreenWidth-20)/3, (UIScreenWidth-20)/3);
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //        UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //        cell.backgroundColor = [UIColor redColor];
    NSLog(@"选择%ld",indexPath.row);
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//有多少个Section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.image_array.count;
}

//设置头尾部内容
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        //定制头部视图的内容
        MyHeadView *headerV = (MyHeadView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
//        headerV.titleLab.text = @"头部视图";
        if (indexPath.section==0) {
            headerV.titleLab.text = @"2016-8-27 纽约";
        }
        if (indexPath.section==1) {
            headerV.titleLab.text = @"2016-9-27 巴黎";
        }
        if (indexPath.section==2) {
            headerV.titleLab.text = @"2016-11-27 伦敦";
        }
        reusableView = headerV;
    }
//    if (kind == UICollectionElementKindSectionFooter){
//        MyFootView *footerV = (MyFootView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
//        footerV.titleLab.text = @"尾部视图";
//        reusableView = footerV;
//    }
    return reusableView;
}

#pragma mark - getters

-(UIImageView *)bgimageview
{
    if(!_bgimageview)
    {
        _bgimageview = [[UIImageView alloc] init];
        _bgimageview.image = [UIImage imageNamed:@"bg"];
    }
    return _bgimageview;
}

#pragma mark - 实现方法
-(void)addbtnclick
{
    NSLog(@"新建图标");
    
}


@end
