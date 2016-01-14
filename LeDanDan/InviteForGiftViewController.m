//
//  InviteForGiftViewController.m
//  LeDanDan
//
//  Created by yzx on 16/1/13.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import "InviteForGiftViewController.h"

@interface InviteForGiftViewController ()

@end

@implementation InviteForGiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"邀请有礼";
    
    [self addAllController];
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

-(void)addAllController
{
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:self.view.frame];
    bgView.image = [UIImage imageNamed:@"invateBg@2x"];
    [self.view addSubview:bgView];
    
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 0, 0)];
    imageView.image = [UIImage imageNamed:@"discountOfMoney@2x"];
    imageView.width = imageView.image.size.width;
    imageView.height = imageView.image.size.height;
    imageView.centerX = kScreenWidth /2;
    [self.view addSubview:imageView];
    
    
    UIButton *inviteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    inviteBtn.frame = CGRectMake(30, imageView.bottom +60, kScreenWidth - 60, 50);
    [inviteBtn setImage:[UIImage imageNamed:@"button@2x"] forState:UIControlStateNormal];
    [self.view addSubview:inviteBtn];
    
    
    UILabel *inviteLabel = [[UILabel alloc]initWithFrame:inviteBtn.frame];
    inviteLabel.text = @"邀请有礼";
    inviteLabel.font = [UIFont boldSystemFontOfSize:19];
    inviteLabel.x = 0;
    inviteLabel.y = 0;
    inviteLabel.textAlignment = NSTextAlignmentCenter;
    inviteLabel.textColor = [UIColor whiteColor];
    [inviteBtn addSubview:inviteLabel];
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
