//
//  NewCellTableViewCell.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-6.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "NewCellTableViewCell.h"

@implementation NewCellTableViewCell
//@synthesize imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

#define imageWidth 10
#define imageHeight 10


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat y = (self.bounds.size.height - imageHeight) / 2;
    //self.imageView.bounds = CGRectMake(0, y, imageWidth, imageHeight);
    self.imageView.frame = CGRectMake(0, y, imageWidth, imageHeight);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    
    
    CGRect tmpFrame = self.textLabel.frame;
    tmpFrame.origin.x = imageWidth + 20;
    self.textLabel.frame = tmpFrame;
    
    tmpFrame = self.detailTextLabel.frame;
    tmpFrame.origin.x = imageWidth + 20;
    self.detailTextLabel.frame = tmpFrame;
    
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.detailTextLabel.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
