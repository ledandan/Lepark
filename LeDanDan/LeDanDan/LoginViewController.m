//
//  LoginViewController.m
//  LeDanDan
//
//  Created by yzx on 15/11/10.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegesitViewController.h"
#import "ForgetPasswordViewController.h"
#import "MBProgressHUD.h"
#import "MineVC.h"

#import <ShareSDK/ShareSDK.h>
@interface LoginViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *_phoneTextField;
    UITextField *_passwordTextfield;
    UITableView *_tableView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    
    
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regesit)];
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Helvetica-Bold"size:17.0], nil] forState:UIControlStateNormal];
    
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(regesit)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:@"Helvetica"size:18],NSFontAttributeName,
                                       [UIColor whiteColor],NSForegroundColorAttributeName,
                                        nil]
                             forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    [self addcontrol];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self dismissModalViewControllerAnimated:YES];
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
}

-(void)addcontrol
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.showsHorizontalScrollIndicator= NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled =NO;
    
    [self.view addSubview:_tableView];
    
    //忘记密码
    UIButton *forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPassword setTitle:@"忘记密码" forState: UIControlStateNormal];
    forgetPassword.frame = CGRectMake(kScreenWidth - 100, _tableView.bottom - 20, 100, 30);
    forgetPassword.font = [UIFont boldSystemFontOfSize:15];
    [forgetPassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [forgetPassword addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassword];
    
    //登录
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, _tableView.bottom +10, kScreenWidth - 30, 45)];
    [loginBtn setTitle:@"登录" forState: UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    loginBtn.layer.cornerRadius = 5;
    [loginBtn addTarget:self action:@selector(loginlogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    //第三方登录
    UIImageView *thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, kScreenHeight - 130, kScreenWidth - 50, 15)];
    thirdImageView.image = [UIImage imageNamed:@"thirdLogin@2x"];
    [self.view addSubview:thirdImageView];
    
    
    //QQ,微信登录
    NSArray *imageArr = [NSArray arrayWithObjects:@"qq@2x",@"wechat@2x", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"QQ" ,@"微信",nil];
    for (int i =0 ;i <2 ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth - 200)/2 + 150*i +10, 0, 50, 70);
        //btn.backgroundColor =[UIColor redColor];
        btn.tag = 108+i;
        [btn addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
        btn.y = kScreenHeight - 100;
        [self.view addSubview:btn];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, 50, 20)];
        label.text = titleArr[i];
        label.textAlignment = 1;
        [btn addSubview:label];
    }
}


//back
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//注册
-(void)regesit
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[RegesitViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

//登录
-(void)loginlogin
{
   // { userPhone:”123”, passWord:”132”}
    NSString *MD5Password = [[YZXNetworking shared]md5:_passwordTextfield.text];
    NSDictionary *dic = @{@"userPhone":_phoneTextField.text,@"passWord":MD5Password,@"type":@"1",@"opened":@""};
    NSLog(@"%@",MD5Password);
    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kLogin succeed:^(id success){

        NSString *status = [NSString stringWithFormat:@"%@",[success objectForKey:@"status"]];
        if ([status isEqualToString:@"200"]) {
            
            [[YZXNetworking shared] saveLoginSuccessUserInfo:success];
            [[NSUserDefaults standardUserDefaults] setObject:_passwordTextfield.text forKey:@"password"];
            [[YZXNetworking shared] showHint:[success objectForKey:@"message"]];
            [self dismissViewControllerAnimated:YES completion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"islogin" object:nil];
            }];
        }
        else
        {
            
            [[YZXNetworking shared] showHint:[success objectForKey:@"message"]];
            
        }

    }failed:^(id error)
     {
         
         NSLog(@"%@",error);
         
     }];
    
    
}


//第三方登录
-(void)thirdLogin:(UIButton *)btn
{
    if (btn.tag - 108 ==0) {
        
        [ShareSDK getUserInfoWithType:ShareTypeQQSpace authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
            NSLog(@"%d",result);
            if (result) {
                //成功登录后，判断该用户的ID是否在自己的数据库中。
                //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
                [self reloadStateWithType:ShareTypeQQSpace];
            }
            else{
                NSLog(@"%@",error);
            }
        }];

        
    }
    else{
        [ShareSDK getUserInfoWithType:ShareTypeWeixiSession authOptions:nil result:^(BOOL result, id<ISSPlatformUser> userInfo, id<ICMErrorInfo> error) {
            NSLog(@"%d",result);
            if (result) {
                //成功登录后，判断该用户的ID是否在自己的数据库中。
                //如果有直接登录，没有就将该用户的ID和相关资料在数据库中创建新用户。
                [self reloadStateWithType:ShareTypeWeixiSession];
            }
        }];
    }
}


-(void)reloadStateWithType:(ShareType)type{
    //现实授权信息，包括授权ID、授权有效期等。
    //此处可以在用户进入应用的时候直接调用，如授权信息不为空且不过期可帮用户自动实现登录。
    id<ISSPlatformCredential> credential = [ShareSDK getCredentialWithType:type];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"TEXT_TIPS", @"提示")
                                                        message:[NSString stringWithFormat:
                                                                 @"uid = %@\ntoken = %@\nsecret = %@\n expired = %@\nextInfo = %@",
                                                                 [credential uid],
                                                                 [credential token],
                                                                 [credential secret],
                                                                 [credential expired],
                                                                 [credential extInfo]]
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"TEXT_KNOW", @"知道了")
                                              otherButtonTitles:nil];
    [alertView show];
}
//忘记密码
-(void)forgetPassword
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[ForgetPasswordViewController new]] animated:YES completion:nil];
}

#pragma mark -----------tableView delegate ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.layer.borderWidth = 0.1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 50)];
    label.centerY = cell.centerY;
   
    [cell.contentView addSubview:label];
    if (indexPath.row == 0) {
        label.text = @"手机号:";
        _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _phoneTextField.placeholder = @"请输入您的手机号";
        _phoneTextField.delegate = self;
        _phoneTextField.returnKeyType =UIReturnKeyDone;
        [cell.contentView addSubview:_phoneTextField];
      
    }
    else
    {
        label.text = @"密码:";
        _passwordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _passwordTextfield.placeholder = @"请输入您的密码";
        _passwordTextfield.delegate =self;
        [cell.contentView addSubview:_passwordTextfield];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
}

-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
