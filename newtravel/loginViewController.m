//
//  loginViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/28.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "loginViewController.h"
#import "loginupViewController.h"
@interface loginViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *bgimageview;
@property (nonatomic,strong) UIButton *loginbtn;
@property (nonatomic,strong) UIImageView *logoimageview;
@property (nonatomic,strong) UITextField *nicknametext;
@property (nonatomic,strong) UITextField *passwordtext;
@property (nonatomic,strong) UIImageView *nicknameleftimageview;
@property (nonatomic,strong) UIImageView *passwordleftimageview;
@property (nonatomic,strong) UIButton *logupbtn;
@property (nonatomic,strong) UIButton *forgetbtn;
@property (nonatomic,strong) UIButton *weibologinbtn;
@property (nonatomic,strong) UIButton *weixinloginbtn;
@property (nonatomic,strong) UIButton *qqloginbtn;
@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
//    TapGestureTecognizer.cancelsTouchesInView=YES;
    [self.view addGestureRecognizer:TapGestureTecognizer];

    [self.view addSubview:self.bgimageview];
    [self.view addSubview:self.loginbtn];
    [self.view addSubview:self.logoimageview];
    [self.view addSubview:self.nicknametext];
    [self.view addSubview:self.passwordtext];
    [self.view addSubview:self.forgetbtn];
    [self.view addSubview:self.logupbtn];
    [self.view addSubview:self.weibologinbtn];
    [self.view addSubview:self.weixinloginbtn];
    [self.view addSubview:self.qqloginbtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.loginbtn.frame = CGRectMake(80, UIScreenHeight/2+50, UIScreenWidth-160, 50);
    self.logoimageview.frame = CGRectMake(UIScreenWidth/2-40, 60, 80, 80);
    self.nicknametext.frame = CGRectMake(80, 200, UIScreenWidth-160, 50);
    self.passwordtext.frame = CGRectMake(80, 280, UIScreenWidth-160, 50);
    self.logupbtn.frame = CGRectMake(80, UIScreenHeight/2+110, 80, 40);
    self.forgetbtn.frame = CGRectMake(80+UIScreenWidth-160-80, UIScreenHeight/2+110, 80, 40);
    self.weibologinbtn.frame = CGRectMake(80, UIScreenHeight/2+180, 40, 40);
    self.weixinloginbtn.frame = CGRectMake(UIScreenWidth/2-20, UIScreenHeight/2+180, 40, 40);
    self.qqloginbtn.frame = CGRectMake(UIScreenWidth-120,  UIScreenHeight/2+180, 40, 40);
}

#pragma mark - getters

-(UIImageView *)bgimageview
{
    if(!_bgimageview)
    {
        _bgimageview = [[UIImageView alloc] init];
        _bgimageview.frame = [UIScreen mainScreen].bounds;
        _bgimageview.image = [UIImage imageNamed:@"背景w"];
    }
    return _bgimageview;
}

-(UIButton *)loginbtn
{
    if(!_loginbtn)
    {
        _loginbtn = [[UIButton alloc] init];
        [_loginbtn addTarget:self action:@selector(loginbtnClick) forControlEvents:UIControlEventTouchUpInside];
        _loginbtn.layer.masksToBounds = YES;
        _loginbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"底纹2"]];
        [_loginbtn setTitle:@"登       陆" forState:UIControlStateNormal];
        _loginbtn.layer.cornerRadius = 15;
        [_loginbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
    }
    return _loginbtn;
}

-(UIImageView *)logoimageview
{
    if(!_logoimageview)
    {
        _logoimageview = [[UIImageView alloc] init];
        _logoimageview.image = [UIImage imageNamed:@"图标"];
    }
    return _logoimageview;
}

-(UITextField *)nicknametext
{
    if(!_nicknametext)
    {
        _nicknametext = [[UITextField alloc] init];
        _nicknametext.delegate = self;
        _nicknametext.placeholder = @"请输入手机号";
        _nicknametext.layer.masksToBounds = YES;
        _nicknametext.layer.borderWidth = 1.0f;
        _nicknametext.layer.cornerRadius = 8;
        _nicknametext.leftView = self.nicknameleftimageview;
        _nicknametext.leftViewMode = UITextFieldViewModeAlways;
        _nicknametext.clearButtonMode = UITextFieldViewModeWhileEditing;
        _nicknametext.returnKeyType =UIReturnKeyGo;
        _nicknametext.borderStyle = UITextBorderStyleBezel;
    }
    return _nicknametext;
}

