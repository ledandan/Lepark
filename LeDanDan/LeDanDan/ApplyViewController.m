//
//  ApplyViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/18.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "ApplyViewController.h"
#import "OrderDetailViewController.h"

@interface ApplyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    
    UILabel *_OneAndOneLabel;
    UILabel *_Man;
    UILabel *_Child;
    
    
    UIButton *plusBtn;
    UIButton *minusBtn;
    UILabel *numLabel;
    
    
    UIButton *plusBtn2;
    UIButton *minusBtn2;
    UILabel *numLabel2;
    
    int ManPrice;
    int ChildPrice;
    int SumPrice;
    int sumOfMan;
    int SumOfChild;
    
    UILabel *priceLabel;
}
@end

@implementation ApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"报名详情";
    ManPrice = 50;
    ChildPrice = 50;
    SumOfChild = 50;
    sumOfMan = 50;
    
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
    
    
    //底部
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 60, kScreenWidth, 60)];
    view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:view];
    
    //总金额
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 60, 60)];
    label.text = @"总金额:";
    label.textColor = [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1];
    label.font = [UIFont systemFontOfSize:18];
    [view addSubview:label];
    
    SumPrice = ManPrice +ChildPrice;
    priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(label.right +10, 0, kScreenWidth, 60)];
    priceLabel.text = [NSString stringWithFormat:@"￥ %d",SumPrice];
    priceLabel.textColor =[UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1];
    priceLabel.font = [UIFont systemFontOfSize:18];
    [priceLabel setTextColor:[UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1]];
    [view addSubview:priceLabel];
    
    //确定
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(kScreenWidth - 100, 0, 100, 60);
    [sureBtn setTitle:@"确定" forState: UIControlStateNormal];
    sureBtn.backgroundColor =[UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:sureBtn];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)PlusBtn:(UIButton *)btn
{
    int i = [numLabel.text intValue];
    int j = [numLabel2.text intValue];
    if (btn.tag == 56) {
        //成人加
        i++;
        numLabel.text = [NSString stringWithFormat:@"%d",i];
        _Man.text = [NSString stringWithFormat:@"￥ %d",ManPrice *i];
        sumOfMan = ManPrice *i;
        SumPrice = SumOfChild + sumOfMan;
        NSLog(@"sumOfMan  %d,SumOfChild  %d",sumOfMan,SumOfChild);
        priceLabel.text = [NSString stringWithFormat:@"￥ %d",SumPrice];
    }
    else
    {
        j++;
        //儿童加
        numLabel2.text = [NSString stringWithFormat:@"%d",j];
        SumOfChild = ChildPrice *j;
        _Child.text = [NSString stringWithFormat:@"￥ %d",SumOfChild];
        
        SumPrice = SumOfChild + sumOfMan;
        priceLabel.text = [NSString stringWithFormat:@"￥ %d",SumPrice];
    }
    
   
}

-(void)minuBtn:(UIButton *)btn
{
    int i = [numLabel.text intValue];
    int j = [numLabel2.text intValue];
    if (btn.tag == 57) {
        //成人减
        if (i >=1) {
            i--;
        }
        
        numLabel.text = [NSString stringWithFormat:@"%d",i];
        sumOfMan = ManPrice *i;
        _Man.text = [NSString stringWithFormat:@"￥ %d",sumOfMan];
        SumPrice =SumPrice - ManPrice *i +ChildPrice ;
        SumPrice = SumOfChild + sumOfMan;
        priceLabel.text = [NSString stringWithFormat:@"￥ %d",SumPrice];
    }
    else{
    

        if (j >= 1) {
            j--;
        }
        numLabel2.text = [NSString stringWithFormat:@"%d",j];
        //儿童减
        SumOfChild = ChildPrice * j;
        _Child.text = [NSString stringWithFormat:@"￥ %d",SumOfChild];
        SumPrice =SumPrice- ManPrice  -ChildPrice *j ;
        SumPrice = SumOfChild + sumOfMan;
        priceLabel.text = [NSString stringWithFormat:@"￥ %d",SumPrice];
    }
    
}


