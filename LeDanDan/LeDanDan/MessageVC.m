//
//  MessageVC.m
//  LeDanDan
//
//  Created by yzx on 15/11/2.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "MessageVC.h"
#import "ChatViewController.h"
#import "ChatTableViewCell.h"

#import "ChineseString.h"
#import "AddFriendsViewController.h"

@interface MessageVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,EaseMessageViewControllerDataSource,EaseMessageViewControllerDelegate,EaseConversationListViewControllerDelegate,IChatManagerDelegate,EMChatManagerBuddyDelegate>
{
    UIImageView *lineImageView;
    UIView *topView;
    
    UISearchBar *searchBar;
    UITableView *_friendsTableView;
    
    UITableView *chatTableView;
    
    NSMutableArray *stringToSort;
    
    NSArray *conversations;
    
    NSArray *lastMessageArray;
    
    NSMutableArray *modelArr;
    
    NSMutableArray *timeArr;
    
    NSMutableArray *newFriendsArray;
    
}

@property(nonatomic,strong)NSArray *indexArray;
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@end

@implementation MessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    modelArr = [[NSMutableArray alloc]init];
    timeArr = [[NSMutableArray alloc]init];
    newFriendsArray = [[NSMutableArray alloc]init];
//    NSArray *stringsToSort=[NSArray arrayWithObjects:
//                            @"杨志祥",@"唾骂 ",@"托马斯",@"开心",
//                            @"不准笑",@"社区",@"开发者",@"传播",
//                            @"2哈哈",@"哈哈哈",@"100",@"中国",@"暑假作业",
//                            @"键盘", @"鼠标",@"hello",@"world",@"b1",
//                            nil];
//    
//    self.indexArray = [ChineseString IndexArray:stringsToSort];
//    self.letterResultArr = [ChineseString LetterSortArray:stringsToSort];
   
    
    [[EaseMob sharedInstance].chatManager asyncLoginWithUsername:@"yzx12101" password:@"123" completion:^(NSDictionary *loginInfo, EMError *error) {
        if (!error && loginInfo) {
             [self loadMessData];
            NSLog(@"登陆成功");
            //获取数据库中数据
            [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
            
            [[EaseMob sharedInstance].chatManager asyncFetchBuddyListWithCompletion:^(NSArray *buddyList, EMError *error) {
                if (!error) {
                    //   NSLog(@"获取成功 -- %@",buddyList[0]);
                    
                    stringToSort = [[NSMutableArray alloc]init];
                    for (int i = 0; i< buddyList.count; i++) {
                        // NSString *str = [buddyList[i] objectForKey:@"EMBuddy"];
                        EMBuddy *buddy = buddyList[i];
                        NSString *str = buddy.username;
                        [stringToSort addObject:str];
                    }
                    
                    // _indexArray = [NSArray arrayWithArray:buddyList];
                    //_indexArray = [NSArray arrayWithObjects:@"1",@"2",@"3",@"a",@"b",nil];
                self.indexArray = [ChineseString IndexArray:stringToSort];
                self.letterResultArr = [ChineseString LetterSortArray:stringToSort];
                 
                    [_friendsTableView reloadData];
                }
                else
                {
                    NSLog(@"%@",error);
                }
            } onQueue:nil];
        }
    } onQueue:nil];

    
    [[EaseMob sharedInstance].chatManager setIsAutoFetchBuddyList:YES];
    
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];

    [self addAllControl];
    
    [self addSearch];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
  
}

-(void)loadMessData
{
    
     [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
    
            
            NSLog(@"登陆成功");
            //获取数据库中数据
            [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
            
             conversations = [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];
            NSLog(@"conversations.count : %d",conversations.count);
            
            for (int i =0; i<conversations.count; i++) {
                NSLog(@"%@",conversations[i]);
                EMConversation *conversation = conversations[i];
                NSLog(@"conversation.chatter  :%@",conversation.chatter);
                EaseConversationModel  *model = [[EaseConversationModel alloc] initWithConversation:conversation];
                [modelArr addObject:model];
                EMMessage *lastMessage = [conversation latestMessage];
                NSString *date = [self timestampToDate:(double)lastMessage.timestamp];
                NSLog(@"date :%@",date);
                if (date == nil) {
                    date =@" ";
                }
                [timeArr addObject:date];
                
                
               
            }
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
    [addFriends addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:addFriends];
}

-(void)addFriend
{
 
    AddFriendsViewController *addFriend = [[AddFriendsViewController alloc]init];
    addFriend.friendArr = newFriendsArray;
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:addFriend] animated:YES completion:nil];
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:@"12102" message:@"我想加您为好友" error:&error];
    if (isSuccess && !error) {
        NSLog(@"添加成功");
    }
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
    
    chatTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, searchBar.bottom, kScreenWidth, kScreenHeight - searchBar.bottom  - 59) style:UITableViewStyleGrouped];
    chatTableView.delegate = self;
    chatTableView.dataSource = self;
    //chatTableView.hidden = YES;
    [chatTableView reloadData];
    [self.view addSubview:chatTableView];
    
