//
//  RegesitViewController.m
//  LeDanDan
//
//  Created by yzx on 15/11/10.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "RegesitViewController.h"
//#import "AFHTTPRequestOperationManager.h"
@interface RegesitViewController () <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITextField *_phoneTextField;
    UITextField *_passwordTextfield;
    UITextField *_verCodeTextfield;
    UITextField *_inviteTextfield;
    
    UIButton *_verBtn;
    
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    UITableView *_tableView;
    
    //验证码
    NSString *_codeStr;
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 330) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
    _tableView.showsHorizontalScrollIndicator= NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled =NO;
    [self.view addSubview:_tableView];
    
    
    //立即注册
    UIButton *regBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, _tableView.bottom +10, kScreenWidth - 30, 45)];
    [regBtn setTitle:@"立即注册" forState: UIControlStateNormal];
    regBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    regBtn.layer.cornerRadius = 5;
    [regBtn addTarget:self action:@selector(reg) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:regBtn];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
//去登录

-(void)login
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)reg
{
    //{“userPhone”:”123”,” passWord”:”123”，“code”:”123” ，“type”：1，“openId”：“”}

    if ([self valiMobile:_phoneTextField.text] == nil) {

        if (_passwordTextfield.text.length < 6) {
            
            [[YZXNetworking shared] showHint:@"密码至少6位"];
            
        }
        else
        {
            if (_codeStr == nil) {
                [[YZXNetworking shared] showHint:@"请获取验证码"];
            }
            else
            {
                if (![_codeStr isEqualToString:_verCodeTextfield.text]) {
                    NSLog(@"_codeStr :%@ _verCodeTextfield %@",_codeStr,_verCodeTextfield.text);
                    [[YZXNetworking shared] showHint:@"请填写正确的验证码"];
                }
                else
                {
                    //加密
                    NSString *md5Password = [[YZXNetworking shared]md5:_passwordTextfield.text];
                    
                    NSDictionary *dic = @{@"userPhone":_phoneTextField.text,@"passWord":md5Password,@"code":_inviteTextfield.text,@"type":@"1",@"openId":@"1"};
                    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kRegesit succeed:^(id success){
                        
                        NSLog(@"%@",success);
                        int status = (int)[success objectForKey:@"status"];
                        if (status == 200) {
                            [[YZXNetworking shared] showHint:[success objectForKey:@"message"]];
                        }
                        else
                        {
                            [[YZXNetworking shared] showHint:[success objectForKey:@"message"]];
                            
                        }
                        
                    }failed:^(id error)
                     {
                         
                     }];
                }
            }

        }
        
    }
   
    
    
    
}



//点击获取验证码
-(void)verPress
{
    NSDictionary *dic = @{@"userPhone":_phoneTextField.text};
    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kSendMSN succeed:^(id success){
        
        NSLog(@"%@",success);
        _codeStr = [success objectForKey:@"result"];
        
    }failed:^(id error)
     {
         
         NSLog(@"%@",error);
     }];
    //设置倒计时总时长
    secondsCountDown = 60;//60秒倒计时
    //开始倒计时
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    
    //设置倒计时显示的时间
    [_verBtn setTitle:[NSString stringWithFormat:@"%d",secondsCountDown] forState:UIControlStateNormal];
    //labelText.text=[NSString stringWithFormat:@"%d",secondsCountDown];
    
}

-(void)timeFireMethod{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    [_verBtn setTitle:[NSString stringWithFormat:@"%d",secondsCountDown] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        [_verBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        _verBtn.userInteractionEnabled = YES;
    }
    else
    {
        _verBtn.userInteractionEnabled = NO;
    }
}


- (NSString *)valiMobile:(NSString *)mobile{
    if (mobile.length < 11)
    {
        [[YZXNetworking shared] showHint:@"手机号长度只能是11位"];
        return @"手机号长度只能是11位";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
            return nil;
        }else{
            
            [[YZXNetworking shared] showHint:@"请输入正确的电话号码"];
            return @"请输入正确的电话号码";
        }
    }
    return nil;
}

#pragma mark -----------tableView delegate ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
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
    else if(indexPath.row == 2)
    {
        cell.backgroundColor = self.view.backgroundColor;
    }
    else if(indexPath.row ==3)
    {
        label.text =@"验证码:";
        _verCodeTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _verCodeTextfield.placeholder = @"请输入验证码";
        _verCodeTextfield.delegate =self;
        [cell.contentView addSubview:_verCodeTextfield];
    
        _verBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _verBtn.frame = CGRectMake(kScreenWidth - 100, 10, 85, 30);
        [_verBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _verBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _verBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
        [_verBtn addTarget:self action:@selector(verPress) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:_verBtn];
    }
    else if (indexPath.row == 4)
    {
        
        label.text =@"邀请码:";
        _inviteTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _inviteTextfield.placeholder = @"如果您有邀请码,请输入";
        _inviteTextfield.delegate =self;
        [cell.contentView addSubview:_inviteTextfield];

    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return 15;
    }
    else
    {
    return 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 20;
    
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
