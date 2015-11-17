//
//  HomeTableViewCell.h
//  LeDanDan
//
//  Created by 辫子 on 15/11/5.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *PlayImage;
@property (weak, nonatomic) IBOutlet UILabel *peopleNumber;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *NameLB;
@property (weak, nonatomic) IBOutlet UILabel *addressLB;
@property (weak, nonatomic) IBOutlet UILabel *dateLB;
@property (weak, nonatomic) IBOutlet UILabel *priceLB;

@end