-(UITextField *)passwordtext
{
    if(!_passwordtext)
    {
        _passwordtext = [[UITextField alloc] init];
        _passwordtext.delegate = self;
        _passwordtext.placeholder = @"请输入密码";
        _passwordtext.layer.masksToBounds = YES;
        _passwordtext.layer.borderWidth = 1.0f;
        _passwordtext.layer.cornerRadius = 8;
        _passwordtext.leftView = self.passwordleftimageview;
        _passwordtext.leftViewMode = UITextFieldViewModeAlways;
        _passwordtext.clearButtonMode = UITextFieldViewModeWhileEditing;
        _passwordtext.returnKeyType =UIReturnKeyGo;
        _passwordtext.borderStyle = UITextBorderStyleBezel;
        _passwordtext.secureTextEntry = YES;
    }
    return _passwordtext;
}

-(UIImageView *)nicknameleftimageview
{
    if(!_nicknameleftimageview)
    {
        _nicknameleftimageview = [[UIImageView alloc] init];
        _nicknameleftimageview.image = [UIImage imageNamed:@"我"];
        _nicknameleftimageview.frame = CGRectMake(24, 10, 26, 30);
    }
    return _nicknameleftimageview;
}

-(UIImageView *)passwordleftimageview
{
    if(!_passwordleftimageview)
    {
        _passwordleftimageview = [[UIImageView alloc] init];
        _passwordleftimageview.image = [UIImage imageNamed:@"密码"];
        _passwordleftimageview.frame = CGRectMake(24, 10, 26, 30);
    }
    return _passwordleftimageview;
}

-(UIButton *)logupbtn
{
    if(!_logupbtn)
    {
        _logupbtn = [[UIButton alloc] init];
        [_logupbtn setTitle:@"注册账号" forState:UIControlStateNormal];
        [_logupbtn addTarget:self action:@selector(logupbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logupbtn;
}

-(UIButton *)forgetbtn
{
    if(!_forgetbtn)
    {
        _forgetbtn = [[UIButton alloc] init];
        [_forgetbtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetbtn addTarget:self action:@selector(forgetbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetbtn;
}

-(UIButton *)weixinloginbtn
{
    if(!_weixinloginbtn)
    {
        _weixinloginbtn = [[UIButton alloc] init];
        [_weixinloginbtn setImage:[UIImage imageNamed:@"微信"] forState:UIControlStateNormal];
        [_weixinloginbtn addTarget:self action:@selector(weixinloginbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinloginbtn;
}

-(UIButton *)weibologinbtn
{
    if(!_weibologinbtn)
    {
        _weibologinbtn = [[UIButton alloc] init];
        [_weibologinbtn setImage:[UIImage imageNamed:@"微博"] forState:UIControlStateNormal];
        [_weibologinbtn addTarget:self action:@selector(weibologinbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weibologinbtn;
}

-(UIButton *)qqloginbtn
{
    if(!_qqloginbtn)
    {
        _qqloginbtn = [[UIButton alloc] init];
        [_qqloginbtn setImage:[UIImage imageNamed:@"QQ"] forState:UIControlStateNormal];
        [_qqloginbtn addTarget:self action:@selector(qqloginbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _qqloginbtn;
}

#pragma mark - 实现方法

-(void)loginbtnClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)logupbtnclick
{
    loginupViewController *loginupVC = [[loginupViewController alloc] init];
    [self presentViewController:loginupVC animated:YES completion:^{
        
    }];
}

-(void)forgetbtnclick
{
    NSLog(@"忘记密码");
}

-(void)weibologinbtnclick
{
    NSLog(@"微博登录");
}

-(void)weixinloginbtnclick
{
    NSLog(@"微信登录");
}

-(void)qqloginbtnclick
{
    NSLog(@"qq登录");
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide
{
    [self.nicknametext resignFirstResponder];
    [self.passwordtext resignFirstResponder];
}

@end
