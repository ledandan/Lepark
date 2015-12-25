//
//  PlayDetailViewController.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/5.
//  Copyright © 2015年 herryhan.     6ll rights reserved.
//

#import "PlayDetailViewController.h"
#import "AssTableViewCell.h"
#import <ShareSDK/ShareSDK.h>
#import "UIScrollView+TwitterCover.h"
#import "ApplyViewController.h"
#define kHexRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kNavigationBarColor kHexRGB(0x111923)
@interface PlayDetailViewController () <UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *_sv;
    
    UIView *_topView;
    UIView *_middleView;
    UIView *_bottomView;
    
    UITableView *_tableView;
    
    UIView *_bgView;
    
    UIView *_customView;
}
@end

@implementation PlayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addConfig];
    
    
    [self addTop];
    
    [self addBottom];
}

-(void)addConfig
{
    _sv = [[UIScrollView alloc]initWithFrame:self.view.frame];
//    _sv.delegate = self;
    [self.view addSubview:_sv];
    
    int i = 30.0/375.0 *kScreenWidth;
    //顶部
    _topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth - i)];
    NSLog(@"%f",kScreenWidth);
    if (kScreenWidth == 320) {
        _topView.height = _topView.height + 7;
    }
    _topView.backgroundColor = [UIColor whiteColor];
    [_sv addSubview:_topView];
    
    //分割
    UIView *div = [[UIView alloc]initWithFrame:CGRectMake(0, _topView.bottom, kScreenWidth, 10)];
    div.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [_sv addSubview:div];
    
    //中间
    _middleView = [[UIView alloc]init];
    _middleView.frame = CGRectMake(0, div.bottom, kScreenWidth, 100);
    [_sv addSubview:_middleView];
    
    NSArray *labelArr = [NSArray arrayWithObjects:@"时间: 10月18日",@"地点: 江场西路",@"要求:带上您的钱以及孩子",nil];
    for (int i = 0 ; i< 3; i++) {
        UIView *view = [[UIView alloc]init];
        view.frame = CGRectMake(-2, (100/3) * i, kScreenWidth +4, 100/3);
        view.backgroundColor = [UIColor whiteColor];
        [_middleView addSubview:view];
        if (i == 1) {
            view.layer.borderWidth = 0.5;
            view.layer.borderColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:0.5].CGColor;
        }
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, kScreenWidth, 100/3)];
        label.text = labelArr[i];
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:1];
        [view addSubview:label];
    }
    
    //分割
    UIView *div2 = [[UIView alloc]initWithFrame:CGRectMake(0, _middleView.bottom, kScreenWidth, 10)];
    div2.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    [_sv addSubview:div2];
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, div2.bottom, kScreenWidth, 35)];
    [_sv addSubview:_bottomView];
    
    NSArray *arr = [NSArray arrayWithObjects:@"活动详情",@"用户评价", nil];
    for (int i = 0; i< 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * (kScreenWidth/2), 0, kScreenWidth/2, 35);
        btn.tag = i;
        [btn setTitle:arr[i] forState: UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(changeSelect:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:btn];
    }
    
    //分割
    UIView *div3 = [[UIView alloc]initWithFrame:CGRectMake(0, _bottomView.bottom, kScreenWidth, 3)];
    div3.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
   // [_sv addSubview:div3];

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _bottomView.bottom, kScreenWidth, 10000) style:UITableViewStyleGrouped];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_sv addSubview:_tableView];
    _sv.contentSize = CGSizeMake(kScreenWidth, _bottomView.bottom + 1200 + 49); //49底部导航栏高度
}

