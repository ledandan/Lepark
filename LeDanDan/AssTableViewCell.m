//
//  AssTableViewCell.m
//  LeDanDan
//
//  Created by yzx on 15/11/20.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "AssTableViewCell.h"

@implementation AssTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.name.textColor = [UIColor grayColor];
    self.time.textColor = [UIColor grayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
