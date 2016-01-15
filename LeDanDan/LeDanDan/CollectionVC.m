//
//  CollectionVC.m
//  LeDanDan
//
//  Created by yzx on 15/11/4.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "CollectionVC.h"
#import "CollectionTableViewCell.h"
#import "MJRefresh.h"
#import "MyCollectionModel.h"
@interface CollectionVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArr;
    UITableView *_tableView;
}

@end

@implementation CollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArr = [[NSMutableArray alloc]init];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(0, 0, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = backItem;
    self.title=@"我的收藏";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    
    float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    self.navigationController.navigationBar.translucent=NO;
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];

    [self loadData];
    
}

-(void)loadData
{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults]objectForKey:kLastLoginUserInfo];
    
    NSString *ID =[NSString stringWithFormat:@"%d",(int)[userDic objectForKey:@"id"]];
    NSDictionary *dic = @{@"userId":@"1"};
    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kMyCollection succeed:^(id success)
     {
         
         NSLog(@"%@",[success objectForKey:@"result"]);
         NSArray *arr =(NSArray *)[success objectForKey:@"result"];
         for (int i = 0; i< arr.count; i++) {
             MyCollectionModel *model = [[MyCollectionModel alloc]initWithDictionary:arr[i] error:nil];
             [_dataArr addObject:model];
         }
         [self collectTB];
       
         
     }failed:^(id error)
     {
         
         NSLog(@"%@",error);
         
     }];
}
-(void)collectTB
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 马上进入刷新状态
//        [_tableView.mj_header beginRefreshing];
//        
//    }];
    [self.view addSubview:_tableView];
}


-(void)isCollection: (UIButton *)btn
{
    NSLog(@"收储");
    MyCollectionModel *model = (MyCollectionModel *)_dataArr[btn.tag];
    NSDictionary *dic = @{@"collectionsId":model.collectionId};
    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kcancelCOllection succeed:^(id success)
     {
         NSLog(@"%@",success);
         [_tableView reloadData];

     }failed:^(id error)
     {
         NSLog(@"%@",error);
     }];
}

#pragma mark ---------uiTableViewDelegate -------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}



- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
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
    
    CollectionTableViewCell*cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        // cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopTableViewCell" owner:self options:nil] lastObject];
        cell = [[CollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        MyCollectionModel *model = (MyCollectionModel *)_dataArr[indexPath.row];
        cell.playName.text = model.activitysName;
        cell.time.text = model.activitysDateTime;
        cell.address.text = model.activitysAddress;
        cell.price.text = model.activitysPrice;
        cell.NoCollection.tag = indexPath.row;
        [cell.NoCollection addTarget:self action:@selector(isCollection:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击 Table");
    
   // [_tableView.mj_header endRefreshing];
    
}

-(void)doBack:(id)sender
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
