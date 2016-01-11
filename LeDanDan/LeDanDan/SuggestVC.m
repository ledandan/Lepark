//
//  SuggestVC.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/5.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "SuggestVC.h"
#define kBGColor   [UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
@interface SuggestVC ()
{
    UILabel *pLabel;
    UITextField *cellnumberTV;
    UITextView *suggestTV;
}

@end

@implementation SuggestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"反馈";
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStyleDone target:self action:@selector(back)];
  // [ [UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1]];
     self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submit)];
    
    UIButton *suggestBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    suggestBtn.frame = CGRectMake(15, 250,( self.view.frame.size.width)-30, 40);
    
    [self config];
}
-(void)config
{
    
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    
    suggestTV=[[UITextView alloc]initWithFrame:CGRectMake(0, 15, self.view.frame.size.width, 120)];
    // suggestTV.backgroundColor=[UIColor redColor];
    suggestTV.backgroundColor=[UIColor whiteColor];
    suggestTV.font = [UIFont systemFontOfSize:14];
    
    suggestTV.delegate =self;
    //  suggestTV.placeholder =@"写一下你的建议与反馈，我们会努力改进";
    suggestTV.multipleTouchEnabled = YES;
    [self.view addSubview:suggestTV];
    
    pLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 300, 10)];
    pLabel.text = @"  写一下您的建议与反馈，我们会努力改进";
    pLabel.font = [UIFont systemFontOfSize:14];
    pLabel.textColor = [UIColor lightGrayColor];
    [suggestTV addSubview:pLabel];
    
    cellnumberTV=[[UITextField alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 40)];
    cellnumberTV.backgroundColor=[UIColor whiteColor];
    cellnumberTV.placeholder=@"  请填写您的手机号码,方便我们回复您";
    cellnumberTV.font=[UIFont systemFontOfSize:14];
    cellnumberTV.delegate = self;
    [self.view addSubview:cellnumberTV];
   
    
}

-(void)submit
{
    //{“phone”:”1”,” content”:”asdfasdf” }
    NSDictionary *dic = @{@"phone":cellnumberTV.text,@"content":suggestTV.text};
    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:kSuggest succeed:^(id success){
        NSLog(@"%@",success);
    }failed:^(id error){
        
    }];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    pLabel.text =@"";
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSCharacterSet *cs;
    
    cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if(!basicTest)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请输入数字"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        
        [alert show];
        
        return NO;
        
    }
    
    //其他的类型不需要检测，直接写入
    return YES;
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
