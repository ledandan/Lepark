//
//  NTViewController.m
//  LeDanDan
//
//  Created by 辫子 on 15/10/27.
//  Copyright (c) 2015年 herryhan. All rights reserved.
//

#import "NTViewController.h"
#import "NTButton.h"
#import "HomeVC.h"
#import "MessageVC.h"
#import "MineVC.h"



@interface NTViewController ()
{
    UIImageView *_tabBarview;
    NTButton *_previousBtn;//先前的按钮
}

@end

@implementation NTViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //wsq
    for (UIView* obj in self.tabBar.subviews) {
        if (obj != _tabBarview) {//_tabBarView 应该单独封装。
            [obj removeFromSuperview];
        }
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabBarview=[[UIImageView alloc]initWithFrame:self.tabBar.bounds];
    _tabBarview.userInteractionEnabled=YES;
    _tabBarview.backgroundColor=[UIColor whiteColor];
    [self.tabBar addSubview:_tabBarview];
    HomeVC *first=[[HomeVC alloc]init];
    first.delegate=self;
    //
    UINavigationController *navi1=[[UINavigationController alloc]initWithRootViewController:first];
    MessageVC *second=[[MessageVC alloc]init];
    UINavigationController *navi2=[[UINavigationController alloc]initWithRootViewController:second];
    MineVC *third=[[MineVC alloc]init];
    UINavigationController *navi3=[[UINavigationController alloc]initWithRootViewController:third];
    self.viewControllers=[NSArray arrayWithObjects:navi1,navi2,navi3, nil];
    //
    [self creatBUttonWithNormalName:@"happy_notselect@2x" andSelectName:@"happy_slelect@2x" andTitle:@"乐蛋蛋" andIndex:0];
    [self creatBUttonWithNormalName:@"message_notselect@2x" andSelectName:@"message_select@2x" andTitle:@"消息" andIndex:1];
    [self creatBUttonWithNormalName:@"mine_notselect@2x" andSelectName:@"mine_select@2x" andTitle:@"我的" andIndex:2];
//    navi1.navigationBar.barStyle=UIBarStyleBlack;
//    navi2.navigationBar.barStyle=UIBarStyleBlack;
//    navi3.navigationBar.barStyle=UIBarStyleBlack;
    
    //
    [navi1.navigationBar setBarTintColor:[UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1]];
    [navi2.navigationBar setBarTintColor:[UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1]];
   // [navi3.navigationBar setBarTintColor:[UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1]];
    
    //
    
    
    
    
    NTButton * button = _tabBarview.subviews[0];
    [self changeViewController:button];
}
#pragma mark 创建一个按钮
-(void)creatBUttonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index{
    NTButton *customButton=[NTButton buttonWithType:UIButtonTypeCustom];
    customButton.tag=index;
    CGFloat buttonW=_tabBarview.frame.size.width/3;
    CGFloat buttonH=_tabBarview.frame.size.height;
    
    customButton.frame=CGRectMake(_tabBarview.frame.size.width/3*index, 0, buttonW, buttonH);
    [customButton setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [customButton  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //设置选中状态的图片
    [customButton setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [customButton setTitle:title forState:UIControlStateNormal];
   [customButton  setTitleColor:[UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1.0] forState: UIControlStateSelected];//?
    
    [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
    
    customButton.imageView.contentMode = UIViewContentModeCenter;
    customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    customButton.titleLabel.font = [UIFont systemFontOfSize:10];
    
    
    [_tabBarview addSubview:customButton];
    
    if(index == 0)//设置第一个选择项。
    {
        _previousBtn = customButton;
        _previousBtn.selected =YES;
    }
}
#pragma mark 按钮被点击时
-(void)changeViewController:(NTButton *)sender
{
    if(self.selectedIndex != sender.tag){ //wsq®
        self.selectedIndex = sender.tag; //切换不同控制器的界面
        _previousBtn.selected = ! _previousBtn.selected;
        _previousBtn = sender;
        _previousBtn.selected = YES;
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
