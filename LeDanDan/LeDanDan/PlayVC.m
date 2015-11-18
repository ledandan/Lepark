//
//  PlayVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/5.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "PlayVC.h"
#import "PlayDetailViewController.h"
#import "HomeTableViewCell.h"


@interface PlayVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}

@end

@implementation PlayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    
    self.navigationController.navigationBar.translucent=NO;
    
    
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    [self config];
}
-(void)config
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -70) style:UITableViewStylePlain];
    //_tabelView.backgroundColor = [UIColor yellowColor];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.tableHeaderView.backgroundColor = [UIColor redColor];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    
    static NSString *cellID = @"cellID";
    
    HomeTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
        cell = [nib lastObject];
        
    }
    //取消选中颜色
    
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    //cell.textLabel.text=[NSString stringWithFormat:@"%ld行",(long)indexPath.row];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 210;
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[PlayDetailViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
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
