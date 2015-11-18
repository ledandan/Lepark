//
//  TravelEditViewController.m
//  LeDanDan
//
//  Created by yzx on 15/11/9.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "TravelEditViewController.h"

#import "MSDatePicker.h"
@interface TravelEditViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UITextField *NametextField;
    UITextField *SextextField;
    UITextField *DatetextField;
    UITextField *NumbertextField;
    
    UIDatePicker *_datePicker;
    
    NSString *_getDateString;
}

@end

@implementation TravelEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    
    self.navigationController.navigationBar.translucent=NO;
    [super viewDidLoad];
    self.title=@"添加出行人";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    [self addAllControl];
}
-(void)addAllControl
{
    [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    [_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height ) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(10, 210+ 70, self.view.frame.size.width- 20, 50);
    sure.backgroundColor =[UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
    [sure setTitle:@"确定" forState: UIControlStateNormal];
    [self.view addSubview:sure];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    //NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, cell.textLabel.frame.origin.y, [UIImage imageNamed:@"getin@3x"].size.width, [UIImage imageNamed:@"getin@3x"].size.height)];
    imageView.image = [UIImage imageNamed:@"getin@3x"];
    imageView.frame= CGRectMake(self.view.frame.size.width - 50, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 110, 60)];
    
    [cell.contentView addSubview:label];
    
    // imageView.frame.origin.y = 30 - imageView.frame.size.height/2;
    switch (indexPath.row) {
        case 0:
            NametextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
            NametextField.delegate =self;
            label.text = @"出行人姓名:";
            // textField.centerY = cell.centerY;
            NametextField.x = label.right;
            NametextField.placeholder = _name;
            NametextField.tag = 321;
            NametextField.returnKeyType =UIReturnKeyNext;
            NametextField.centerY = label.centerY;
            NametextField.font = label.font;
            [cell.contentView addSubview:NametextField];
            if (_isEditAdd) {
                NametextField.placeholder = @"姓名";
            }
            break;
            
            
        case 1:
            
            SextextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
            SextextField .delegate =self;
            // textField.centerY = cell.centerY;
            SextextField .placeholder = _sex;
            SextextField .tag = 323;
            SextextField.x = label.right;
            SextextField.centerY = label.centerY;
            SextextField.font = label.font;
            SextextField .returnKeyType =UIReturnKeyNext;
            [cell.contentView addSubview:SextextField ];
            label.text = @"性别:";
            if (_isEditAdd) {
                //
            }
            break;
            
        case 2:
            
            
            DatetextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
            DatetextField.delegate =self;
            // textField.centerY = cell.centerY;
            DatetextField.placeholder = _date;
            DatetextField.delegate = self;
            DatetextField.tag = 323;
            DatetextField.returnKeyType =UIReturnKeyNext;
            [cell.contentView addSubview: DatetextField];
            label.text = @"出生日期：";
            
            DatetextField.x = label.right;
            DatetextField.centerY = label.centerY;
            DatetextField.font = label.font;
            if (_isEditAdd) {
                DatetextField.placeholder = @"选择出生日期";
            }
            DatetextField.text = _getDateString;
            imageView.centerY = label.centerY;
            [cell.contentView addSubview:imageView];
            
            break;
            
        case 3:
            
            NumbertextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
            NumbertextField.delegate =self;
            // textField.centerY = cell.centerY;
            NumbertextField.placeholder = _numberID;
            NumbertextField.tag = 323;
            label.text=@"身份证号码：";
            
            NumbertextField.x = label.right;
            NumbertextField.centerY = label.centerY;
            NumbertextField.font = label.font;
            NumbertextField.returnKeyType =UIReturnKeyDone;
            [cell.contentView addSubview:NumbertextField];
            break;
            
            
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}




- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
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
    
}


-(void)datePickerValueChanged:(id)sender
{
    　NSDate *selected = [_datePicker date];
    NSLog(@"date: %@", selected);
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == DatetextField) {
        
        NSDate *theDate = [NSDate date];
        //NSString *birthdayString = [_userInfoDictionary objectForKey:@"birth"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSTimeZone *timeZone = [NSTimeZone localTimeZone];
        [dateFormatter setTimeZone:timeZone];
        //theDate = [dateFormatter dateFromString:birthdayString];
        
        MSDatePicker *datePicker = [[MSDatePicker alloc] initwithYMDDatePickerDelegate:self withMinimumDate:@"1900-01-01" withMaximumDate:[NSDate date] withNowDate:theDate];
        [datePicker showInView:self.view];
    }
    
    return YES;
}

#pragma mark ---------------- MSDatePickerDelegate回调 -----------------
- (void) checkOneDate:(NSDate *)theDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    _getDateString = [dateFormatter stringFromDate:theDate];
    [_tableView reloadData];
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
