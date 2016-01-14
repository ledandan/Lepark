//
//  FinishForgetPasswordViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/7.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "FinishForgetPasswordViewController.h"
#import "LoginViewController.h"


@interface FinishForgetPasswordViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UITextField *_newPasswordTextField;
    UITextField *_verPasswordTextfield;
}
@end

@implementation FinishForgetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"忘记密码";

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
    
    
    //完成
    UIButton *finisdBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, tableView.bottom +10, kScreenWidth - 30, 45)];
    [finisdBtn setTitle:@"完成" forState: UIControlStateNormal];
    finisdBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    finisdBtn.layer.cornerRadius = 5;
    [finisdBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finisdBtn];
}


//返回

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//完成
-(void)finish
{
   NSDictionary *userDic =(NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginUserInfo];
    
    NSDictionary *dic = @{@"userId":@"",@"newPassWord":@""};
   // [[YZXNetworking shared] requesUpdateInfoRequestdict:<#(NSDictionary *)#> withurl:<#(NSString *)#> succeed:<#^(id response)succeedBlock#> failed:<#^(id error)failedBlock#>]
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[LoginViewController new]] animated:YES completion:^{
       
        
    }];
    
    
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
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 50)];
    label.centerY = cell.centerY;
    
    [cell.contentView addSubview:label];
    if (indexPath.row == 0) {
        label.text = @"新密码:";
        _newPasswordTextField = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _newPasswordTextField.placeholder = @"输入新密码";
        _newPasswordTextField.delegate = self;
        _newPasswordTextField.returnKeyType =UIReturnKeyDone;
        [cell.contentView addSubview:_newPasswordTextField];
        
    }
    else
    {
        label.text = @"确认密码:";
        _verPasswordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _verPasswordTextfield.placeholder = @"请确认您的密码";
        _verPasswordTextfield.delegate =self;
        [cell.contentView addSubview:_verPasswordTextfield];
        
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