//添加顶部
-(void)addTop
{
    
    UIImageView *playImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    playImage.backgroundColor = [UIColor redColor];
    playImage.image = [UIImage imageNamed:@"1"];
    playImage.height = 250.0/375.0 * kScreenWidth;

   // [_sv addTwitterCoverWithImage:[UIImage imageNamed:@"1"]];
    [_topView addSubview:playImage];
    
    //活动名称
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.frame = CGRectMake(5, playImage.bottom - 30, kScreenWidth - 10, 20);
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"小小地址学家启蒙课,关于地层的秘密";
    nameLabel.font = [UIFont boldSystemFontOfSize:15];
    [_topView addSubview:nameLabel];
    
    //人数
    UILabel *nunOfPeople = [[UILabel alloc]init];
    nunOfPeople.frame = CGRectMake(5, playImage.bottom +5, kScreenWidth, 10);
    nunOfPeople.text = @"10个小孩,20个大人";
    nunOfPeople.font = [UIFont systemFontOfSize:14];
    nunOfPeople.textColor = [UIColor grayColor];
    [_topView addSubview:nunOfPeople];
    
    //头像列表
    UIScrollView *headOfSv = [[UIScrollView alloc]init];
    headOfSv.frame = CGRectMake(5, nunOfPeople.bottom +5, kScreenWidth/2, 40);
    headOfSv.contentSize = CGSizeMake(1000, 50);
    headOfSv.showsHorizontalScrollIndicator = NO;
    headOfSv.showsHorizontalScrollIndicator = NO;
    [_topView addSubview:headOfSv];
    
    for (int i = 0; i< 100; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(40 * i +5, 5, 30, 30);
        btn.layer.cornerRadius = btn.width/2;
       [headOfSv addSubview:btn];
        
        UIImageView *headImage = [[UIImageView alloc]init];
        headImage.frame = CGRectMake(0, 0, 30, 30);
        headImage.layer.cornerRadius = headImage.width/2;
        headImage.image = [UIImage imageNamed:@"1"];
        headImage.backgroundColor = [UIColor yellowColor];
        headImage.layer.masksToBounds = YES;
        [btn addSubview:headImage];
       
    }

    //箭头
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(kScreenWidth - 30, 0, 20, 20);
    imageView.centerY = headOfSv.centerY;
    imageView.image = [UIImage imageNamed:@"getin@2x"];
    [_topView addSubview:imageView];
    
    
    //分割
    
    UIView *view = [[UIView alloc]initWithFrame: CGRectMake(0, headOfSv.bottom, kScreenWidth, 1)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.alpha = 0.5;
    [_topView addSubview:view];
    
    //活动报名状态
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(5, view.bottom + 5, kScreenWidth/2, 20.0/375.0 *kScreenWidth)];
    label.text = @"活动报名中";
    label.font = [UIFont systemFontOfSize:15];
    [_topView addSubview:label];
    
    
    //价格
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(kScreenWidth - 100, view.bottom + 5, 1000, 20.0/375.0 *kScreenWidth)];
    price.text = @"12131元起";
    price.font = [UIFont systemFontOfSize:15];
    price.textColor = [UIColor redColor];
    [_topView addSubview:price];
    
    //顶部返回和分享
    _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    _bgView.backgroundColor = kNavigationBarColor;
    _bgView.alpha = 0.3;
    [self.view addSubview:_bgView];
    
    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    back.frame = CGRectMake(10, 0, 30, 30);
    [back setCenter:CGPointMake(32.0, 40.0)];
    back.centerY = _bgView.centerY;
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    
    UIImageView *backImageView = [[UIImageView alloc]init];
    backImageView.frame = CGRectMake(0, 0, 30, 30);
    [backImageView setCenter:CGPointMake(32.0, 40.0)];
    backImageView.image = [UIImage imageNamed:@"bg_back@2x"];
    [self.view addSubview:backImageView];
    
    
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake(kScreenWidth-15-30, 26, 30, 30);
    share.centerY = _bgView.centerY;
    [share addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:share];
    
    UIImageView *shareImageView = [[UIImageView alloc]init];
    shareImageView.frame = CGRectMake(kScreenWidth-15-30, 26, 30, 30);
    shareImageView.image = [UIImage imageNamed:@"share@2x"];
    [self.view addSubview:shareImageView];
}

