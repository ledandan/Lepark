//
//  MyInformationViewController.m
//  LeDanDan
//
//  Created by yzx on 15/12/16.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "MyInformationViewController.h"
#import "ChangeMyNameViewController.h"
#import "ChangePhoneViewController.h"
#import "MSDatePicker.h"
#import "ChangePasswordViewController.h"
@interface MyInformationViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,MSDatePickerDelegate>
{
    NSArray *count;
    UITableView *_tableView;
    UIButton *_headImage;
    
    
    NSString *name;
    NSString *gender;
    
    UIActionSheet *_genderChoiceAciotnSheet;
    
    //生日
    NSString *_dateString;
    
    //点的第几个 cell
    NSString *index;
    
    //孩子数量
    NSString *numOfChild;
    
    NSDictionary *_userInfoDictionary;
    
    NSString *_status;  //身份是否验证
    NSString *_id;     //用户 id
    NSString *_phone;   //用户手机
    NSString *_invitationCode;  //邀请码
    NSString *_lddNo;  //乐蛋蛋 id
    NSString *_logo;   //用户头像

    
}
@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    if (gender == nil) {
        gender = @"男";
    }
    
    
    count = [NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
    
    [self addData];
    
    [self addController];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    
    [self dismissModalViewControllerAnimated:YES];
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
    
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(l) name:@"islogin" object:nil];
    
    _userInfoDictionary = nil;
    _userInfoDictionary = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginUserInfo];
    if (_userInfoDictionary != nil) {
        
    }
    [super viewWillAppear:animated];
    //[selectedViewController viewWillAppear:animated];
}


-(void)addData
{

}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)addController
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.view addSubview:_tableView];
    
    //头像
    // _headImage = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    _headImage = [UIButton buttonWithType:UIButtonTypeCustom];
    _headImage.frame = CGRectMake(0, 0, 30, 30);
    // _headImage.image = [UIImage imageNamed:@"userhead@2x"];
    [_headImage setImage:[UIImage imageNamed:@"userhead@2x"] forState:UIControlStateNormal];
    _headImage.x = kScreenWidth - 60-[UIImage imageNamed:@"getin@2x"].size.width;
    _headImage.layer.cornerRadius = 15;
    _headImage.layer.masksToBounds = YES;
    //_headImage.image = [UIImage imageNamed:@"1"];
    _headImage.centerY = 30;
}

-(void)takePictureClick
{
    UIActionSheet* actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"请选择文件来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"照相机",@"本地相簿",nil];
    [actionSheet showInView:self.view];
}

- (void) changeGender
{
    _genderChoiceAciotnSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:@"男"
                                                  otherButtonTitles:@"女", nil];
    
    [_genderChoiceAciotnSheet showInView:self.view];
}

-(void)changeBirthday:(int) i
{
    NSDate *theDate = [NSDate date];
    //NSString *birthdayString = [_userInfoDictionary objectForKey:@"birth"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    //theDate = [dateFormatter dateFromString:birthdayString];
    
    MSDatePicker *datePicker = [[MSDatePicker alloc] initwithYMDDatePickerDelegate:self withMinimumDate:@"1900-01-01" withMaximumDate:[NSDate date] withNowDate:theDate];
    [datePicker showInView:self.view];
    
}

-(void)changeNumOfChild
{
    
}

-(void)setPassword
{
    [self presentViewController:[[UINavigationController alloc]initWithRootViewController:[ChangePasswordViewController new]] animated:YES completion:nil];
}

//上次数据
-(void)post :(NSString *)str
{
    NSDictionary *dic =@{@"userPhone":@"186",@"type":index,@"value":str};
    
    NSLog(@"%@ , %@",index,str);
    
    [[YZXNetworking shared] requesUpdateInfoRequestdict:dic withurl:@"http://120.26.212.55:8080/incidentally/api/userInfoUpdate/getUserInfoUpdate.html" succeed:^(id success){
        
        NSLog(@"%@",success);
        
    }failed:^(id error){
        
        
    }];
}

#pragma mark ---------------- MSDatePickerDelegate回调 -----------------
- (void) checkOneDate:(NSDate *)theDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:timeZone];
    
    _dateString = [dateFormatter stringFromDate:theDate];
    [_tableView reloadData];
    
    [self post:_dateString];
}

