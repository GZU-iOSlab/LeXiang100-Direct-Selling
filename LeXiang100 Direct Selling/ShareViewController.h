//
//  ShareViewController.h
//  LeXiang100 Direct Selling
//
//  Created by 任魏翔 on 14-6-22.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface ShareViewController : UIViewController<MFMessageComposeViewControllerDelegate>
{
    MFMessageComposeViewController *message;

}
@property (nonatomic,assign) MFMessageComposeViewController *message;
@end

