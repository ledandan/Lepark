//
//  OrderTableViewCell.m
//
//  LeDanDan
//
//  Created by 辫子 on 15/11/3.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
       

        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1000, 15)];
        view.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        [self.contentView addSubview:view];
        
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000, 1)];
        line1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        //line.center = CGPointMake(self.center.x, line.center.y);
        [view addSubview:line1];
        
        UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 14, 1000, 1)];
        line2.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        //line.center = CGPointMake(self.center.x, line.center.y);
        [view addSubview:line2];
        
        _playImage =[[UIImageView alloc]initWithFrame:CGRectMake(15, 22.5, 90, 90)];
        _playImage.backgroundColor = [UIColor redColor];
        _playImage.image = [UIImage imageNamed:@"2"];
        [self.contentView addSubview:_playImage];
        
        _playName = [[UILabel alloc]initWithFrame:CGRectMake(_playImage.frame.origin.x + _playImage.frame.size.width +15, 22, 150, 15)];
        _playName.text = @"小小地址学家启蒙课,关于地层的秘密";
        _playName.font =[UIFont systemFontOfSize:16];
        _playName.textColor = [UIColor grayColor];
        _playName.numberOfLines = 0;
        [_playName sizeToFit];
        [self.contentView addSubview:_playName];
        
        _price = [[UILabel alloc]initWithFrame:CGRectMake(_playImage.frame.origin.x + _playImage.frame.size.width +15, _playImage.bottom - 15, 280, 15)];
        _price.text = @"￥ 120";
        _price.textColor =[UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
        [self.contentView addSubview:_price];

        _status = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width -90, 22, 80, 15)];
        _status.text = @"待付款";
        _status.textAlignment = UITextAlignmentRight;
        _status.textColor = [UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
        _status.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:_status];
        
        
        _status_btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _status_btn.frame = CGRectMake(kScreenWidth -90, _playImage.bottom -30, 80, 30);
        [_status_btn setTitle:@"去付款" forState:UIControlStateNormal];
        _status_btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _status_btn.backgroundColor = [UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
        [self.contentView addSubview:_status_btn];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
