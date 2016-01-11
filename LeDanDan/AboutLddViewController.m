//
//  AboutLddViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/9.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "AboutLddViewController.h"

@interface AboutLddViewController ()
{
    NSString *aboutMe;  //主题内容
    NSString *logo;   //图标url
    NSString *aboutV;  //版本
    NSString *aboutG;  //公司名称
    NSString *aboutX;   //许可证
}

@end

@implementation AboutLddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"关于";
    [self addData];
    
    
}


-(void)addData
{
    [[YZXNetworking shared] requesUpdateInfoRequestdict:nil withurl:kAbout succeed:^(id success){
        
        NSLog(@"%@",success);
        
        aboutMe = [[success objectForKey:@"result"] objectForKey:@"aboutMe"];
        logo = [[success objectForKey:@"result"] objectForKey:@"logo"];
        aboutV = [[success objectForKey:@"result"] objectForKey:@"aboutV"];
        aboutG = [[success objectForKey:@"result"] objectForKey:@"aboutG"];
        aboutX = [[success objectForKey:@"result"] objectForKey:@"aboutX"];
        
        [self addControl];
    }failed:^(id error)
     {
         
     }];
}

-(void)addControl
{
    //logo
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 120, 70, 70);
    imageView.centerX = kScreenWidth/2;
    [imageView sd_setImageWithURL:[NSURL URLWithString:logo]];
    NSLog(@"%@",[NSURL URLWithString:logo]);
    [self.view addSubview:imageView];
    
    NSString *Version =  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    // 版本号
    UILabel *label = [[UILabel alloc]init];
    label.frame= CGRectMake(0, imageView.bottom +8, 150, 20);
    label.text = [NSString stringWithFormat:@"乐蛋蛋 V%@",aboutV];
    label.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    label.centerX = kScreenWidth/2;
    label.font = [UIFont systemFontOfSize:19];
    label.textAlignment = UITextAlignmentCenter;
    [self.view addSubview:label];
    
    
    //介绍

    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(20, label.bottom +20, kScreenWidth - 40, 100)];
    [label1 setTextColor:[UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1]];
    [label1 setNumberOfLines:0];
    
    NSString *labelText = @"乐蛋蛋是一款亲子活动类软件,旨在帮助家长孩子找到有趣、好玩、合适、丰富多彩的活动，让孩子家长体验乐在其中。";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:aboutMe];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label1.attributedText = attributedString;
    label1.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:label1];
    
    //公司
    UILabel *coLabel = [[UILabel alloc]init];
    coLabel.frame = CGRectMake(0, kScreenHeight - 80, kScreenWidth, 20);
    coLabel.text = aboutG;
    coLabel.centerX = kScreenWidth/2;
    coLabel.textAlignment = UITextAlignmentCenter;
    coLabel.textColor = [UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    coLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:coLabel];
    
    //版权
    UILabel *copyRight = [[UILabel alloc]init];
    copyRight.frame = CGRectMake(0, coLabel.bottom +3, kScreenWidth, 20);
    copyRight.text = aboutX;
    copyRight.textAlignment = UITextAlignmentCenter;
    copyRight.font = [UIFont systemFontOfSize:15];
    copyRight.textColor =[UIColor colorWithRed:0.51 green:0.51 blue:0.51 alpha:1];
    [self.view addSubview:copyRight];
    
};


- (void) viewWillAppear:(BOOL)animated
{
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
    
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
