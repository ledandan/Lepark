//
//  MineVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/2.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "MineVC.h"
#import "OrderVC.h"
#import "CollectionVC.h"
#import "TravleVC.h"
#import "SuggestVC.h"
#import "LoginViewController.h"
#import "AboutLddViewController.h"
#import "MyInformationViewController.h"
#import "InviteForGiftViewController.h"
@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_titleArray;
    
    NSDictionary *_userInfoDictionary;
    
    NSString *_status;  //身份是否验证
    NSString *_id;     //用户 id
    NSString *_phone;   //用户手机
    NSString *_invitationCode;  //邀请码
    NSString *_lddNo;  //乐蛋蛋 id
    NSString *_logo;   //用户头像
}

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //
    [self.navigationController setNavigationBarHidden:YES animated:YES];
   
    _titleArray=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];

}

- (void) viewWillAppear:(BOOL)animated
{
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(l) name:@"islogin" object:nil];
    
    _userInfoDictionary = nil;
    _userInfoDictionary = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginUserInfo];
    if (_userInfoDictionary != nil) {
        _isLogin = YES;
    }
    
    [self addAllData];
    
    [self createTB];
    
}


-(void)addAllData
{
    _phone = [_userInfoDictionary objectForKey:@"phone"];
}

//退出登录