//    EaseConversationListViewController *chatListVC = [[EaseConversationListViewController alloc] init];
//    chatListVC.delegate = self;
//    UIView *view = chatListVC.view;
//    [self.view addSubview:view];
}
//切换状态
-(void)changeStatus:(UIButton *)btn
{
    if (btn.tag == 8) {
        lineImageView.x = 10;
        //
        NSLog(@"消息");
        _friendsTableView.hidden = YES;
        chatTableView.hidden = NO;
    }
    else
    {
        lineImageView.x = 90;
        //好友
        NSLog(@"好友");
        _friendsTableView.hidden = NO;
        chatTableView.hidden = YES;
    }
}

//时间戳转时间的方法
- (NSString *) timestampToDate:(double)timestamp
{
    NSString *str;
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSinceReferenceDate:timestamp];

//    NSString *str = ;
//    NSString*string =[str sub];
    NSString *string = [NSString stringWithFormat:@"%@",confromTimesp];
    NSRange start = [string rangeOfString:@"-"];
    NSRange end = [string rangeOfString:@" "];
    NSString *month = [string substringWithRange:NSMakeRange(start.location +1, end.location-start.location)];
    NSLog(@"sub=%@",month);
    
    NSRange star = [string rangeOfString:@" "];
    NSRange en = [string rangeOfString:@" "];
    NSString *time1 = [string substringWithRange:NSMakeRange(star.location , en.location-star.location-1)];
    NSLog(@"sub=%@",time1);
    NSLog(@"sub=%@",confromTimesp);
    
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    
    NSString *dateTime = [dateFormatter stringFromDate:[NSDate date]];
    NSString *dateTime1 = [dateFormatter stringFromDate:confromTimesp];
    
    
    //创建了两个日期对象
    NSDate *date1= [dateFormatter dateFromString:dateTime];
    NSDate *date2=[dateFormatter dateFromString:dateTime1];
    //NSDate *date=[NSDate date];
    //NSString *curdate=[dateFormatter stringFromDate:date];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
   
    if (days >= 1) {
        str = month;
    }
    else
    {
        
    }
    return str;
}


-(NSString *)getLocalDateFormateUTCDate:(NSString *)utcDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate] ;
    return destinationDateNow;
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


#pragma mark -
#pragma mark - UITableViewDataSource

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (tableView == _friendsTableView) {
        return self.indexArray;
    }
    else
    {
        return nil;
    }
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView == _friendsTableView) {
        NSString *key = [self.indexArray objectAtIndex:section];
        return key;
    }
    else
    {
        return nil;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _friendsTableView) {
        return [self.indexArray count];
    }
    else
    {
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _friendsTableView) {
        return [[self.letterResultArr objectAtIndex:section] count];
    }
    else
    {
        return  [conversations count];;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _friendsTableView) {
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = [[self.letterResultArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
        return cell;
    }
    else{
        static NSString *cellID = @"cellID";
        
                ChatTableViewCell *cell= [tableView dequeueReusableCellWithIdentifier:cellID];
                if (cell == nil) {
                    // cell = [[[NSBundle mainBundle]loadNibNamed:@"ShopTableViewCell" owner:self options:nil] lastObject];
                    cell = [[ChatTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                    //获取数据库中数据
                    [[EaseMob sharedInstance].chatManager loadDataFromDatabase];
                  
                    
                    EaseConversationModel *model = modelArr[indexPath.row];
                    EMConversation *conversation =model.conversation;
                    
                    cell.chatter.text = conversation.chatter;
                    cell.timeLabel.text = timeArr[indexPath.row];
                    EMMessage *message = [conversation latestMessage];
                    NSLog(@"message  %@",message);

                    NSArray *arr = message.messageBodies;
                    EMTextMessageBody *body = arr[0];
        
                    cell.content.text = body.text;
        
        
                           }
                //cell.backgroundColor = [UIColor redColor];
                //cell.chatter.backgroundColor = [UIColor yellowColor];
                return cell;
    }
   
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

#pragma mark -
#pragma mark - UITableViewDelegate
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _friendsTableView) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
        lab.backgroundColor = self.view.backgroundColor;
        lab.text = [self.indexArray objectAtIndex:section];
        lab.textColor = [UIColor blackColor];
        return lab;
    }
    else
    {
        return nil;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _friendsTableView) {
        return 65.0;
    }
    else
    {
    return 65.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  0.0001;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _friendsTableView) {
        return 20;
    }
    else{
        return 0.000001;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
   
    ChatViewController *chatVC = [[ChatViewController alloc]initWithConversationChatter:stringToSort[indexPath.row] conversationType:eConversationTypeChat];
    
    chatVC.delegate = self;
    chatVC.dataSource = self;
    chatVC.title = stringToSort[indexPath.row];
    
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:chatVC] animated:YES completion:nil];
    
}

-(void)didReceiveMessage:(EMMessage *)message{
    // 消息中的扩展属性
    NSDictionary *ext = message.ext;
    NSLog(@"消息中的扩展属性是 -- %@",ext);
    
    [chatTableView removeFromSuperview];
    [self loadMessData];
}



- (void)didReceiveBuddyRequest:(NSString *)username
                       message:(NSString *)message
{
    [newFriendsArray addObject:username];
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
