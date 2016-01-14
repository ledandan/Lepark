//
//  PhoneContractViewController.m
//  LeDanDan
//
//  Created by yzx on 16/1/12.
//  Copyright © 2016年 herryhan. All rights reserved.
//

#import "PhoneContractViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <Foundation/Foundation.h>

@interface PhoneContractViewController ()<ABPeoplePickerNavigationControllerDelegate>
{
    NSMutableArray *peopleArray;
}
@end

@implementation PhoneContractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"手机联系人";
    
    ABAddressBookRef abRef = ABAddressBookCreateWithOptions(NULL, NULL);
    CFArrayRef cfPersons = ABAddressBookCopyArrayOfAllPeople(abRef);
    NSArray *persons = CFBridgingRelease(cfPersons);
    CFRelease(abRef);
    
   
}

-(void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
