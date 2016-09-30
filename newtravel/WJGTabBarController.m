//
//  WJGTabBarController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/13.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "WJGTabBarController.h"

@interface WJGTabBarController ()<UIScrollViewDelegate,UIScrollViewAccessibilityDelegate>
@property (nonatomic,strong) UIImageView *backImageView;

@end

@implementation WJGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![@"YES" isEqualToString:[userDefaults objectForKey:@"isScrollViewAppear"]]) {
        
        [self showScrollView];
    }
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"标签栏"]];
    
}

#pragma mark - 滑动图

-(void) showScrollView{
    
    UIScrollView *_scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    
    _scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * 4, [UIScreen mainScreen].bounds.size.height);
    
    _scrollView.tag = 101;
    
    
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.delegate = self;
    
    
    for (int i = 0 ; i < 3; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width * i , 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
        imageView.image = image;
        
        [_scrollView addSubview:imageView];
    }
    
    
    UIPageControl *pageConteol = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-40, self.view.frame.size.height - 60, 50, 40)];
    pageConteol.numberOfPages = 4;
    pageConteol.tag = 201;
    
    [self.view addSubview:_scrollView];
   // [self.view addSubview: pageConteol];
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    int current = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
    
    
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    page.currentPage = current;
    
    
    if (page.currentPage == 3) {
        
        
        [self scrollViewDisappear];
    }
}

-(void)scrollViewDisappear{
    
    
    UIScrollView *scrollView = (UIScrollView *)[self.view viewWithTag:101];
    UIPageControl *page = (UIPageControl *)[self.view viewWithTag:201];
    
    
    [UIView animateWithDuration:3.0f animations:^{
        
        scrollView.center = CGPointMake(self.view.frame.size.width/2, 1.5 * self.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        [scrollView removeFromSuperview];
        [page removeFromSuperview];
    }];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:@"YES" forKey:@"isScrollViewAppear"];
}

#pragma mark - getters

-(UIImageView *)backImageView
{
    if(!_backImageView)
    {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = [UIColor whiteColor];
    }
    return _backImageView;
}

- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                Title:(NSString *)title
        withTitleSize:(CGFloat)size
          andFoneName:(NSString *)foneName
        selectedImage:(NSString *)selectedImage
       withTitleColor:(UIColor *)selectColor
      unselectedImage:(NSString *)unselectedImage
       withTitleColor:(UIColor *)unselectColor{
    
    //设置图片
    tabbarItem = [tabbarItem initWithTitle:title image:[[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    
    //未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateNormal];
    
    //选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:foneName size:size]} forState:UIControlStateSelected];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
}




@end
