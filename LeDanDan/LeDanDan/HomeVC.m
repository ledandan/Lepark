//
//  HomeVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/2.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#define vPopViewOneChoiceCellHeight  38
#define vPopViewFullWidth  105.0

#import "HomeVC.h"
#import "PlayDetailViewController.h"
#import "HomeTableViewCell.h"
#import "PlayVC.h"
#import <CMPopTipView.h>
#import <CoreLocation/CoreLocation.h>
#import "SearchActivityViewController.h"

#import "MJRefresh.h"

@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    UITableView *_tableView;
    UITableView *_cityTableView;
    
    CLLocationManager *locationManager;
    
    BOOL openCity ;
   
}

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"乐蛋蛋";
    
    openCity = NO;
    
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(search)];
    
    UIBarButtonItem *addressBtn = [[UIBarButtonItem alloc] initWithTitle:@"上 海" style:UIBarButtonItemStylePlain target:self action:@selector(positioning)];

    UIBarButtonItem *hiddenBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"hidden@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(positioning)];
    
    
    //初始化toolbar
    UIToolbar *rightToolbar = [[UIToolbar alloc]init];
    rightToolbar.items = [NSArray arrayWithObjects:addressBtn,hiddenBtn,nil];
    
    //使button的tint色与导航条一致
    rightToolbar.tintColor = self.navigationController.navigationBar.tintColor;
    //调整宽度使button间距缩小
    rightToolbar.frame = CGRectMake(10, 0, 220, 44);
    
    //移除背景，用于添加到UIToolbar或UINavigationBar中
    rightToolbar.backgroundColor = [UIColor clearColor];
    for (UIView *view in [rightToolbar subviews]) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    //添加到navigationbar中
    [self.navigationController.visibleViewController.navigationController.navigationBar addSubview:rightToolbar];

    
//    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: addressBtn,hiddenBtn ,nil]];
//    self.navigationController.navigationBar.width = self.navigationController.navigationBar.width - 50;
    [self config];
    
   
   }

- (void) viewWillAppear:(BOOL)animated
{
    [self dismissModalViewControllerAnimated:YES];
//    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
//    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
//    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    //self.navigationItem.leftBarButtonItem=barbtn;
}
-(void)config
{
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"near@3x",@"longtravel@3x",@"studio@3x",@"hotel@3x",nil];
    NSArray *titleArr = [NSArray arrayWithObjects:@"周边游",@"长途旅行",@"学院",@"酒店",nil];
    for (int i =0; i<imageArr.count; i++) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake((self.view.bounds.size.width) /4 *i,40, (self.view.bounds.size.width) /4, 80 +10)];
       
       view.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:view];
        
        UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        btn1.frame = CGRectMake(0, 15, (self.view.bounds.size.width) /4, 70);
    
        [btn1 setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        [btn1 addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn1];
        btn1.tag = 101+ i;
        [btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];

        
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
        btn1.tag = 1001+ j;
        [btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
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
    switch (btn.tag - 101) {
        case 0:
            NSLog(@"周边游");
            [self strcat];
            break;
        case 1:
            NSLog(@"长途旅行");
            //结束刷新
            //[self.tableView.mj_header endRefreshing];
            break;
        case 2:
            NSLog(@"学院");
            break;
        case 3:
            NSLog(@"酒店");
            break;
        default:
            break;
    }
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[PlayVC new]];
//    [self presentViewController:nav animated:YES completion:nil];
}

-(void)strcat
{
    
}

-(void)createTB
{
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0, 230, self.view.frame.size.width, self.view.frame.size.height - 230 - 49) style:UITableViewStylePlain];
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
     //[_tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
//    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 马上进入刷新状态
//        
//    [self.tableView.mj_header beginRefreshing];
//       
//        
//    }];

    [self.view addSubview:_tableView];
    
}



-(void)btnPress: (UIButton *)btn
{
    switch (btn.tag - 1001) {
        case 0:
            NSLog(@"儿童聚餐");
            break;
        case 1:
            NSLog(@"演播室");
            break;
        case 2:
            NSLog(@"邀请有礼");
            break;
        case 3:
            NSLog(@"市内活动");
            break;
            
        default:
            break;
    }
}

//搜索
-(void)search
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[SearchActivityViewController new]] animated:YES completion:nil];
}


//定位
-(void)positioning
{

    if (openCity == NO) {
        
        openCity = YES;
    }
    else{
        openCity = NO;
    }
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager requestWhenInUseAuthorization];
    // 开始时时定位
    [locationManager startUpdatingLocation];
   
    
    if (openCity == NO) {
        
        [self addCity];
    }
    else{
        _cityTableView.hidden = YES;
    }
    
    
}

-(void)addCity
{
    _cityTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth - 100, 250) style:UITableViewStyleGrouped];
    _cityTableView.delegate = self;
    _cityTableView.dataSource = self;
    _cityTableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_cityTableView];

    
}

// 错误信息
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"error");
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    CLLocation *newLocation = locations[0];
    CLLocationCoordinate2D oldCoordinate = newLocation.coordinate;
    NSLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);
    

    
    //------------------位置反编码---5.0之后使用-----------------
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:newLocation
                   completionHandler:^(NSArray *placemarks, NSError *error){
                       
                       for (CLPlacemark *place in placemarks) {
                           //                           UILabel *label = (UILabel *)[self.window viewWithTag:101];
                           //                           label.text = place.name;
                           NSLog(@"name,%@",place.name);                       // 位置名
                           NSLog(@"thoroughfare,%@",place.thoroughfare);       // 街道
                           NSLog(@"subThoroughfare,%@",place.subThoroughfare); // 子街道
                           NSLog(@"locality,%@",place.locality);               // 市
                           NSLog(@"subLocality,%@",place.subLocality);         // 区
                           NSLog(@"country,%@",place.country);// 国家
                       }
                       
                   }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    if (tableView == _cityTableView) {
        
        static NSString *cellID = @"cellID";
        
        UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.layer.borderWidth = 0.1;
        cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        cell.textLabel.text = @"上海";
        
        if (indexPath.row == 9) {
            cell.textLabel.text = @"更多城市开通中";
            cell.textLabel.textAlignment = UITextAlignmentCenter;
        }
        
        return  cell;
    }
    else{
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _cityTableView) {
        return 30;
    }
    else{
    return 210;
    }
}


- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _cityTableView) {
        return 0.001;
    }
    else{
    return 30;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[PlayDetailViewController new]];
//    [self presentViewController:nav animated:YES completion:nil];
    [self presentModalViewController:[PlayDetailViewController new] animated:YES];
    
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView != _cityTableView) {
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
    else
    {
        return nil;
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
