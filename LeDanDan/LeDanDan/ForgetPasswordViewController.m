//
//  ForgetPasswordViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/7.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "FinishForgetPasswordViewController.h"
@interface ForgetPasswordViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITextField *_phoneTextField;
    UITextField *_passwordTextfield;
    
    UIButton *_verBtn;
    
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    
    //验证码
    NSString *_codeStr;
  
}
@end

@implementation ForgetPasswordViewController

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
    
    
    //下一步
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, tableView.bottom +10, kScreenWidth - 30, 45)];
    [nextBtn setTitle:@"下一步" forState: UIControlStateNormal];
    nextBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    nextBtn.layer.cornerRadius = 5;
    [nextBtn addTarget:self action:@selector(nextStep) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
}

//返回

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//下一步
-(void)nextStep
{
    FinishForgetPasswordViewController *finish = [FinishForgetPasswordViewController new];
    finish.phoneNumber = _phoneTextField.text;
    
    NSLog(@"%@%@",_codeStr,_passwordTextfield.text);
    if ([_codeStr isEqualToString:_passwordTextfield.text]) {
        
         [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[FinishForgetPasswordViewController new]] animated:YES completion:nil];
    }
    else{
        
        [[YZXNetworking shared] showHint:@"验证码不正确"];
        
    }
    
   // [self presentViewController:[[UINavigationController alloc]initWithRootViewController:finish] animated:YES completion:nil];
   
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
        _phoneTextField.placeholder = @"输入手机号";
        _phoneTextField.delegate = self;
        _phoneTextField.returnKeyType =UIReturnKeyDone;
        [cell.contentView addSubview:_phoneTextField];
        
    }
    else
    {
        label.text = @"验证码:";
        _passwordTextfield = [[UITextField alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth-label.right, 50)];
        _passwordTextfield.placeholder = @"请输入验证码";
        _passwordTextfield.delegate =self;
        [cell.contentView addSubview:_passwordTextfield];
        _verBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _verBtn.frame = CGRectMake(kScreenWidth - 100, 10, 85, 30);
        [_verBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_verBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        _verBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _verBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _verBtn.layer.borderWidth = 0.5;
        [_verBtn addTarget:self action:@selector(verPress) forControlEvents:UIControlEventTouchUpInside];

        [cell.contentView addSubview:_verBtn];
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