-(void)changeSelect:(UIButton *)btn
{
    if (btn.tag == 0) {
        NSLog(@"活动详情");
        _tableView.hidden = YES;
    }
    else
    {
        NSLog(@"评价");
        _tableView.hidden = NO;
    }
}

-(void)addBottom
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bottom - 50, kScreenWidth, 50)];
    view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    [self.view addSubview:view];
    
    //立即报名
    UIButton *apply = [UIButton buttonWithType:UIButtonTypeCustom];
    apply.frame = CGRectMake(kScreenWidth - 120, 0, 120, 50);
    [apply setTitle:@"立即报名" forState: UIControlStateNormal];
    apply.backgroundColor = [UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1];
    [apply addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:apply];
    
    NSArray *imageArr = [NSArray arrayWithObjects:@"telephone@2x",@"organization@2x",@"collection@2x", nil];
    NSArray *titltArr = [NSArray arrayWithObjects:@"电话",@"组织方",@"收藏", nil];
    for (int i = 0; i < 3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(10 + i * (kScreenWidth - view.x - 100)/3, 0, 50, 50);
        //btn.backgroundColor = [UIColor redColor];
        [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1001+i;
        [view addSubview:btn];
        
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(15/2, 0, 35, 35)];
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [btn addSubview:imageView];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageView.bottom, btn.width, 15)];
        label.text = titltArr[i];
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = UITextAlignmentCenter;
       // label.backgroundColor = [UIColor yellowColor];
        [btn addSubview:label];
        }
    
}


-(void)back
{
   
    [self dismissModalViewControllerAnimated:YES];
}

-(void)btnPress:(UIButton*)btn
{
    if (btn.tag == 1001) {
        NSLog(@"打电话");
        
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"18626238757"];
        //            NSLog(@"str======%@",str);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

    }
    else if (btn.tag == 1001 +1)
    {
        NSLog(@"组织方");
    }
    else
    {
        NSLog(@"收藏");
    }
}


-(void)share
{
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"ShareSDK" ofType:@"png"];
    
    //构造分享内容
    id<ISSContent> publishContent = [ShareSDK content:@"分享内容"
                                       defaultContent:@"测试一下"
                                                image:[ShareSDK imageWithPath:imagePath]
                                                title:@"ShareSDK"
                                                  url:@"http://www.mob.com"
                                          description:@"这是一条测试信息"
                                            mediaType:SSPublishContentMediaTypeNews];
    //创建弹出菜单容器
    id<ISSContainer> container = [ShareSDK container];
    //[container setIPadContainerWithView:sender arrowDirect:UIPopoverArrowDirectionUp];
    
    //弹出分享菜单
    [ShareSDK showShareActionSheet:container
                         shareList:nil
                           content:publishContent
                     statusBarTips:YES
                       authOptions:nil
                      shareOptions:nil
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSResponseStateSuccess)
                                {
                                    NSLog(@"分享成功");
                                }
                                else if (state == SSResponseStateFail)
                                {
                                    NSLog(@"分享失败,错误码:%ld,错误描述:%@", [error errorCode], [error errorDescription]);
                                }
                            }];

}

//立即报名
-(void)apply :(UIButton *)btn
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[ApplyViewController new]] animated:YES completion:nil];
}

#pragma mark  -----------tableView --------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"计算分组数");
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"计算每组(组%li)行数",(long)section);
    
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    static NSString *cellID = @"cellID";
    
    AssTableViewCell*cell= [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
         cell = [[[NSBundle mainBundle]loadNibNamed:@"AssTableViewCell" owner:self options:nil] lastObject];
        //cell = [[AssTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    
    cell.userHead.layer.cornerRadius = cell.userHead.width/2;
    cell.userHead.layer.masksToBounds = YES;
   
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}



- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat percent ;
    percent = scrollView.contentOffset.y / kScreenHeight;
    NSLog(@"percent :%f",percent);
    //_bgView.alpha = 1;
    if (percent != 0) {
        _bgView.alpha = percent;
    }
    else if (percent == 0)
    {
        _bgView.alpha =0.3;
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
