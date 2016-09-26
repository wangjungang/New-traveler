//
//  writeimpressViewController.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/24.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "writeimpressViewController.h"
#import "MBProgressHUD+XMG.h"
@interface writeimpressViewController ()<UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImageView *bgimageview;
@property (nonatomic,strong) UIButton *savebtn;
@property (nonatomic,strong) UIButton *backbtn;
@property (nonatomic,strong) UITextView *writetextview;
@property (nonatomic,strong) UIButton *addbtn;
@property (nonatomic,strong) UIImageView *picimageview;
@end

@implementation writeimpressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(writeviewpop)];
    [self.view addGestureRecognizer:singleTap1];
    
    [self.view addSubview:self.bgimageview];
    [self.view addSubview:self.backbtn];
    [self.view addSubview:self.savebtn];
    [self.view addSubview:self.writetextview];
    [self.view addSubview:self.addbtn];
    [self.view addSubview:self.picimageview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.backbtn.frame = CGRectMake(20, 30, 80, 50);
    self.savebtn.frame = CGRectMake(UIScreenWidth-20-80, 30, 80, 50);
    self.writetextview.frame = CGRectMake(10, 100, UIScreenWidth-20, UIScreenHeight/3);
    self.picimageview.frame = CGRectMake(20, 100+UIScreenHeight/3-50, 50, 50);
    self.addbtn.frame = CGRectMake(UIScreenWidth-20-50, 50+UIScreenHeight/3, 50, 50);
}

#pragma makr - getters

-(UIImageView *)bgimageview
{
    if(!_bgimageview)
    {
        _bgimageview = [[UIImageView alloc] init];
        _bgimageview.frame = [UIScreen mainScreen].bounds;
        _bgimageview.image = [UIImage imageNamed:@"BG"];
    }
    return _bgimageview;
}

-(UIButton *)backbtn
{
    if(!_backbtn)
    {
        _backbtn = [[UIButton alloc] init];
        [_backbtn setTitle:@"返回" forState:UIControlStateNormal];
        [_backbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_backbtn addTarget:self action:@selector(backbtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backbtn;
}

-(UIButton *)savebtn
{
    if(!_savebtn)
    {
        _savebtn = [[UIButton alloc] init];
        [_savebtn setTitle:@"保存" forState:UIControlStateNormal];
        [_savebtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_savebtn addTarget:self action:@selector(savebtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _savebtn;
}

-(UITextView *)writetextview
{
    if(!_writetextview)
    {
        _writetextview = [[UITextView alloc] init];
        _writetextview.delegate = self;
        _writetextview.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"底纹"]];
        _writetextview.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
        _writetextview.textColor = [UIColor blackColor];
    }
    return _writetextview;
}

-(UIButton *)addbtn
{
    if(!_addbtn)
    {
        _addbtn = [[UIButton alloc] init];
        [_addbtn setImage:[UIImage imageNamed:@"添加"] forState:UIControlStateNormal];
        [_addbtn addTarget:self action:@selector(addimagebtnclick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addbtn;
}

-(UIImageView *)picimageview
{
    if(!_picimageview)
    {
        _picimageview = [[UIImageView alloc] init];
        _picimageview.backgroundColor = [UIColor whiteColor];
    }
    return _picimageview;
}

#pragma mark - 实现方法

-(void)backbtnclick
{
    UIAlertController *control = [UIAlertController alertControllerWithTitle:@"是否保存" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [MBProgressHUD showSuccess:@"保存成功"];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }];
    
    [control addAction:action1];
    [control addAction:action2];
    
    [self presentViewController:control animated:YES completion:^{
        
    }];
    
  
}

-(void)savebtnclick
{
    [MBProgressHUD showSuccess:@"保存成功"];
}

-(void)addimagebtnclick
{
    [self addimage];
}

-(void)writeviewpop
{
    [self.writetextview resignFirstResponder];
}

-(void)addimage
{
    UIAlertController *alertController;
    
    __block NSUInteger blockSourceType = 0;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        //支持访问相机与相册情况
        alertController = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:    UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击从相册中选取");
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击拍照");
            //相机
            blockSourceType = UIImagePickerControllerSourceTypeCamera;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:nil];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        //只支持访问相册情况
        alertController = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击从相册中选取");
            //相册
            blockSourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            
            imagePickerController.allowsEditing = YES;
            
            imagePickerController.sourceType = blockSourceType;
            
            [self presentViewController:imagePickerController animated:YES completion:^{
                
            }];
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            NSLog(@"点击取消");
            // 取消
            return;
        }]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }

}

#pragma mark - 选择图片后,回调选择

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    self.picimageview.image = image;
    
  
    
}


@end
