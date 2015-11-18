//
//  LoginViewController.m
//  LeDanDan
//
//  Created by yzx on 15/11/10.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "LoginViewController.h"
#import "RegesitViewController.h"
@interface LoginViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *_phoneTextField;
    UITextField *_passwordTextfield;
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
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
    
    

}

-(void)addcontrol
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 200) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.showsHorizontalScrollIndicator= NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.scrollEnabled =NO;
    
    [self.view addSubview:tableView];
    
    //忘记密码
    UIButton *forgetPassword = [UIButton buttonWithType:UIButtonTypeCustom];
    [forgetPassword setTitle:@"忘记密码" forState: UIControlStateNormal];
    forgetPassword.frame = CGRectMake(kScreenWidth - 100, tableView.bottom - 20, 100, 30);
    forgetPassword.font = [UIFont boldSystemFontOfSize:15];
    [forgetPassword setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [forgetPassword addTarget:self action:@selector(forgetPassword) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetPassword];
    
    //登录
    UIButton *loginBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, tableView.bottom +10, kScreenWidth - 30, 45)];
    [loginBtn setTitle:@"登录" forState: UIControlStateNormal];
    loginBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    loginBtn.layer.cornerRadius = 5;
    [self.view addSubview:loginBtn];
    
    //第三方登录
    UIImageView *thirdImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, kScreenHeight - 130, kScreenWidth - 50, 15)];
    thirdImageView.image = [UIImage imageNamed:@"thirdLoginTitle@2x"];
    [self.view addSubview:thirdImageView];
    
    
    //QQ,微信登录
    NSArray *imageArr = [NSArray arrayWithObjects:@"qq@2x",@"wechat@2x", nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"QQ" ,@"微信",nil];
    for (int i =0 ;i <2 ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake((kScreenWidth - 200)/2 + 150*i +10, 0, 50, 70);
        //btn.backgroundColor =[UIColor redColor];
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

//忘记密码
-(void)forgetPassword
{
    
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
