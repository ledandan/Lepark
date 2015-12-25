//
//  CollectionTableViewCell.h
//  LeDanDan
//
//  Created by 辫子 on 15/11/4.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionTableViewCell : UITableViewCell
@property (nonatomic, strong) UIImageView *playImage;

@property (nonatomic, strong) UILabel *playName;

@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UILabel *address;

@property (nonatomic, strong) UILabel *price;

@property (nonatomic, strong) UIButton *NoCollection;

@end
