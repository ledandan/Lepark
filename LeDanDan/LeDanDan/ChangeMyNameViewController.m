//
//  ChangeMyNameViewController.m
//  
//
//  Created by yzx on 15/12/24.
//
//

#import "ChangeMyNameViewController.h"
#import "YZXNetworkHelper.h"
@interface ChangeMyNameViewController ()<UITextFieldDelegate>
{
    UITextField *_textField;
}
@end

@implementation ChangeMyNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"昵称";
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(resetName)];
    [rightButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                         [UIFont fontWithName:@"Helvetica"size:18],NSFontAttributeName,
                                         [UIColor whiteColor],NSForegroundColorAttributeName,
                                         nil]
                               forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    float systemVersion = [[[UIDevice currentDevice]systemVersion] floatValue];
    if (systemVersion >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.automaticallyAdjustsScrollViewInsets = NO;
        
    }
    [self addAllControl];
}


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
    
    
    //[selectedViewController viewWillAppear:animated];
}

-(void)addAllControl
{
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 30, kScreenWidth, 50)];
    _textField.delegate =self;
    _textField.clearsOnBeginEditing = YES;
    _textField.clearButtonMode = UITextFieldViewModeAlways;
    _textField.placeholder =[NSString stringWithFormat:@"   %@",_name];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _textField.layer.borderWidth = 0.5;
    [self.view addSubview:_textField];
    
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//保存
-(void)resetName
{
    
    NSDictionary *dic =@{@"userPhone":@"18001670539",@"type":@"2",@"value":_textField.text};

    
    [[YZXNetworkHelper shared] apiPost:@"http://120.26.212.55:8080/incidentally/api/userInfoUpdate/getUserInfoUpdate.html" parameters:dic success:^(id success){
        
        NSLog(@"%@",success);
    }failure:^(id error)
     {
         NSLog(@"%@",error);
         
     }];
}

#pragma mark  -------TextFieldDelegate -------- 

- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [self editingRectForBounds:bounds];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0,0, 0,10);
    return UIEdgeInsetsInsetRect(rect, insets);
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
