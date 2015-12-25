//
//  CollectionTableViewCell.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/4.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000, 1)];
        line1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        //line.center = CGPointMake(self.center.x, line.center.y);
        [self.contentView addSubview:line1];

        _playImage =[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 80, 80)];
        _playImage.backgroundColor = [UIColor redColor];
        _playImage.image = [UIImage imageNamed:@"2"];
        [self.contentView addSubview:_playImage];
        
        _playName = [[UILabel alloc]initWithFrame:CGRectMake(_playImage.frame.origin.x + _playImage.frame.size.width +15, 15, 200, 15)];
        _playName.text = @"小小地址学家启蒙课";
        _playName.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_playName];
        
        _time=[[UILabel alloc]initWithFrame:CGRectMake(_playImage.frame.origin.x+_playImage.frame.size.width+15, _playName.bottom + 5, 80, 25)];
        _time.font=[UIFont boldSystemFontOfSize:10];
        _time.text=@"周六";
        _time.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:_time];
        _address= [[UILabel alloc]initWithFrame:CGRectMake(_playImage.frame.origin.x + _playImage.frame.size.width +15, _time.bottom+ 5, 80, 15)];
        _address.text = @"上海市";
        _address.font =[UIFont systemFontOfSize:16];
        _address.textColor = [UIColor grayColor];
        [self.contentView addSubview:_address];
    
        _NoCollection = [UIButton buttonWithType:UIButtonTypeCustom];
        _NoCollection.frame = CGRectMake(kScreenWidth - 80, _playName.bottom, 60, 20);
        [_NoCollection setTitle:@"取消收藏" forState: UIControlStateNormal];
        _NoCollection.titleLabel.font =[UIFont systemFontOfSize:15];
        [_NoCollection setTitleColor: [UIColor grayColor] forState:UIControlStateNormal];
        
        [self.contentView addSubview:_NoCollection];
        
        _price=[[UILabel alloc]initWithFrame:CGRectMake(_NoCollection.x, _playImage.bottom - 15, 80, 15)];
        _price.text=@"￥ 120";
        _price.textColor = [UIColor colorWithRed:0.96 green:0.5 blue:0.4 alpha:1];
        [self.contentView addSubview:_price];
    
    
    }
    
     return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
