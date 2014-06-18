//
//  NewCellTableViewCell.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-6.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "NewCellTableViewCell.h"

@implementation NewCellTableViewCell
@synthesize delegate;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        UILongPressGestureRecognizer *longPressGR = [[ UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        longPressGR.minimumPressDuration = 0.7;
        [self addGestureRecognizer:longPressGR];
        [longPressGR release];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    //    if (action == @selector(cut:))
    //    {
    //        return NO;
    //    }
    //    else if(action == @selector(copy:))
    //    {
    //        return NO;
    //    }
    //    else if(action == @selector(paste:))
    //    {
    //        return NO;
    //    }
    //    else if(action == @selector(select:))
    //    {
    //        return NO;
    //    }
    //    else if(action == @selector(selectAll:))
    //    {
    //        return NO;
    //    }
    //    else
    if(action == @selector(delete:))
    {
        return YES;
    }
    else if(action == @selector(collect:))
    {
        return YES;
    }
    else
    {
        return [super canPerformAction:action withSender:sender];
    }
}

- (void)collect:(id)sender{
    
}

- (void)delete:(id)sender
{
    //[[self delegate] performSelector:@selector(deleteRow:) withObject:self];
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    
    if([self isHighlighted])
    {
        //[[self delegate] performSelector:@selector(showMenu:) withObject:self];
    }
    
}

@end
