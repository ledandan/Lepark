//
//  TravleEditAddVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/5.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "TravleEditAddVC.h"

@interface TravleEditAddVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    UITableView *_tableView;
    UITextField *NametextField;
    UITextField *SextextField;
    UITextField *DatetextField;
    UITextField *NumbertextField;
}

@end

@implementation TravleEditAddVC

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
    
  
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height ) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.frame = CGRectMake(10, _tableView.frame.origin.y + _tableView.frame.size.height + 30, self.view.frame.size.width- 20, 56);
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
    
  // imageView.frame.origin.y = 30 - imageView.frame.size.height/2;
    switch (indexPath.row) {
        case 0:
            NametextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
            NametextField.delegate =self;
            cell.textLabel.text = @"出行人姓名：  ";
            // textField.centerY = cell.centerY;
            NametextField.placeholder = @"  馒头";
            NametextField.tag = 321;
            NametextField.returnKeyType =UIReturnKeyNext;
            [cell.contentView addSubview:NametextField];
            if (_isEditAdd) {
                NametextField.placeholder = @"姓名";
            }
            break;
            
            
        case 1:
            
            SextextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
           SextextField .delegate =self;
            // textField.centerY = cell.centerY;
           SextextField .placeholder = @"男";
           SextextField .tag = 323;
           SextextField .returnKeyType =UIReturnKeyNext;
            [cell.contentView addSubview:SextextField ];
            cell.textLabel.text = @"性别:";
            if (_isEditAdd) {
               //
            }
            break;
            
        case 2:
            
            
          DatetextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
            DatetextField.delegate =self;
            // textField.centerY = cell.centerY;
            DatetextField.placeholder = @"选择出生日期";
         DatetextField.tag = 323;
            DatetextField.returnKeyType =UIReturnKeyNext;
            [cell.contentView addSubview: DatetextField];
            cell.textLabel.text = @"出生日期：";
            if (_isEditAdd) {
                DatetextField.placeholder = @"选择出生日期";
            }
            [cell.contentView addSubview:imageView];
            
            break;
            
        case 3:
            
           NumbertextField = [[UITextField alloc]initWithFrame:CGRectMake(100, 10, 300, 40)];
           NumbertextField.delegate =self;
            // textField.centerY = cell.centerY;
            NumbertextField.placeholder = @"    请输入证件号";
            NumbertextField.tag = 323;
            cell.textLabel.text=@"身份证号码：";
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
