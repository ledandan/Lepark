//
//  TravleTableViewCell.h
//  LeDanDan
//
//  Created by 辫子 on 15/11/4.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TravleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *property;

@property (weak, nonatomic) IBOutlet UILabel *sex;
@property (weak, nonatomic) IBOutlet UILabel *date;

@property (weak, nonatomic) IBOutlet UIButton *edit;


@property (weak, nonatomic) IBOutlet UIButton *clear;



@end