#pragma mark --------- tableViewdelgate ------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return count.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.layer.borderWidth = 0.1;
    cell.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 50)];
    label.centerY = cell.centerY;
    
    [cell.contentView addSubview:label];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, cell.textLabel.frame.origin.y, [UIImage imageNamed:@"getin@2x"].size.width, [UIImage imageNamed:@"getin@2x"].size.height)];
    imageView.image = [UIImage imageNamed:@"getin@2x"];
    imageView.center = CGPointMake(cell.frame.size.width - cell.frame.size.height/2 +40, 30);
    imageView.frame= CGRectMake(self.view.frame.size.width - 50, imageView.frame.origin.y, imageView.frame.size.width, imageView.frame.size.height);
    [cell setLayoutMargins:UIEdgeInsetsZero];
    
    
    
    
    
    //右边内容
    UILabel *rightlabel = [[UILabel alloc]init];
    rightlabel.frame = _headImage.frame;
    rightlabel.width = 100;
    rightlabel.x = imageView.x - 100;
    rightlabel.textAlignment = UITextAlignmentRight;
    
    
    switch (indexPath.row) {
        case 0:
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = @"头像";
            [cell.contentView addSubview:_headImage];
            break;
        case 1:
            [cell.contentView addSubview:rightlabel];
            rightlabel.text = name;
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = @"昵称";
            break;
        case 2:
            [cell.contentView addSubview:rightlabel];
            [cell.contentView addSubview:imageView];
            rightlabel.text = gender;
            cell.textLabel.text = @"性别";
            break;
        case 4:
            [cell.contentView addSubview:rightlabel];
            [cell.contentView addSubview:imageView];
            rightlabel.text = @"186****788";
            cell.textLabel.text = @"手机号";
            break;
        case 5:
            [cell.contentView addSubview:rightlabel];
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = @"出生日期";
            rightlabel.text= _dateString;
            break;
        case 6:
            [cell.contentView addSubview:rightlabel];
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = @"孩子数量";
            rightlabel.text =numOfChild;
            cell.hidden = YES;
            break;
            
        case 8:
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = @"设置密码";
            break;
            
        default:
            break;
    }
    
    if (indexPath.row == 3 || indexPath.row == 7) {
        cell.backgroundColor = [UIColor clearColor];
    }
    //无色
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==3 || indexPath.row == 7) {
        return 10;
    }
    else if (indexPath.row == 6)
    {
        return 0;
    }
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeMyNameViewController *changeName = [ChangeMyNameViewController new];
    ChangePhoneViewController *changePhone = [ChangePhoneViewController new];
    
    switch (indexPath.row) {
        case 0:
            //修改头像
            index = @"1";
            [self takePictureClick];
            break;
        case 1:
            //修改昵称
            
            changeName.name = name;
            [self presentViewController:[[UINavigationController alloc]initWithRootViewController:changeName] animated:YES completion:nil];
            break;
        case 2:
            //修改性别
            index = @"3";
            [self changeGender];
            
            break;
        case 4:
            
            index = @"4";
            [self presentViewController:[[UINavigationController alloc]initWithRootViewController:changePhone] animated:YES completion:nil];
            //修改手机号
            break;
        case 5:
            //修改出生日期
            index = @"5";
            [self changeBirthday:indexPath.row];
            
            break;
        case 6:
            index = @"6";
            //修改孩子数量
            [self changeNumOfChild];
            break;
        case 8:
            index = @"7";
            //设置密码
            [self setPassword];
            break;
            
        default:
            break;
    }
}

-(void)viewDidLayoutSubviews {
    
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}





#pragma mark  ----------------- UIActionSheet Delegate ----------------------


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet == _genderChoiceAciotnSheet) {
        NSLog(@"%d",buttonIndex);
        switch (buttonIndex) {
            case 0:
                gender = @"男";
                break;
            case 1:
                gender = @"女";
                break;
            default:
                break;
        }
        [_tableView reloadData];
        
        //post
        [self post:gender];
    }
    else
    {
        NSLog(@"buttonIndex = [%d]",buttonIndex);
        switch (buttonIndex) {
            case 0://照相机
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                
                //            [self presentModalViewController:imagePicker animated:YES];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
                break;
            case 1://本地相册
            {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.allowsEditing = YES;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                imagePicker.delegate = self;
                imagePicker.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
                //            [self presentModalViewController:imagePicker animated:YES];
                [self presentViewController:imagePicker animated:YES completion:nil];
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark -
#pragma UIImagePickerController Delegate
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    NSLog(@"上传图像....");
    [_headImage setImage:image forState:UIControlStateNormal];
    
    CGSize imagesize = image.size;
    imagesize.height =10;
    imagesize.width =10;
    //对图片大小进行压缩--
    image = [self imageWithImage:image scaledToSize:imagesize];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        data = UIImageJPEGRepresentation(image, 0.1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    NSDictionary *dic =@{@"userPhone":@"18001670533",@"type":@"1",@"value":data};
    
    
//    [[YZXNetworkHelper shared] apiPost:@"http://120.26.212.55:8080/incidentally/api/userInfoUpdate/getUserInfoUpdate.html" parameters:dic success:^(id success){
//        
//        NSLog(@"%@",success);
//    }failure:^(id error)
//     {
//         NSLog(@"%@",error);
//         
//     }];
    
    
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
}

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // bug fixes: UIIMagePickerController使用中偷换StatusBar颜色的问题
    if ([navigationController isKindOfClass:[UIImagePickerController class]] &&
        ((UIImagePickerController *)navigationController).sourceType ==     UIImagePickerControllerSourceTypePhotoLibrary) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //    [picker dismissModalViewControllerAnimated:YES];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
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
