//
//  moretripViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/20.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "moretripViewController.h"
#import "Masonry.h"
#import "addtripimageView.h"
#import "writetripimageView.h"
@interface moretripViewController ()
@property (nonatomic,strong) UIButton *delbtn;
@property (nonatomic,strong) addtripimageView *addview;
@property (nonatomic,strong) UILabel *addlabel;
@property (nonatomic,strong) writetripimageView *writeview;
@property (nonatomic,strong) UILabel *writelabel;
@end

@implementation moretripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"背景"]];
    [self.view addSubview:self.delbtn];
    [self.view addSubview:self.addview];
    [self.view addSubview:self.addlabel];
    [self.view addSubview:self.writeview];
    [self.view addSubview:self.writelabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.delbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(45);
        make.bottom.equalTo(self.view).with.offset(-94);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    self.addview.frame = CGRectMake(UIScreenWidth/4-25, UIScreenHeight/2-60, 100, 100);
    self.addlabel.frame = CGRectMake(UIScreenWidth/4-20, UIScreenHeight/2-60+110, 80, 30);
    self.writeview.frame = CGRectMake(UIScreenWidth/2+25, UIScreenHeight/2-60, 100, 100);
    self.writelabel.frame = CGRectMake(UIScreenWidth/2+30, UIScreenHeight/2-60+110, 80, 30);
}

#pragma mark - getters

-(UIButton *)delbtn
{
    if(!_delbtn)
    {
        _delbtn = [[UIButton alloc] init];
        [_delbtn setImage:[UIImage imageNamed:@"关闭图标"] forState:UIControlStateNormal];
        [_delbtn addTarget:self action:@selector(delbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _delbtn;
}

-(addtripimageView *)addview
{
    if(!_addview)
    {
        _addview = [[addtripimageView alloc] init];
        _addview.image = [UIImage imageNamed:@"添加行程底纹"];
        _addview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress1)];
        [_addview addGestureRecognizer:singleTap1];
    }
    return _addview;
}

-(UILabel *)addlabel
{
    if(!_addlabel)
    {
        _addlabel = [[UILabel alloc] init];
        _addlabel.adjustsFontSizeToFitWidth = YES;
        _addlabel.text = @"行程管理";
        _addlabel.textAlignment = NSTextAlignmentCenter;
        _addlabel.textColor = [UIColor whiteColor];
    }
    return _addlabel;
}

-(writetripimageView *)writeview
{
    if(!_writeview)
    {
        _writeview = [[writetripimageView alloc] init];
        _writeview.image = [UIImage imageNamed:@"写印象底纹"];
        _writeview.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(buttonpress2)];
        [_writeview addGestureRecognizer:singleTap1];
    }
    return _writeview;
}

-(UILabel *)writelabel
{
    if(!_writelabel)
    {
        _writelabel = [[UILabel alloc] init];
        _writelabel.adjustsFontSizeToFitWidth = YES;
        _writelabel.textColor = [UIColor whiteColor];
        _writelabel.textAlignment = NSTextAlignmentCenter;
        _writelabel.text = @"写印象";
    }
    return _writelabel;
}


#pragma mark - 点击事件

-(void)delbtnclick
{
    NSLog(@"点击关闭图标");
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)buttonpress1
{
    NSLog(@"添加行程");
}

-(void)buttonpress2
{
    NSLog(@"写印象");
}
@end
