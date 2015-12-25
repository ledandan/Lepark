//
//  OrderDetailViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/18.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController () <UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    UIButton *btn;
    UIButton *btn1;
    BOOL isWX;
}
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"订单详情";
    
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100 , 0, 13, 13);
    btn.centerY = 25;
    btn.tag = 1;
    [btn setImage:[UIImage imageNamed:@"select_noselect@2x"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(payOfMay:) forControlEvents:UIControlEventTouchUpInside];
    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(200 , 0, 13, 13);
    btn1.centerY = 25;
    btn1.tag =2;
    [btn1 addTarget:self action:@selector(payOfMay:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setImage:[UIImage imageNamed:@"select_noselect@2x"] forState:UIControlStateNormal];

    [self addAllControl];
    
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

-(void)addAllControl
{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.height = kScreenHeight - 50;
   // _tableView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_tableView];
    
    //底部立即支付
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _tableView.bottom, kScreenWidth, 50)];
    bottomView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:bottomView];
    
    int pri = 188.88;
    int oldPri = 288.41;
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 50)];
    priceLabel.text = [NSString stringWithFormat:@"总金额 :￥ %d (实付￥ %d)",pri,oldPri];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:15];
    [bottomView addSubview:priceLabel];
    
    //立即支付
    UIButton *payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    payBtn.frame = CGRectMake(kScreenWidth - 90, 0, 90, 50);
    [payBtn setTitle:@"立即支付" forState: UIControlStateNormal];
    payBtn.backgroundColor = [UIColor colorWithRed:0.84 green:0.25 blue:0.24 alpha:1];
    [bottomView addSubview:payBtn];
}

#pragma mark -----------tableView delegate ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.layer.borderWidth = 0.1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    //订单图片
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(10, 10, 80, 80);
    imageView.image = [UIImage imageNamed:@"1"];
    
    //订单内容
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +10, 10, 130, 80)];
    contentLabel.text = @"小小地质学家启蒙课,关于地层的密码,小小地质学家启蒙课,关于地层的密码小小地质学家启蒙课,关于地层的密码";
    //[contentLabel sizeToFit];
    contentLabel.numberOfLines = 3;
    contentLabel.font = [UIFont systemFontOfSize:12];
    CGSize sizeOfHeight = [contentLabel.text sizeWithFont:contentLabel.font];
    NSInteger number = contentLabel.numberOfLines;
    contentLabel.height = sizeOfHeight.height * number;
   
    //价格
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(contentLabel.x, imageView.bottom - 15, 100, 15)];
    price.text = @"￥120";
    price.textColor = [UIColor colorWithRed:0.9 green:0.51 blue:0.42 alpha:1];
    
    //订单状态
    UILabel *orderStatus = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 10, 50, 15)];
    orderStatus.text = @"待付款";
    orderStatus.textColor = [UIColor colorWithRed:0.9 green:0.51 blue:0.42 alpha:1];
    orderStatus.font = [UIFont systemFontOfSize:12];
    
    
    //右部分
    
    UILabel *rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, kScreenWidth - 100, 50)];
    rightLabel.textColor = [UIColor colorWithRed:0.38 green:0.38 blue:0.38 alpha:1];
    rightLabel.font = [UIFont systemFontOfSize:15];
    
    //支付方式

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(btn.right +3, 0, 80, 50)];
    label.font = [UIFont systemFontOfSize:12];
    label.text = @"支付宝";
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(btn1.right +3, 0, 80, 50)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.text = @"微信";
    
    switch (indexPath.row) {
        case 0:
            
            [cell.contentView addSubview:contentLabel];
            [cell.contentView addSubview:imageView];
            [cell.contentView addSubview:price];
            [cell.contentView addSubview:orderStatus];
            break;
        case 1:
            cell.backgroundColor = self.view.backgroundColor;
            cell.textLabel.text = @"订单信息";
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.textColor = [UIColor grayColor];
            
            break;
        case 2:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"联系人";
            [cell.contentView addSubview:rightLabel];
            rightLabel.text = @"小明";
            break;
        case 3:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"联系电话";
            [cell.contentView addSubview:rightLabel];
            rightLabel.text = @"186262616121";
            break;
        case 4:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"有效期";
            [cell.contentView addSubview:rightLabel];
            rightLabel.text = @"2016 -10 -5 ";
            break;
        case 5:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"活动人数";
            [cell.contentView addSubview:rightLabel];
            rightLabel.text = @"2大人1小孩";
            break;
        case 6:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"下单时间";
            [cell.contentView addSubview:rightLabel];
            rightLabel.text = @"2015 -10 -5";
            break;
        case 7:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"订单编号";
            [cell.contentView addSubview:rightLabel];
            rightLabel.text = @"1134321の31";
            break;
        case 8:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"支付方式";
            [cell.contentView addSubview:btn];
            [cell.contentView addSubview:label];
            [cell.contentView addSubview:btn1];
            [cell.contentView addSubview:label1];

            break;
        case 9:
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            cell.textLabel.text = @"选择优惠券";
            break;
        default:
            break;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            return 100;
            break;
        case 1:
            return 30;
            break;
        default:
            break;
    }
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
}


-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)payOfMay:(UIButton *)b
{
    if (b.tag ==1) {
        isWX = NO;
        [btn setImage:[UIImage imageNamed:@"select_select@2x"] forState:UIControlStateNormal];
        [btn1 setImage:[UIImage imageNamed:@"select_noselect@2x"] forState:UIControlStateNormal];
    }
    else
    {
        isWX = YES;
        [btn1 setImage:[UIImage imageNamed:@"select_select@2x"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"select_noselect@2x"] forState:UIControlStateNormal];
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
