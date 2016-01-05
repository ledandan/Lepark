//
//  MessageVC.m
//  LeDanDan
//
//  Created by yzx on 15/11/2.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "MessageVC.h"

@interface MessageVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    UIImageView *lineImageView;
    UIView *topView;
    
    UISearchBar *searchBar;
    UITableView *_friendsTableView;
}

@property(nonatomic,strong)NSMutableArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;
@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    
     _indexArray = [NSMutableArray arrayWithObjects:@"杨志祥",@"不在",@"你在哪",@"1",@"2",@"3",@"4",@"5",@"6",@"7", nil];
    [self addAllControl];
    
    [self addSearch];
    
    [self addTableView];
}

-(void)addAllControl
{
    topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
    topView.backgroundColor =  [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    [self.view addSubview:topView];
    
    //消息
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setTitle:@"消息" forState: UIControlStateNormal];
    messageBtn.frame = CGRectMake(10, 20, 70, 44);
    messageBtn.backgroundColor = [UIColor clearColor];
    messageBtn.tag = 8;
    [messageBtn addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:messageBtn];
    
    //好友
    UIButton *friendsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [friendsBtn setTitle:@"好友" forState: UIControlStateNormal];
    friendsBtn.frame = CGRectMake(messageBtn.right +10, 20, 70, 44);
    friendsBtn.backgroundColor = [UIColor clearColor];
    friendsBtn.tag = 9;
    [friendsBtn addTarget:self action:@selector(changeStatus:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:friendsBtn];
    
    //line
    lineImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, messageBtn.bottom - 2, 70, 2)];
    lineImageView.image = [UIImage imageNamed:@"line@2x"];
    [topView addSubview:lineImageView];
    
    
    //添加好友
    UIButton *addFriends = [UIButton buttonWithType:UIButtonTypeCustom];
    addFriends.frame =CGRectMake(kScreenWidth - 50, 25, 34, 34);
    [addFriends setImage:[UIImage imageNamed:@"add@2x"] forState:UIControlStateNormal];
    [topView addSubview:addFriends];
}

-(void)addSearch
{
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, topView.bottom, self.view.frame.size.width, 54)];
    searchBar.placeholder = @"搜索";
    searchBar.backgroundColor = [UIColor clearColor];
    searchBar.tintColor = [UIColor whiteColor];
    searchBar.backgroundImage = [[UIImage alloc]init];
    searchBar.delegate = self;
   // [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
    [self.view addSubview:searchBar];
    
}

-(void)addTableView
{
    _friendsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, searchBar.bottom, kScreenWidth, kScreenHeight - searchBar.bottom  - 59) style:UITableViewStyleGrouped];
    _friendsTableView.delegate = self;
    _friendsTableView.dataSource = self;
    _friendsTableView.hidden = YES;
    [self.view addSubview:_friendsTableView];
}
//切换状态
-(void)changeStatus:(UIButton *)btn
{
    if (btn.tag == 8) {
        lineImageView.x = 10;
        //
        NSLog(@"消息");
        _friendsTableView.hidden = YES;
    }
    else
    {
        lineImageView.x = 90;
        //好友
        NSLog(@"好友");
        _friendsTableView.hidden = NO;
    }
}


#pragma mark ----------------_searchBar Delegate & 自定义 & 搜索判断---------

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   //开始搜索
    
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    //开始输入
}

- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //已经输入
}


#pragma mark  ------- tableViewDelegate ---------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //   NSLog(@"计算每组(组%li)行数",(long)section);
    
    return 4;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSIndexPath是一个结构体，记录了组和行信息
    //NSLog(@"生成单元格(组：%li,行%li)",(long)indexPath.section,(long)indexPath.row);
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    
    cell.textLabel.text = @"才人";
    
    UIView *backView = [[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView = backView;
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return cell;
    
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  0.0001;
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    
    NSArray *indexList = [NSMutableArray arrayWithObjects:
                          @"A", @"B", @"C", @"D", @"E", @"F",
                          @"G", @"H", @"I", @"J", @"K", @"L",
                          @"M", @"N", @"O", @"P", @"Q", @"R",
                          @"S", @"T", @"U", @"V", @"W", @"X",
                          @"Y", @"Z", @"#", nil
                          ];
    return indexList; //返回26个字母
}


//响应点击索引时的委托方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    
    NSLog(@"asdasd");
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    NSString *key = [self.indexArray objectAtIndex:section];
    return key;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    lab.backgroundColor = self.view.backgroundColor;
    lab.text = [self.indexArray objectAtIndex:section];
    lab.textColor = [UIColor blackColor];
    return lab;
}


//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    //传入 section title 和index 返回其应该对应的session序号。
//    //一般不需要写 默认section index 顺序与section对应。除非 你的section index数量或者序列与section不同才用修改
//    return index;
//}

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
