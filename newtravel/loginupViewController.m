//
//  loginupViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/28.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "loginupViewController.h"
#import "numberimageView.h"
#import "passwordimageView1.h"
#import "passwordimageView2.h"
#import "verificationimageView.h"
#import <SMS_SDK/SMSSDK.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MBProgressHUD.h"
#import "MBProgressHUD+XMG.h"
@interface loginupViewController ()<UITextFieldDelegate>
@property (nonatomic,strong) UIImageView *bgimageview;
@property (nonatomic,strong) UIButton *backbtn;
@property (nonatomic,strong) UIButton *logupbtn;
@property (nonatomic,strong) UIImageView *logoimageview;
@property (nonatomic,strong) numberimageView *numberView;
@property (nonatomic,strong) passwordimageView1 *passview1;
@property (nonatomic,strong) passwordimageView2 *passview2;
@property (nonatomic,strong) verificationimageView *verficView;
@end

@implementation loginupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *TapGestureTecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide)];
    //    TapGestureTecognizer.cancelsTouchesInView=YES;
    [self.view addGestureRecognizer:TapGestureTecognizer];
    [self.view addSubview:self.bgimageview];
    [self.view addSubview:self.backbtn];
    [self.view addSubview:self.logupbtn];
    [self.view addSubview:self.logoimageview];
    [self.view addSubview:self.numberView];
    [self.view addSubview:self.passview1];
    [self.view addSubview:self.passview2];
    [self.view addSubview:self.verficView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.backbtn.frame = CGRectMake(20, 30, 30, 30);
    self.logoimageview.frame = CGRectMake(UIScreenWidth/2-40, 60, 80, 80);
    self.logupbtn.frame = CGRectMake(80, UIScreenHeight-120, UIScreenWidth-160, 50);
    self.numberView.frame = CGRectMake(0, 180, UIScreenWidth, 50);
    self.passview1.frame = CGRectMake(0, 250, UIScreenWidth, 50);
    self.passview2.frame = CGRectMake(0, 320, UIScreenWidth, 50);
    self.verficView.frame = CGRectMake(0, 390, UIScreenWidth, 50);
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



-(UIImageView *)logoimageview
{
    if(!_logoimageview)
    {
        _logoimageview = [[UIImageView alloc] init];
        _logoimageview.image = [UIImage imageNamed:@"图标"];
    }
    return _logoimageview;
}

-(UIButton *)logupbtn
{
    if(!_logupbtn)
    {
        _logupbtn = [[UIButton alloc] init];
        _logupbtn.layer.masksToBounds = YES;
        _logupbtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"底纹2"]];
        [_logupbtn setTitle:@"注        册" forState:UIControlStateNormal];
        _logupbtn.layer.cornerRadius = 15;
        [_logupbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_logupbtn addTarget:self action:@selector(logupbtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logupbtn;
}

-(UIButton *)backbtn
{
    if(!_backbtn)
    {
        _backbtn = [[UIButton alloc] init];
        [_backbtn addTarget:self action:@selector(backbtnclick) forControlEvents:UIControlEventTouchUpInside];
        [_backbtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    }
    return _backbtn;
}

-(numberimageView *)numberView
{
    if(!_numberView)
    {
        _numberView = [[numberimageView alloc] init];
        _numberView.numbertext.delegate = self;
        _numberView.layer.masksToBounds = YES;
        _numberView.layer.borderWidth = 0.3f;
        _numberView.userInteractionEnabled = YES;
    }
    return _numberView;
}

-(passwordimageView1 *)passview1
{
    if(!_passview1)
    {
        _passview1 = [[passwordimageView1 alloc] init];
        _passview1.passwordtext1.delegate = self;
        _passview1.layer.masksToBounds = YES;
        _passview1.layer.borderWidth = 0.3f;
        _passview1.userInteractionEnabled = YES;
    }
    return _passview1;
}

-(passwordimageView2 *)passview2
{
    if(!_passview2)
    {
        _passview2 = [[passwordimageView2 alloc] init];
        _passview2.passwordtext2.delegate = self;
        _passview2.layer.masksToBounds = YES;
        _passview2.layer.borderWidth = 0.3f;
        _passview2.userInteractionEnabled = YES;
    }
    return _passview2;
}

-(verificationimageView *)verficView
{
    if(!_verficView)
    {
        _verficView = [[verificationimageView alloc] init];
        _verficView.verificationtext.delegate = self;
        _verficView.layer.masksToBounds = YES;
        _verficView.layer.borderWidth = 0.3f;
        _verficView.userInteractionEnabled = YES;
        [_verficView.sendbtn addTarget:self action:@selector(sendbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _verficView;
}


#pragma mark - 实现方法

-(void)backbtnclick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)logupbtnClick
{
    NSLog(@"注册");
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
    [self regis];
}

-(void)sendbtnclick
{
    NSLog(@"发送验证码");
    [self startTime];
}

-(void)getvalid
{
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.numberView.numbertext.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
        if (!error) {
            NSLog(@"获取验证码成功");
            
            [MBProgressHUD showSuccess:@"获取成功"];
        }else{
            NSLog(@"获取验证码失败");
            //手机震动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [MBProgressHUD showError:@"请确认您输入的手机号"];
        }
        
    }];
    
}

-(void)startTime{
    
    [self getvalid];
    __block int timeout=30; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.verficView.sendbtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                self.verficView.sendbtn.userInteractionEnabled = YES;
                
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [ self.verficView.sendbtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                  self.verficView.sendbtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}


-(void)regis
{
    [SMSSDK commitVerificationCode:self.verficView.verificationtext.text phoneNumber:self.numberView.numbertext.text zone:@"86" result:^(NSError *error) {
        
        
        if (!error) {
            
            [MBProgressHUD showSuccess:@"验证成功"];
            
          
            
        }else{
            NSLog(@"验证失败:%@",error);
            //手机震动
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [MBProgressHUD showError:@"注册失败，请检查输入"];
        }

        
    }];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)keyboardHide
{
    [self.numberView.numbertext resignFirstResponder];
    [self.passview1.passwordtext1 resignFirstResponder];
    [self.passview2.passwordtext2 resignFirstResponder];
    [self.verficView.verificationtext resignFirstResponder];
}
@end
