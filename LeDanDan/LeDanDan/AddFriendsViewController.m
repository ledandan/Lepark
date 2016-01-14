//
//  AddFriendsViewController.m
//  LeDanDan
//
//  Created by yzx on 16/1/12.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import "AddFriendsViewController.h"
#import "SearchFriendViewController.h"
#import "PhoneContractViewController.h"
@interface AddFriendsViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,IChatManagerDelegate,EMChatManagerBuddyDelegate>
{
    UISearchBar *_searchBar;
    
    UITableView *_newFriendTableView;
    
    UIVisualEffectView *_visualEfView;
    
    UILabel *newFriends;

}
@end

@implementation AddFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  
    
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    self.title = @"添加联系人";
    
    [self addAllController];
    
    NSLog(@"%@",_friendArr);
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
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 54)];
    _searchBar.placeholder = @"手机号";
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.tintColor = [UIColor whiteColor];
    _searchBar.backgroundImage = [[UIImage alloc]init];
    _searchBar.delegate = self;
    // [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
    [self.view addSubview:_searchBar];
    
    //手机联系人
    
    UIButton *phoneContacts =[UIButton buttonWithType:UIButtonTypeCustom];
    phoneContacts.frame = CGRectMake(0, _searchBar.bottom +5, kScreenWidth, 54);
    phoneContacts.backgroundColor = [UIColor whiteColor];
    [phoneContacts addTarget:self action:@selector(gotoPhoneContacts) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneContacts];
    
    //image
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(10, 8, 38, 38);
    imageView.image = [UIImage imageNamed:@"contact@2x"];
    imageView.backgroundColor = [UIColor clearColor];
    [phoneContacts addSubview:imageView];
    
    //手机联系人
    UILabel *labelContacts = [[UILabel alloc]initWithFrame:CGRectMake(imageView.right +5, 5, 100, 44)];
    labelContacts.text = @"手机联系人";
    labelContacts.textColor = [UIColor colorWithRed:0.34 green:0.34 blue:0.34 alpha:1];
    [phoneContacts addSubview:labelContacts];
    
    //箭头
    UIImageView *getin = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth - 50, 0, 24, 24)];
    getin.image = [UIImage imageNamed:@"getin@2x"];
    getin.centerY = labelContacts.centerY;
    [phoneContacts addSubview:getin];
    
    //新朋友
    newFriends = [[UILabel alloc]initWithFrame:CGRectMake(10, phoneContacts.bottom +15, kScreenWidth, 10)];
    newFriends.backgroundColor = [UIColor clearColor];
    newFriends.text = @"新的朋友";
    if (_friendArr.count != 0) {
        [self.view addSubview:newFriends];
    }
    
    //列表
    _newFriendTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, newFriends.bottom +15, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _newFriendTableView.delegate = self;
    _newFriendTableView.dataSource = self;
    [self.view addSubview:_newFriendTableView];
    
}

-(void)gotoPhoneContacts
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[PhoneContractViewController new]] animated:YES completion:nil];
    
}

-(void)addSearchFriendControl
{
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _searchBar.placeholder = @"手机号";
    _searchBar.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1];
    _searchBar.tintColor = [UIColor whiteColor];
    _searchBar.backgroundImage = [[UIImage alloc]init];
    _searchBar.delegate = self;
    // [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
    [_visualEfView addSubview:_searchBar];
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)onClick
{
   // [_searchBar endEditing:YES];
    self.navigationController.navigationBarHidden = NO;
    _visualEfView.hidden = YES;
}

//同意添加为好友
-(void)agree :(UIButton *)btn
{
    int i = btn.tag;
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager acceptBuddyRequest:_friendArr[i] error:&error];
    if (isSuccess && !error) {
        [[YZXNetworking shared] showHint:@"添加成功"];
        [_friendArr removeObject:_friendArr[i]];
        [_newFriendTableView reloadData];
        if (_friendArr.count == 0) {
            newFriends.hidden = YES;
        }
    }
}

#pragma mark ----------------_searchBar Delegate & 自定义 & 搜索判断---------


- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //开始搜索
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[SearchFriendViewController new]] animated:YES completion:nil];
}



- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //已经输入
}


#pragma mark -----------tableView delegate ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _friendArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.layer.borderWidth = 0.1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UIImageView *headImageView = [[UIImageView alloc]init];
    headImageView.frame = CGRectMake(10, 5, 40, 40);
    headImageView.image = [UIImage imageNamed:@"1"];
    [cell.contentView addSubview:headImageView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(headImageView.right +10 , 0, kScreenWidth, 50)];
    label.centerY = 25;
    label.text= _friendArr[indexPath.row];
    [cell.contentView addSubview:label];
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(kScreenWidth -60, 15, 45, 20);
    [addBtn addTarget:self action:@selector(agree:) forControlEvents:UIControlEventTouchUpInside];
    addBtn.tag = indexPath.row;
    [addBtn setTitle:@"添加" forState: UIControlStateNormal];
    addBtn.backgroundColor = [UIColor colorWithRed:0.95 green:0.51 blue:0.39 alpha:1];
    [addBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell.contentView addSubview:addBtn];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
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
