//
//  SearchFriendViewController.m
//  LeDanDan
//
//  Created by yzx on 16/1/12.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import "SearchFriendViewController.h"
#import "MBProgressHUD.h"

@interface SearchFriendViewController ()<UISearchBarDelegate,UIAlertViewDelegate>
{
    UISearchBar *_searchBar;
}
@end

@implementation SearchFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(40, -10, self.view.frame.size.width-50, 64)];
    _searchBar.backgroundColor = [UIColor clearColor];
    _searchBar.tintColor = [UIColor whiteColor];
    _searchBar.backgroundImage = [[UIImage alloc]init];
    _searchBar.delegate = self;
    [_searchBar becomeFirstResponder];
    _searchBar.returnKeyType = UIReturnKeySearch;
    // [[searchBar.subviews objectAtIndex:0]removeFromSuperview];
    [self.navigationController.navigationBar addSubview:_searchBar];
    
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

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar

{
    NSString *str = [NSString stringWithFormat:@"您想添加%@为好友",_searchBar.text];
    
    UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"添加好友" message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    alertview.delegate = self;
    [alertview show];
    
}
-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0)
{
    EMError *error = nil;
    BOOL isSuccess = [[EaseMob sharedInstance].chatManager addBuddy:_searchBar.text message:@"我想加您为好友" error:&error];
    if (isSuccess && !error) {
        
        [self showHint:@"申请发送成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showHint:(NSString *)hint
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}
- (void)didRejectedByBuddy:(NSString *)username
{
    NSLog(@"12312");
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