-(void)logout
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:kLastLoginUserInfo];
    
    [defaults synchronize];
    
    _phone = nil;
    
    _isLogin = NO;
    [self.view removeAllSubviews];
    
    [self createTB];
}
-(void)createTB
{
    
    //大图
    UIView *view=[[UIImageView alloc]initWithFrame:CGRectMake(0,0, self.view.frame.size.width, 180)];
    UIImageView *imageview= [[UIImageView alloc]init];
    imageview.frame = view.frame;
    imageview.image = [UIImage imageNamed:@"Minebg@2x"];
    //imageview.alpha = 0.5;
    [self.view addSubview:view];
    [view addSubview:imageview];
    
    //添加毛玻璃
    UIVisualEffect *blurEffect;
    blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView;
    visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [visualEffectView setFrame:view.bounds];
    // [view addSubview:visualEffectView];
    
    //头像
    UIImageView *iconImage= [[UIImageView alloc]init];
    iconImage.frame = CGRectMake(0, 0, 60, 60);
    if (!_userInfoDictionary) {
         iconImage.image = [UIImage imageNamed:@"userhead@2x"];
    }
    else
    {
        [iconImage sd_setImageWithURL:[NSURL URLWithString:[_userInfoDictionary objectForKey:@"logo"]]];
    }
    iconImage.centerX = view.centerX;
    iconImage.centerY = view.centerY;
    iconImage.layer.cornerRadius = iconImage.width/2;
    [view addSubview:iconImage];
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    iconBtn.layer.cornerRadius = iconBtn.width/2;
    iconBtn.frame = iconImage.frame ;
    //iconBtn.backgroundColor = [UIColor redColor];
    [iconBtn addTarget:self action:@selector(headClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconBtn];
    
    //名字
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(0, 0, 200, 20);
    nameLabel.centerX = imageview.centerX;
    nameLabel.y = iconImage.bottom +10;
    
    if (_phone == nil) {
        nameLabel.text = @"未登录,点击头像登录";
    }
    else
    {
        nameLabel.text = _phone;
    }
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    nameLabel.textAlignment = 1;
    nameLabel.textColor = [UIColor whiteColor];
    [view addSubview:nameLabel];
    
    
    _tableView =[[UITableView alloc]initWithFrame:CGRectMake(0,180, self.view.frame.size.width, self.view.frame.size.height - 180 - 49) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    //[_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    //[_tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    _tableView.scrollEnabled = YES;
    [self.view  addSubview:_tableView];
    
    
}

//点击头像
-(void)headClick
{
    if (_isLogin == YES) {
        
        NSLog(@"已经登录");
        [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[MyInformationViewController new]] animated:YES completion:nil];
    }
    else
    {
        NSLog(@"头像点击");
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        [self presentViewController:nav animated:YES completion:nil];
    }
    
}


#pragma mark  ------- tableViewDelegate ---------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //   NSLog(@"计算每组(组%li)行数",(long)section);
    
    return _titleArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    //NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    
    if (indexPath.row == 3|| indexPath.row == 7) {
        cell.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        cell.userInteractionEnabled = NO;
    }
else
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, cell.textLabel.frame.origin.y, [UIImage imageNamed:@"getin@2x"].size.width, [UIImage imageNamed:@"getin@2x"].size.height)];
    imageView.image = [UIImage imageNamed:@"getin@2x"];
    imageView.center = CGPointMake(cell.frame.size.width - cell.frame.size.height/2 +40, 25);
    imageView.frame= CGRectMake(self.view.frame.size.width - 50, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    [cell.contentView addSubview:imageView];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(10,10, 50, 50)];
  //  UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 152)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    switch (indexPath.row) {

            case 0:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"order@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"我的订单";
            label.center = CGPointMake(label.center.x, 25);
            break;
            
            case 1:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"mine_collection@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"我的收藏";
            label.center = CGPointMake(label.center.x, 25);
            break;
            
            case 2:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"discount@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"优惠劵";
            label.center = CGPointMake(label.center.x, 25);
            break;
            
            case 4:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"travle@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"身份验证";
            label.center = CGPointMake(label.center.x, 25);
            break;
            
            case 8:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"suggest@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"意见反馈";
            label.center = CGPointMake(label.center.x, 25);
            break;
            
            case 6:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"about@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"关于乐蛋蛋";
            label.center = CGPointMake(label.center.x, 25);
            break;
            
            case 5:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"exit@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"邀请有礼";
            label.center = CGPointMake(label.center.x, 25);
            break;
            
        case 9:
            [cell.contentView addSubview:imageView];
            imageView.center = CGPointMake(30, 25);
            imageView.bounds =CGRectMake(0, 0, 25, 25);
            imageView.image = [UIImage imageNamed:@"exit@2x"];
            
            [cell.contentView addSubview:label];
            label.frame = CGRectMake(imageView.frame.origin.x + imageView.frame.size.width +10, 10, 100, 25);
            label.text = @"退出";
            cell.contentView.backgroundColor = [UIColor whiteColor];
            label.center = CGPointMake(label.center.x, 25);
            break;
            
        default:
            break;
    }
    


    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return cell;


}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        return 15;
    }
    if (indexPath.row==7) {
        return 15;
        
    }
    if (indexPath.row==9) {
        return 47
        ;
    }
    
    return 47
    ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginUserInfo];
    
    NSLog(@"%@",userDic);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        //我的订单
        case 0:
            if (YES) {
                
                if (userDic) {
                    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[OrderVC new]];
                    [self presentViewController:nav animated:YES completion:nil];

                }
                else{
                    [[YZXNetworking shared] showHint:@"您还未登录"];
                }
                
                
            }

            break;
        //我的收藏
            case 1:
            
            if (userDic) {
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:[CollectionVC new]];
                [self presentViewController:nav animated:YES completion:nil];
            }
            else{
                [[YZXNetworking shared] showHint:@"您还未登录"];
            }
            break;
        //优惠券
            case 2:
            
            break;
        //邀请有礼
        case 5:
            NSLog(@"213123");
            if (YES) {
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:[InviteForGiftViewController new]];
                [self presentViewController:nav animated:YES completion:nil];

            }
            
        break;
            
        //出行人
        case 4:
            if (YES) {
                
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:[TravleVC new]];
                [self presentViewController:nav animated:YES completion:nil];
            }
          
        break;
        //意见反馈
        case 8:
            if (YES) {
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:[SuggestVC new]];
                [self presentViewController:nav animated:YES completion:nil];
            }
            break;
            
            //关于
            case 6:
            
            if (YES) {
                UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:[AboutLddViewController new]];
                [self presentViewController:nav animated:YES completion:nil];
            }
            break;
            //退出
         case 9:
            
            [self logout];
        break;
        default:
            break;
    }
    
}

-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
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