//确定
-(void)sure
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[OrderDetailViewController new]] animated:YES completion:nil];
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
    time.text = @"时间: 7:00 - 12:00(仅剩10天)";
    time.font = [UIFont systemFontOfSize:15];
    
    //选择数量
    UILabel *numOfChoise = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kScreenWidth, 10)];
    numOfChoise.text = @"选择数量";
    numOfChoise.textColor = [UIColor grayColor];
    numOfChoise.font = [UIFont systemFontOfSize:15];
    
    //一成人
    UILabel *oneAndOne = [[UILabel alloc]initWithFrame:CGRectMake(10, numOfChoise.bottom +15, kScreenWidth, 10)];
    oneAndOne.text = @"1 成人1 儿童";
    oneAndOne.font = [UIFont systemFontOfSize:15];
    
    //价格
    _OneAndOneLabel = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, oneAndOne.y, 50, 10)];
    _OneAndOneLabel.text = @"￥ 100";
    _OneAndOneLabel.font = [UIFont systemFontOfSize:15];
    [_OneAndOneLabel setTextColor:[UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1]];
    
    //一成ren
    UILabel *oneMan = [[UILabel alloc]initWithFrame:CGRectMake(10, oneAndOne.bottom +25, kScreenWidth, 10)];
    oneMan.text = @"1 成人";
    oneMan.font = [UIFont systemFontOfSize:15];
    
    
    //价格
    _Man = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, oneMan.y, 50, 10)];
    _Man.text = [NSString stringWithFormat:@"￥ %d",ManPrice];
    _Man.font = [UIFont systemFontOfSize:15];
    [_Man setTextColor:[UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1]];
    
    
    //一成人一儿童
    UILabel *oneChild = [[UILabel alloc]initWithFrame:CGRectMake(10, oneMan.bottom +25, kScreenWidth, 10)];
    oneChild.text = @"1 儿童";
    oneChild.font = [UIFont systemFontOfSize:15];
    
    //价格
    _Child = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth/2, oneChild.y, 50, 10)];
    _Child.text = [NSString stringWithFormat:@"￥ %d",ChildPrice];
    _Child.font = [UIFont systemFontOfSize:15];
    [_Child setTextColor:[UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1]];
    
    
    //数量计算器1
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth -110, _Man.frame.origin.y, 100, 30)];
    view.backgroundColor = [UIColor grayColor];
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;
    view.centerY = _Man.centerY;
    
    
    plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    plusBtn.frame = CGRectMake(0, 0, 30, 30);
    [plusBtn setImage: [UIImage imageNamed:@"gift_numberplus@2x"] forState:UIControlStateNormal];
    [plusBtn addTarget:self action:@selector(PlusBtn:) forControlEvents:UIControlEventTouchUpInside];
    plusBtn.tag = 56;
    [view addSubview:plusBtn];
    
    minusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn.frame = CGRectMake(view.frame.size.width - 30, 0, 30, 30);
    [minusBtn setImage: [UIImage imageNamed:@"gift_numberminus@2x"] forState:UIControlStateNormal];
    minusBtn.backgroundColor = [UIColor clearColor];
    [minusBtn addTarget:self action:@selector(minuBtn:) forControlEvents:UIControlEventTouchUpInside];
    minusBtn.tag = 57;
    // minusBtn.backgroundColor = [UIColor redColor];
    [view addSubview:minusBtn];
    
    numLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, view.frame.size.width -60, 30)];
    numLabel.text = @"1";
    numLabel.textAlignment = NSTextAlignmentCenter;
    numLabel.backgroundColor = [UIColor whiteColor];
    [view addSubview:numLabel];
    
    
    //数量计算器2
    UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth -110, _Child.frame.origin.y, 100, 30)];
    view2.backgroundColor = [UIColor grayColor];
    view2.layer.borderWidth = 1;
    view2.layer.borderColor = [UIColor colorWithRed:0.91 green:0.91 blue:0.91 alpha:1].CGColor;
    view2.centerY = _Child.centerY;
    
    
    plusBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    plusBtn2.frame = CGRectMake(0, 0, 30, 30);
    [plusBtn2 setImage: [UIImage imageNamed:@"gift_numberplus@2x"] forState:UIControlStateNormal];
    [plusBtn2 addTarget:self action:@selector(PlusBtn:) forControlEvents:UIControlEventTouchUpInside];
    plusBtn2.tag = 58;
    [view2 addSubview:plusBtn2];
    
    minusBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    minusBtn2.frame = CGRectMake(view.frame.size.width - 30, 0, 30, 30);
    [minusBtn2 setImage: [UIImage imageNamed:@"gift_numberminus@2x"] forState:UIControlStateNormal];
    minusBtn2.backgroundColor = [UIColor clearColor];
    [minusBtn2 addTarget:self action:@selector(minuBtn:) forControlEvents:UIControlEventTouchUpInside];
    // minusBtn.backgroundColor = [UIColor redColor];
    minusBtn2.tag = 59;
    [view2 addSubview:minusBtn2];
    
    numLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 0, view.frame.size.width -60, 30)];
    numLabel2.text = @"1";
    numLabel2.textAlignment = NSTextAlignmentCenter;
    numLabel2.backgroundColor = [UIColor whiteColor];
    [view2 addSubview:numLabel2];


    
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
            [cell.contentView addSubview:_OneAndOneLabel];
            [cell.contentView addSubview:oneMan];
            [cell.contentView addSubview:_Man];
            [cell.contentView addSubview:oneChild];
            [cell.contentView addSubview:_Child];
            [cell.contentView addSubview:view];
            [cell.contentView addSubview:view2];
            
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
