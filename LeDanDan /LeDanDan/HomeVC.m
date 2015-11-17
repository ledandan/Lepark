//
//  HomeVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/2.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "HomeVC.h"
#import "PlayDetailViewController.h"
#import "HomeTableViewCell.h"
#import "PlayVC.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"乐蛋蛋";
    [self config];
}
-(void)config
{
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"near@3x",@"longtravel@3x",@"studio@3x",@"hotel@3x",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"周边游",@"长途旅行",@"学院",@"酒店",nil];
    for (int i =0; i<imageArr.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width) /4 *i,40, (self.view.bounds.size.width) /4, 80 +10)];
       // view.backgroundColor=[UIColor redColor];
       view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 15, (self.view.bounds.size.width) /4, 70);
       // btn1.backgroundColor=[UIColor redColor];
        [btn1 setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
           [btn1 addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];
        
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 70, (self.view.bounds.size.width) /4, 20)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font=[UIFont boldSystemFontOfSize:12];
        label2.text = titleArr[i];
        [view addSubview:label2];
        
    }
    NSArray *imageArr2=[NSArray arrayWithObjects:@"children@3x",@"broadcast@3x",@"gift@3x",@"activity@3x", nil];
    NSArray *titleArr2=[NSArray arrayWithObjects:@"儿童聚餐",@"演播室",@"邀请有礼",@"室内活动", nil];
    for (int j=0; j<imageArr2.count; j++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width) /4 *j,130, (self.view.bounds.size.width) /4, 80 +10)];
        //view.backgroundColor=[UIColor yellowColor];
        view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 0, (self.view.bounds.size.width) /4, 70);
        //btn1.backgroundColor=[UIColor yellowColor];
        [btn1 setImage:[UIImage imageNamed:imageArr2[j]] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];
        
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 60, (self.view.bounds.size.width) /4, 20)];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.font=[UIFont boldSystemFontOfSize:12];
        label2.text = titleArr2[j];
        [view addSubview:label2];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, 10)];
    view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    view.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;
    view.layer.borderWidth = 0.5;
    [self.view addSubview:view];
    
    [self createTB];
    
}
-(void)Click:(UIButton*)btn{
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[PlayVC new]];
    [self presentViewController:nav animated:YES completion:nil];
}
-(void)createTB
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, self.view.frame.size.height - 230) style:UITableViewStylePlain];
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
    return 30;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[PlayDetailViewController new]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(-2, 0, tableView.bounds.size.width+4, 30)];
    if (section == 1)
        [headerView setBackgroundColor:[UIColor redColor]];
    else
        [headerView setBackgroundColor:[UIColor whiteColor]];
    UILabel *label1 =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width - 10, 30)];
    label1.text = @"热门推荐";
    label1.textColor = [UIColor blackColor];
    label1.backgroundColor = [UIColor clearColor];
    [headerView addSubview:label1];
    headerView.layer.borderWidth = 0.5;
    headerView.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;
    return headerView;
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
