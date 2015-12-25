//
//  SearchActivityViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/16.
//  Copyright © 2015年 yzx. All rights reserved.
//

#import "SearchActivityViewController.h"

@interface SearchActivityViewController () <UITextFieldDelegate>

@end

@implementation SearchActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"搜索";
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    
    [self addControl];
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

-(void)addControl
{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 5, kScreenWidth - 150, 34)];
    textField.backgroundColor = [UIColor whiteColor];
    textField.centerX = kScreenWidth/2;
    textField.layer.cornerRadius = 5;
    textField.placeholder = @" 请输入活动名称";
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.clearsOnBeginEditing = YES;
    textField.delegate = self;
    textField.returnKeyType =UIReturnKeySearch;
    textField.tintColor = [UIColor grayColor];
    [self.navigationController.navigationBar addSubview:textField];
    
    
    //搜索按钮
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(textField.right +15, 5, 50, 34);
    [searchBtn setTitle:@"搜索" forState: UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setTitleColor:[UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1] forState:UIControlStateNormal];
    searchBtn.layer.cornerRadius = 5;
    [self.navigationController.navigationBar addSubview:searchBtn];
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark ----uitextfieldDele ------

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"搜索完成");
    [textField resignFirstResponder];
    return YES;
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
