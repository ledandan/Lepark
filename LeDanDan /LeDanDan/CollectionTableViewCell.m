//
//  CollectionTableViewCell.m
//  LeDanDan
//
//  Created by 辫子 on 15/11/4.
//  Copyright © 2015年 herryhan. All rights reserved.
//

#import "CollectionTableViewCell.h"

@implementation CollectionTableViewCell
{
    UIImageView *PlayImage;
    UILabel *PlayName;
    UILabel *time;
    UILabel *address;
    UILabel *NoCollection;
    UILabel *price;
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1000, 1)];
        line1.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1];
        //line.center = CGPointMake(self.center.x, line.center.y);
        [self.contentView addSubview:line1];

        PlayImage =[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 30, 30)];
        PlayImage.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:PlayImage];
        
        PlayName = [[UILabel alloc]initWithFrame:CGRectMake(PlayImage.frame.origin.x + PlayImage.frame.size.width +15, 10, 90, 15)];
        PlayName.text = @"111111111111111";
        PlayName.font = [UIFont boldSystemFontOfSize:10];
        [self.contentView addSubview:PlayName];
        
        
        time=[[UILabel alloc]initWithFrame:CGRectMake(PlayImage.frame.origin.x+PlayImage.frame.size.width+15, PlayName.frame.origin.y +PlayName.frame.size.height + 22, 80, 15)];
        time.font=[UIFont boldSystemFontOfSize:10];
        time.text=@"周六";
       // time.font=[UIFont fontWithName:@"6" size:9];
        [self.contentView addSubview:time];
                address= [[UILabel alloc]initWithFrame:CGRectMake(PlayImage.frame.origin.x + PlayImage.frame.size.width +15, PlayName.frame.origin.y +PlayName.frame.size.height + 5, 80, 15)];
        address.text = @"上海市";
        [self.contentView addSubview:address];
        
        NoCollection = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width -80, 22, 80, 15)];
        NoCollection.text = @"取消收藏";
       [ self.contentView addSubview:NoCollection];
        
        price=[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width -80, PlayName.frame.origin.y +PlayName.frame.size.height + 5, 80, 15)];
        price.text=@"120";
        [self.contentView addSubview:price];
    
    
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
