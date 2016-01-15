//
//  ChangePhoneViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/24.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "ChangePhoneViewController.h"

@interface ChangePhoneViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UITextField *_phoneTextField;
    UITextField *_codeTextField;
    UIButton *_verBtn;
    
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    
    NSString *_codeStr;

}
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"修改手机号";
    float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
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
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 120) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_tableView];
    
    //完成
    UIButton *finisdBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, _tableView.bottom +10, kScreenWidth - 30, 45)];
    [finisdBtn setTitle:@"完成" forState: UIControlStateNormal];
    finisdBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    finisdBtn.layer.cornerRadius = 5;
    [finisdBtn addTarget:self action:@selector(finish) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finisdBtn];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)finish
{
    if ([_codeStr isEqualToString:_codeTextField.text]) {
    
        MBProgressHUD *HUD= [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        NSDictionary *dic = @{@"userPhone":_phoneNumber,@"type":@"4",@"value":_phoneTextField.text};
        [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kAlter succeed:^(id success)
         {
             NSLog(@"%@",success);
             NSMutableDictionary *UserDic =(NSMutableDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginUserInfo];
             NSMutableDictionary *newUserInfoDictionary = [NSMutableDictionary dictionaryWithDictionary:UserDic];
             [newUserInfoDictionary setObject:_phoneTextField.text forKey:@"phone"];
             [[NSUserDefaults standardUserDefaults] setObject:newUserInfoDictionary forKey:kLastLoginUserInfo];
             [[NSUserDefaults standardUserDefaults] synchronize];
             [HUD removeFromSuperview];
             [self dismissViewControllerAnimated:YES completion:nil];
             
         }failed:^(id error)
         {
             NSLog(@"%@",error);
         }];
    
    }
    else
    {
        [[YZXNetworking shared] showHint:@"请正确填写验证码"];
    }
    
    
    
   
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
      cell.textLabel.text = @"手机号:";
        _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth - 100, 50)];
        [cell.contentView addSubview:_phoneTextField];
    }
    else
    {
       cell.textLabel.text = @"验证码:";
        _codeTextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth - 100, 50)];
        [cell.contentView addSubview:_codeTextField];
        
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
