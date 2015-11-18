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
{
    UIImageView *PlayImage;
    UILabel *PlayName;
    UILabel *price;
    UILabel *status;
    UIButton *btn;
    
    
}

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
        
        PlayImage =[[UIImageView alloc]initWithFrame:CGRectMake(15, 22, 80, 80)];
        PlayImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:PlayImage];
        
        PlayName = [[UILabel alloc]initWithFrame:CGRectMake(PlayImage.frame.origin.x + PlayImage.frame.size.width +15, 22, 90, 15)];
        PlayName.text = @"111111111111111";
        [self.contentView addSubview:PlayName];
        
        price = [[UILabel alloc]initWithFrame:CGRectMake(PlayImage.frame.origin.x + PlayImage.frame.size.width +15, PlayName.frame.origin.y +PlayName.frame.size.height + 54, 80, 15)];
        price.text = @"120";
        [self.contentView addSubview:price];

        status = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width -80, 22, 80, 15)];
        status.text = @"待付款";
        [self.contentView addSubview:status];
        
              
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.frame.size.width -80, price.frame.origin.y, 75, 15);
        [btn setTitle:@"去付款" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
        [self.contentView addSubview:btn];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
