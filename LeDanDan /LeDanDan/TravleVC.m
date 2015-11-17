//
//  TravleVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/4.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "TravleVC.h"
#import "TravleTableViewCell.h"
#import "TravleEditAddVC.h"

@interface TravleVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    
    UITableView *_tableView;
}

@end

@implementation TravleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    
    self.navigationController.navigationBar.translucent=NO;
 
    self.title=@"出行人";
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
//   if (_dataArr.count == 0) {
//        [self travleIsEmpty];
//  }
//   else
//   {
       [self travleIsNoEmpty];
  // }
    
    
}
-(void)travleIsEmpty
{
   
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStyleDone target:self action:@selector(add )];
    
    
    UIImageView *travel = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    travel.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    travel.image =[UIImage imageNamed:@"address@2x"];
    [self.view addSubview:travel];
    
    

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(travel.frame.origin.x , travel.frame.origin.y + travel.frame.size.height +10, 200, 20)];
    label.text = @"您还没有添加联系人哦!";
    [label sizeToFit];
    
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    [self.view addSubview:label];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
    btn.frame = CGRectMake(0, label.frame.origin.y + label.frame.size.height +10, 100, 35);
    [btn setTitle:@"去添加" forState: UIControlStateNormal];
    btn.center = CGPointMake(self.view.frame.size.width/2, btn.center.y);
    btn.layer.cornerRadius = 6;
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:btn];
}
-(void)travleIsNoEmpty
{
    _dataArr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"新增" style:UIBarButtonItemStyleDone target:self action:@selector(newadd)];
    self.view.backgroundColor=[UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStyleGrouped];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
   [_tableView  setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:_tableView];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%li)行数",(long)section);
    
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    static NSString *cellID = @"cellID";
    
   TravleTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    [cell setLayoutMargins:UIEdgeInsetsZero];
    if (cell == nil) {
        NSArray *nib =[[NSBundle mainBundle]loadNibNamed:@"TravleTableViewCell" owner:self options:nil];
        cell = [nib lastObject];
      [cell.edit setImage:[UIImage imageNamed:@"edit@2x"] forState:UIControlStateNormal];
      [cell.clear setImage:[UIImage imageNamed:@"clear@2x"] forState:UIControlStateNormal];
              cell.date.font = [UIFont systemFontOfSize:10];
        cell.name.font = [UIFont systemFontOfSize:10];
        cell.sex.font = [UIFont systemFontOfSize:10];
        cell.property.font=[UIFont systemFontOfSize:10];
        cell.edit.tag = indexPath.row ;
        cell.clear.tag = indexPath.row+100;
        [cell.edit addTarget: self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
        [cell.clear addTarget: self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.textLabel.text = _dataArr[indexPath.row];
        
    }
   
    
    return cell;
    //return nil;
    
    
  
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}



- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}

-(void)edit: (UIButton *)btn
{
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[TravleEditAddVC new]];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)deleteBtn:(UIButton *)btn
{
   
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)add
{
    
}
-(void)newadd
{
    
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
