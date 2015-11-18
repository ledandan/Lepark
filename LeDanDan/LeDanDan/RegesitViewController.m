//
//  RegesitViewController.m
//  LeDanDan
//
//  Created by yzx on 15/11/10.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "RegesitViewController.h"

@interface RegesitViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *_phoneTextField;
    UITextField *_passwordTextfield;
    UITextField *_verCodeTextfield;
}
@end

@implementation RegesitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(login)];
    
    
    [self addControl];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
    
}

-(void)addControl
{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = self.view.backgroundColor;
    tableView.showsHorizontalScrollIndicator= NO;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.scrollEnabled =NO;
    [self.view addSubview:tableView];
    
    
    //立即注册
    UIButton *regBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, tableView.bottom +10, kScreenWidth - 30, 45)];
    [regBtn setTitle:@"立即注册" forState: UIControlStateNormal];
    regBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    regBtn.layer.cornerRadius = 5;
    [self.view addSubview:regBtn];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//去登录

-(void)login
{
    
}

#pragma mark -----------tableView delegate ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
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
    
    else if (indexPath.row == 1)
    {
        label.text = @"密码:";
        _passwordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _passwordTextfield.placeholder = @"请输入您的密码";
        _passwordTextfield.delegate =self;
        [cell.contentView addSubview:_passwordTextfield];
    }
    else
    {
        label.text =@"验证码:";
        _verCodeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _verCodeTextfield.placeholder = @"请输入您的验证码";
        _verCodeTextfield.delegate =self;
        [cell.contentView addSubview:_verCodeTextfield];
    
        UIButton *verBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        verBtn.frame = CGRectMake(kScreenWidth - 100, 10, 85, 30);
        [verBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [verBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        verBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        verBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        verBtn.layer.borderWidth = 0.5;
        [cell.contentView addSubview:verBtn];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
    
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
