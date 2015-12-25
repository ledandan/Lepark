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
@interface MyInformationViewController ()<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
{
    NSArray *count;
    UITableView *_tableView;
    UIButton *_headImage;
    
    
    NSString *name;
    NSString *gender;
    
    UIActionSheet *_genderChoiceAciotnSheet;
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
    
    [self AddJson];
    [self addControl];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [self dismissModalViewControllerAnimated:YES];
    self.view.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    UIImage *searchimage=[UIImage imageNamed:@"back@2x"];
    UIBarButtonItem *barbtn=[[UIBarButtonItem alloc] initWithImage:searchimage style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.96f green:0.5f blue:0.4f alpha:1];
    self.navigationItem.leftBarButtonItem=barbtn;
    
    [super viewWillAppear:animated];
    //[selectedViewController viewWillAppear:animated];
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)AddJson
{
    name = @"小马哥";
}
-(void)addControl
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
            rightlabel.text=@"12-05";
            break;
        case 6:
            [cell.contentView addSubview:rightlabel];
            [cell.contentView addSubview:imageView];
            cell.textLabel.text = @"孩子数量";
            rightlabel.text =@"2";
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
            [self takePictureClick];
            break;
        case 1:
            //修改昵称
            
            changeName.name = name;
            [self presentViewController:[[UINavigationController alloc]initWithRootViewController:changeName] animated:YES completion:nil];
            break;
        case 2:
            //修改性别
            [self changeGender];
            
            break;
        case 4:
            
            [self presentViewController:[[UINavigationController alloc]initWithRootViewController:changePhone] animated:YES completion:nil];
            //修改手机号
            break;
        case 5:
            //修改出生日期
            break;
        case 6:
            //修改孩子数量
            break;
        case 8:
            //设置密码
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
    NSProgress *progress;
    //    [[MSNetworkHelper shared] apiUpload:[[ObjectCTools shared] getUrlsFromPlistFile:kUpdate_avatar]
//                             parameters:[NSDictionary dictionaryWithObjectsAndKeys:
//                                         [MSNetworkHelper shared]._uid, @"uid",
//                                         [MSNetworkHelper shared]._token, @"token",
//                                         nil]
//                               fromFile:UIImageJPEGRepresentation(image,0.8) progress:&progress
//                            isMultipart:YES
//                      completionHandler:^(NSURLResponse *response, NSDictionary* resultDictionary, NSError *error)
//     {
//         if (!error)
//         {
//             
//             if ([[resultDictionary objectForKey:@"status"] isEqualToString:@"1"])
//             {
//                 NSString *avatarUrlString = [[resultDictionary objectForKey:@"data"] objectForKey:@"avatar"];
//                 if ([[ObjectCTools shared] refreshTheUserInfoDictionaryWithKey:@"avatar" withValue:avatarUrlString])
//                 {
//                     //刷新头像成功
//                     NSLog(@"清空头像缓存");
//                     //                     [[SDImageCache sharedImageCache] removeImageForKey:avatarUrlString];
//                     //                     [[SDImageCache sharedImageCache] removeImageForKey:avatarUrlString fromDisk:YES];
//                     
//                     //延迟更新，因为清缓存需要时间
//                     [self performSelector:@selector(refreshTheHeadImage) withObject:nil afterDelay:0.8];
//                 }
//                 
//                 [[ObjectCTools shared] showAlertViewAndDissmissAutomatic:@"头像更新成功!" andMessage:@"" withDissmissTime:1.0 withDelegate:nil withAction:nil];
//                 NSLog(@"上传成功，取得头像地址");
//             }
//             else
//             {
//                 [[ObjectCTools shared] showAlertViewAndDissmissAutomatic:[resultDictionary objectForKey:@"message"] andMessage:@"" withDissmissTime:vAutomaticDissmissAlertViewShowTime withDelegate:nil withAction:nil];
//             }
//         }
//         else
//         {
//             NSLog(@"失败:error =  %@", error);
//             
//         }
//     }];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    
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

//- (void)saveImage:(UIImage *)image {
//    //    NSLog(@"保存头像！");
//    //    [userPhotoButton setImage:image forState:UIControlStateNormal];
//    BOOL success;
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    NSError *error;
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *imageFilePath = [documentsDirectory stringByAppendingPathComponent:@"selfPhoto.jpg"];
//    NSLog(@"imageFile->>%@",imageFilePath);
//    success = [fileManager fileExistsAtPath:imageFilePath];
//    if(success) {
//        success = [fileManager removeItemAtPath:imageFilePath error:&error];
//    }
//    //    UIImage *smallImage=[self scaleFromImage:image toSize:CGSizeMake(80.0f, 80.0f)];//将图片尺寸改为80*80
//    UIImage *smallImage = [self thumbnailWithImageWithoutScale:image size:CGSizeMake(93, 93)];
//    [UIImageJPEGRepresentation(smallImage, 1.0f) writeToFile:imageFilePath atomically:YES];//写入文件
//    UIImage *selfPhoto = [UIImage imageWithContentsOfFile:imageFilePath];//读取图片文件
//    //    [userPhotoButton setImage:selfPhoto forState:UIControlStateNormal];
//    self.img.image = selfPhoto;
//}

// 改变图像的尺寸，方便上传服务器
- (UIImage *) scaleFromImage: (UIImage *) image toSize: (CGSize) size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
