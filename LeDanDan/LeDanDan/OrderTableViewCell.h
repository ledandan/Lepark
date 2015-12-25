//
//  OrderTableViewCell.h
//  LeDanDan
//
//  Created by 辫子 on 15/11/3.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *playImage;

@property (nonatomic, strong) UILabel *playName;

@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) UILabel *status;

@property (nonatomic, strong) UIButton *status_btn;

@end
