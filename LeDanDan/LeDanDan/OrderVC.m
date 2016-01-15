//
//  OrderVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/3.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "OrderVC.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
#import "MJRefresh.h"
#import "MyOrderModel.h"
@interface OrderVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UILabel *_label;
    NSArray *_dataArr;
    
    UITableView *_tableView;
    NSMutableArray *_orderArr;
}

@end

@implementation OrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _orderArr = [[NSMutableArray alloc]init];
   
    [super viewDidLoad];
    self.title=@"我的订单";
    
    _dataArr = [NSArray arrayWithObjects:@"大",@"中",@"小", nil];
    //_dataArr = [NSArray arrayWithObjects:nil];
    [self loadData];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];

    self.navigationController.navigationBar.translucent=NO;
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }

}

-(void)loadData
{
   // {userId:”123”,”type”:”1”,”page”:”1”,”pageNumber”:”10”}
    NSDictionary *dic = @{@"userId":@"3",@"type":@"0",@"page":@"1",@"pageNumber":@"10"};
    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kMyOrder succeed:^(id success)
     {
         NSArray *arr = nil;
         arr =(NSMutableArray *)[success objectForKey:@"result"];
         for (int i = 0; i < arr.count; i++) {
             
             NSMutableDictionary *orderDic = [NSMutableDictionary dictionaryWithDictionary:[arr objectAtIndex:i]];
             MyOrderModel *orderModel =[[MyOrderModel alloc]initWithDictionary:orderDic error:nil];
             [_orderArr addObject:orderModel];

             
         }
         [self addAllControl];
         
     }failed:^(id error)
     {
         NSLog(@"%@",error);
     }];
}
-(void)addAllControl
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"全部",@"待付款",@"待出行",@"待评价", nil];
    for (int i = 0; i < titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4 * i, 0, self.view.frame.size.width/4, 40)];
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1] forState:UIControlStateNormal];
        [bgView addSubview:btn];
       
    }
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(10 , 38, self.view.frame.size.width/4 -20, 2)];
    _label.backgroundColor =[UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1]
    ;
    [self.view addSubview:_label];
    
    if (_dataArr.count == 0) {
        [self orderIsEmpty];
    }
    else
    {
        [self orderIsNoEmpty];
    }

}
-(void)orderIsEmpty
{
    
    UIImageView *car = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 150, 150)];
    car.center = CGPointMake(self.view.center.x, self.view.center.y - 50);
    car.image =[UIImage imageNamed:@"order@2x"];
    [self.view addSubview:car];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(car.frame.origin.x , car.frame.origin.y + car.frame.size.height +10, 200, 20)];
    label.text = @"您还没有相关的订单";
    [label sizeToFit];
    
    label.center = CGPointMake(self.view.frame.size.width/2, label.center.y);
    [self.view addSubview:label];
    
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithRed:0.13 green:0.73 blue:0.47 alpha:1];
    btn.frame = CGRectMake(0, label.frame.origin.y + label.frame.size.height +10, 100, 35);
    [btn setTitle:@"随便看看" forState: UIControlStateNormal];
    btn.center = CGPointMake(self.view.frame.size.width/2, btn.center.y);
    btn.layer.cornerRadius = 6;
    [self.view addSubview:btn];
    
}
-(void)orderIsNoEmpty
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, self.view.frame.size.width, self.view.frame.size.height - 40 -64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor redColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 马上进入刷新状态
//        [_tableView.mj_header beginRefreshing];
//        
//    }];
    
    [self.view addSubview:_tableView];
}
//切换状态

-(void)changeBtn:(UIButton *)btn
{
    [UIView animateWithDuration:0.25 animations:^{
        _label.frame = CGRectMake(btn.frame.origin.x +10 , _label.frame.origin.y, _label.frame.size.width, _label.frame.size.height);
    }];
    NSLog(@"%f",_label.frame.origin.x);
    
}
-(void)pay : (UIButton *)btn
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[OrderDetailViewController new]] animated:YES completion:nil];
}

#pragma mark --------tableView ------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}



- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%li)行数",(long)section);
    
    return _orderArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    static NSString *cellID = @"cellID";
    
    OrderTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
   
    if (cell == nil) {
       
        NSLog(@"%@",_orderArr[indexPath.row]);
       
        // cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopTableViewCell" owner:self options:nil] lastObject];
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //cell.playName.text = model.activitysName;
        MyOrderModel *model = (MyOrderModel *)_orderArr[indexPath.row];
        cell.playName.text = model.activitysName;
        cell.price.text = [NSString stringWithFormat:@"￥ %@",model.activitysPrice];
        [cell.playImage sd_setImageWithURL:[NSURL URLWithString:model.activitysLogo]];
        if ([model.status isEqualToString:@"1"]) {
            
            cell.status.text = @"下订单";

        }
        else if ([model.status isEqualToString:@"2"])
        {
            cell.status.text = @"已支付";
        }
        else if ([model.status isEqualToString:@"3"])
        {
            cell.status.text = @"待出行";
        }
        else if([model.status isEqualToString:@"4"])
        {
            cell.status.text = @"待评价";
            
        }
        else
        {
            cell.status.text = @"删除订单";
        }
            
    }

    [cell.status_btn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
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
