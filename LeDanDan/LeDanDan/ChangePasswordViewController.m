//
//  ChangePasswordViewController.m
//  LeDanDan
//
//  Created by yzx on 16/1/4.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import "ChangePasswordViewController.h"

@interface ChangePasswordViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    
    
    UITextField *_currentPassword;
    UITextField *_newPassword;
    UITextField *_password;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置密码";
    [self addTextView];
    [self addAllControl];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;

    //[selectedViewController viewWillAppear:animated];
}

-(void)addAllControl
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(10, 320, self.view.frame.size.width- 20, 50);
    sure.backgroundColor =[UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
    [sure setTitle:@"确定" forState: UIControlStateNormal];
    [sure addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sure];
}

-(void)addTextView
{
    _currentPassword = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];
    _newPassword = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];
    _password = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];

    _currentPassword.returnKeyType = UIReturnKeyNext;
    _currentPassword.delegate = self;
    _newPassword.returnKeyType = UIReturnKeyNext;
    _newPassword.delegate = self;
    _password.returnKeyType =UIReturnKeyDone;
    _password.delegate = self;
    
    
}

-(void)sure
{
    [self dismissViewControllerAnimated:YES completion:^
    {
        NSString *curPassword = [[YZXNetworking shared] md5:_currentPassword.text];
        
        NSString *newPassword = [[YZXNetworking shared] md5:_newPassword.text];

        //格式{ userPhone:”123”,type:”1”,value:”123”}
        
        NSString *password = [NSString stringWithFormat:@"%@,%@",_currentPassword.text,_newPassword.text];
        NSLog(@"password :%@",password);
        
        NSDictionary *dic =@{@"userPhone":@"186",@"type":@"7",@"value":password};
        
        NSLog(@"%@",_newPassword.text);
        
        [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kAlter succeed:^(id success){
            
            NSLog(@" success --%@",success);
            
        }failed:^(id error)
         {
             
         }];

    }];
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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 30, 0, [UIImage imageNamed:@"getin@2x"].size.width, [UIImage imageNamed:@"getin@2x"].size.height)];
    imageView.image = [UIImage imageNamed:@"getin@2x"];
    imageView.centerY = 35;
    switch (indexPath.row) {
        case 0:
            
            cell.textLabel.text = @"当前密码";
            [cell.contentView addSubview:_currentPassword];
            
            break;
        case 1:
            
            cell.textLabel.text = @"新密码";
            [cell.contentView addSubview:_newPassword];
            break;
            
        case 2:
            
            cell.textLabel.text = @"确认密码";
            [cell.contentView addSubview:_password];
            break;
            
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
}


#pragma mark ------------uitextField --------
- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _currentPassword) {
        [_newPassword becomeFirstResponder];
    }
    else if (textField == _newPassword)
    {
        [_password becomeFirstResponder];
    }
    else if (textField == _password)
    {
        [textField endEditing:YES];
    }
    return YES;
}


-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
