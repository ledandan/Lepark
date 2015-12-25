//
//  ApplyViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/18.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "ApplyViewController.h"

@interface ApplyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报名详情";
    
    [self addAllCOntrol];
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

-(void)addAllCOntrol
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource =self;
    _tableView.scrollEnabled = NO;
    _tableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_tableView];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark -----------tableView delegate ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.layer.borderWidth = 0.1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    imageView.image = [UIImage imageNamed:@"1"];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +5, 15, kScreenWidth, 10)];
    nameLabel.text = @"小小地质学,探索奥秘";
    nameLabel.font = [UIFont systemFontOfSize:14];
    
    
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right + 5, nameLabel.bottom +8, kScreenWidth, 10)];
    timeLabel.text = @"10月12日  周六";
    timeLabel.font = [UIFont systemFontOfSize:13];
    
    UILabel *addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +5, timeLabel.bottom +8, kScreenWidth, 10)];
    addressLabel.text = @"上海市闸北区";
    addressLabel.font = [UIFont systemFontOfSize:13];
    addressLabel.textColor = [UIColor lightGrayColor];
    
    
    UILabel *activityTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, kScreenWidth, 15)];
    activityTime.text = @"活动日期: 2015-10-05";
    activityTime.font = [UIFont systemFontOfSize:15];
    
    UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, kScreenWidth, 15)];
    time.text = @"7:00 - 12:00(仅剩10天)";
    time.font = [UIFont systemFontOfSize:15];
    
    //选择数量
    UILabel *numOfChoise = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth, 10)];
    numOfChoise.text = @"选择数量";
    numOfChoise.textColor = [UIColor grayColor];
    numOfChoise.font = [UIFont systemFontOfSize:15];
    
    //一成人
    UILabel *oneAndOne = [[UILabel alloc]initWithFrame:CGRectMake(10, numOfChoise.bottom +15, kScreenWidth, 10)];
    oneAndOne.text = @"一成人一儿童";
    oneAndOne.font = [UIFont systemFontOfSize:15];
    
    //一成人一儿童
    UILabel *oneMan = [[UILabel alloc]initWithFrame:CGRectMake(10, oneAndOne.bottom +15, kScreenWidth, 10)];
    oneAndOne.text = @"1成人";
    oneAndOne.font = [UIFont systemFontOfSize:15];
    
    
    //一成人一儿童
    UILabel *oneChild = [[UILabel alloc]initWithFrame:CGRectMake(10, oneMan.bottom +15, kScreenWidth, 10)];
    oneAndOne.text = @"1儿童";
    oneAndOne.font = [UIFont systemFontOfSize:15];
    
    switch (indexPath.row) {
        case 0:
            [cell.contentView addSubview:imageView];
            [cell.contentView addSubview:nameLabel];
            [cell.contentView addSubview:timeLabel];
            [cell.contentView addSubview:addressLabel];
            break;
        case 1:
            [cell.contentView addSubview:activityTime];
            [cell.contentView addSubview:time];
            break;
        case 2:
            
            break;
        case 3:
            [cell.contentView addSubview:numOfChoise];
            [cell.contentView addSubview:oneAndOne];
            [cell.contentView addSubview:oneMan];
            [cell.contentView addSubview:oneChild];
            break;
        default:
            break;
    }
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==2) {
        return 10;
    }
    else if (indexPath.row == 3)
    {
        return 140;
    }
    else{
        
        return 70;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
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
