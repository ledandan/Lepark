//
//  TravleVC.m
//  LeDanDan
//
//  Created by yzx on 15/11/4.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "TravleVC.h"
#import "TravleTableViewCell.h"
#import "TravleEditAddVC.h"
#import "TravelEditViewController.h"
#import "MJRefresh.h"
#import "MSDatePicker.h"

// 屏幕尺寸 ScreenRect
#define ScreenRect [UIScreen mainScreen].applicationFrame
#define ScreenRectHeight [UIScreen mainScreen].applicationFrame.size.height
#define ScreenRectWidth [UIScreen mainScreen].applicationFrame.size.width


@interface TravleVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MSDatePickerDelegate>
{
    NSMutableArray *_dataArr;
    
    UITableView *_tableView;
    
    UITextField *_nameTextField;
    UITextField *_sexTextField;
    UITextField *_birthTextField;
    UITextField *_phoneTextField;
    UITextField *_identityTextField;
    
    UIButton *_chooseMale;
    UIButton *_chooseFeMale;
    
    UILabel *_maleLabel;
    UILabel *_femaleLabel;

     NSString *_getDateString;
}

@end

@implementation TravleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    
    self.navigationController.navigationBar.translucent=NO;
 
    self.title=@"身份验证";
    
    [self addTextView];
    [self addAllControl];
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

-(void)addTextView
{
    _nameTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];
    _phoneTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];
    _sexTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];
    _birthTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];
    _identityTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 0, kScreenWidth - 120, 70)];
    _nameTextField.returnKeyType = UIReturnKeyDone;
    _nameTextField.delegate = self;
    _phoneTextField.returnKeyType = UIReturnKeyNext;
    _phoneTextField.delegate = self;
    _identityTextField.returnKeyType =UIReturnKeyDone;
    _identityTextField.delegate = self;
    
    _chooseMale = [UIButton buttonWithType:UIButtonTypeCustom];
    _chooseMale.frame = CGRectMake(120, 30, 15, 15);
    _chooseMale.tag = 121;
    [_chooseMale addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
    //默认男
    [_chooseMale setImage:[UIImage imageNamed:@"choice@2x"] forState:UIControlStateNormal];
    
    _maleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_chooseMale.right +10, 0, 20, 15)];
    _maleLabel.text = @"男";
    
    _chooseFeMale =[UIButton buttonWithType:UIButtonTypeCustom];
    _chooseFeMale.frame = CGRectMake(_maleLabel.right + 30, 30, 15, 15);
    _chooseFeMale.tag = 122;
    [_chooseFeMale addTarget:self action:@selector(chooseSex:) forControlEvents:UIControlEventTouchUpInside];
    [_chooseFeMale setImage:[UIImage imageNamed:@"nochoice@2x"] forState:UIControlStateNormal];
    
    _femaleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_chooseFeMale.right +10, 0, 20, 15)];
    _femaleLabel.text = @"女";
}

-(void)addAllControl
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(10, 380, self.view.frame.size.width- 20, 50);
    sure.backgroundColor =[UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
    [sure setTitle:@"确定" forState: UIControlStateNormal];
    [self.view addSubview:sure];
}

-(void)chooseSex: (UIButton *)btn
{
    if (btn.tag == 121) {
        NSLog(@"121");
        [_chooseMale setImage:[UIImage imageNamed:@"choice@2x"] forState:UIControlStateNormal];
        [_chooseFeMale setImage:[UIImage imageNamed:@"nochoice@2x"] forState:UIControlStateNormal];
    }
    else
    {
        [_chooseMale setImage:[UIImage imageNamed:@"nochoice@2x"] forState:UIControlStateNormal];
        [_chooseFeMale setImage:[UIImage imageNamed:@"choice@2x"] forState:UIControlStateNormal];
        NSLog(@"122");
    }
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
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 30, 0, [UIImage imageNamed:@"getin@2x"].size.width, [UIImage imageNamed:@"getin@2x"].size.height)];
    imageView.image = [UIImage imageNamed:@"getin@2x"];
    imageView.centerY = 35;
    switch (indexPath.row) {
        case 0:
            
            cell.textLabel.text = @"姓名";
         
            [cell.contentView addSubview:_nameTextField];
            _nameTextField.placeholder = @"姓名";
            break;
        case 1:
            [cell.contentView addSubview:_chooseFeMale];
            [cell.contentView addSubview:_chooseMale];
            [cell.contentView addSubview:_maleLabel];
            [cell.contentView addSubview:_femaleLabel];
            _maleLabel.centerY = _chooseFeMale.centerY;
            _femaleLabel.centerY = _chooseFeMale.centerY;
            cell.textLabel.text = @"性别";
            break;
        
        case 2:
            
            cell.textLabel.text = @"出生日期";
            [cell.contentView addSubview:_birthTextField];
            _birthTextField.placeholder = @"选择生日";
            _birthTextField.delegate = self;
            [cell.contentView addSubview:imageView];
            break;
        
        case 3:
            
            cell.textLabel.text = @"手机号码";
            [cell.contentView addSubview:_phoneTextField];
            _phoneTextField.placeholder = @"请输入手机号";
            break;
            
        case 4:
            
            cell.textLabel.text = @"身份证号码";
            [cell.contentView addSubview:_identityTextField];
            _identityTextField.placeholder = @"请输入证件号";
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

-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

#pragma mark -----------uitextField ---------
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"开始编辑");
    if (textField == _birthTextField) {
        [self addBirthView];
        return NO;

    }
    else if (textField == _phoneTextField){
        _tableView.contentOffset = CGPointMake(0, 100);
    }
    else if (textField == _identityTextField){
        _tableView.contentOffset = CGPointMake(0, 100);
    }

    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}


- (BOOL) textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _nameTextField) {
        [textField endEditing:YES];
    }
    else if (textField == _phoneTextField)
    {
        [_identityTextField becomeFirstResponder];
    }
    else if (textField == _identityTextField)
    {
        [textField endEditing:YES];
        _tableView.contentOffset = CGPointMake(0, 0);
    }
    return YES;
}
-(void)addBirthView
{
    NSDate *theDate = [NSDate date];
    //NSString *birthdayString = [_userInfoDictionary objectForKey:@"birth"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //theDate = [dateFormatter dateFromString:birthdayString];
    
    MSDatePicker *datePicker = [[MSDatePicker alloc] initwithYMDDatePickerDelegate:self withMinimumDate:@"1900-01-01" withMaximumDate:[NSDate date] withNowDate:theDate];
    [datePicker showInView:self.view];

    NSLog(@"2012%@",theDate);
}





-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---------------- MSDatePickerDelegate回调 -----------------
- (void) checkOneDate:(NSDate *)theDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    _getDateString = [dateFormatter stringFromDate:theDate];
    _birthTextField.text = _getDateString;
    NSLog(@"%@",_getDateString);
   // [_tableView reloadData];
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
