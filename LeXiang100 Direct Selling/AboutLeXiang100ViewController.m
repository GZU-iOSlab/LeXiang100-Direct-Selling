//
//  AboutLeXiang100ViewController.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-11.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "AboutLeXiang100ViewController.h"

@interface AboutLeXiang100ViewController ()

@end

@implementation AboutLeXiang100ViewController
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"关于乐享";
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        
        UIScrollView *scrollview=[[UIScrollView alloc] initWithFrame:self.view.frame];
        scrollview.contentSize=CGSizeMake(viewWidth, viewHeight*1.1);
        scrollview.showsHorizontalScrollIndicator=FALSE;
        scrollview.showsVerticalScrollIndicator=TRUE;
        
        UITextView * background = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];
        background.editable = NO;
        //[scrollview addSubview:background];
        
        
        //平台介绍标题
        UILabel * platform = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight/30)];
        platform.text = @"   平台介绍";
        //platform.textAlignment=UITextAlignmentCenter;
        platform.backgroundColor = [UIColor lightTextColor];
        platform.layer.borderColor = [UIColor grayColor].CGColor;
        platform.layer.borderWidth = 0.5;
        [scrollview addSubview:platform];
        
        
        UILabel * intro = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        intro.text = @"1.乐享100简介:";
        intro.font = [UIFont systemFontOfSize:viewHeight/40];
        intro.backgroundColor = [UIColor clearColor];
        //[intro addSubview:imgViewMetal];
        [scrollview addSubview:intro];

        UILabel *platform_intro=[[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30+viewHeight/28, viewWidth, viewHeight/20)];
    platform_intro.text=@"乐享100能够对营销人员的业务推荐办理结果进行记录、考核、定期给营销人员结算相应的酬金；从而提升营销人员推荐办理业务的积极性、进一步提高电子渠道的业务办理量和使用普及率，能够有效缓解实体渠道的压力，增强电子渠道的分流能力。";
        
        platform_intro.font = [UIFont systemFontOfSize:viewHeight/40];
        
        platform_intro.numberOfLines=0;
        platform_intro.lineBreakMode=NSLineBreakByCharWrapping;
        platform_intro.backgroundColor = [UIColor clearColor];
        CGSize size1 = CGSizeMake(viewWidth - viewWidth/10,MAXFLOAT);
        UIFont *font1 = [UIFont fontWithName:@"Arial" size:viewHeight/40];
        CGSize labelsize1 = [platform_intro.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        platform_intro.frame = CGRectMake(0, viewHeight/30+viewHeight/28, viewWidth, labelsize1.height);
        platform_intro.font =font1;
        [scrollview addSubview:platform_intro];
        
        UILabel * platform_chara = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/35+viewHeight/5, viewWidth/2, viewHeight/28)];
        platform_chara.text = @"2.乐享100的特点:";
        platform_chara.font = [UIFont systemFontOfSize:viewHeight/40];
        platform_chara.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:platform_chara];
        
        UILabel *platform_charaIntro=[[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/20+viewHeight/15, viewWidth/2, viewHeight/28)];
        platform_charaIntro.text = @"使用乐享100办理推荐业务快捷又方便，业务办理不再受时间、地点的限制。";
        platform_charaIntro.font = [UIFont systemFontOfSize:viewHeight/40];
        platform_charaIntro.backgroundColor = [UIColor clearColor];
        platform_charaIntro.numberOfLines=0;
        platform_charaIntro.lineBreakMode=NSLineBreakByCharWrapping;
        platform_charaIntro.backgroundColor = [UIColor clearColor];
        platform_charaIntro.frame = CGRectMake(0, viewHeight/40+viewHeight/5, viewWidth, labelsize1.height);
        platform_charaIntro.font =font1;
        [scrollview addSubview:platform_charaIntro];
        
        
        //短信端口标题
        UILabel * message = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/4+viewHeight/10, viewWidth, viewHeight/30)];
        message.text = @"   短信端口";
        message.backgroundColor = [UIColor lightTextColor];

        message.layer.borderColor = [UIColor grayColor].CGColor;
        message.layer.borderWidth = 0.5;
        [scrollview addSubview:message];
        
        UILabel *platform_message=[[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/4+viewHeight/10+viewHeight/30, viewWidth/2, viewHeight/28)];
        platform_message.text = @"10658260";
        platform_message.font = [UIFont systemFontOfSize:viewHeight/40];
        platform_message.backgroundColor = [UIColor clearColor];
        platform_message.numberOfLines=0;
        platform_message.lineBreakMode=NSLineBreakByCharWrapping;
        platform_message.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:platform_message];
        
        //客服电话标题
        UILabel * tel = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/4+viewHeight/10+viewHeight/13, viewWidth, viewHeight/30)];
        tel.text = @"   客服电话";
        tel.backgroundColor = [UIColor groupTableViewBackgroundColor];
        tel.layer.borderColor = [UIColor grayColor].CGColor;
        tel.layer.borderWidth = 0.5;
        [scrollview addSubview:tel];
        
        UILabel *tel_num=[[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/4+viewHeight/10+viewHeight/30, viewWidth/2, viewHeight/28)];
        tel_num.text = @"15718509310";
        tel_num.font = [UIFont systemFontOfSize:viewHeight/40];
        tel_num.backgroundColor = [UIColor clearColor];
        tel_num.numberOfLines=0;
        tel_num.lineBreakMode=NSLineBreakByCharWrapping;
        tel_num.backgroundColor = [UIColor clearColor];
        tel_num.frame = CGRectMake(0, viewHeight/4+viewHeight/10+viewHeight/17, viewWidth, labelsize1.height);
        tel_num.font =font1;
        [scrollview addSubview:tel_num];
        
        //官方网站标题
        UILabel * web = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/4+viewHeight/10+viewHeight/17+viewHeight/10, viewWidth, viewHeight/30)];
        web.text = @"   官方网站";
        web.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
        web.layer.borderColor = [UIColor grayColor].CGColor;
        web.layer.borderWidth = 0.5;
        [scrollview addSubview:web];
        
        UILabel *website=[[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/4+viewHeight/10+viewHeight/17+viewHeight/10, viewWidth/2, viewHeight/28)];
        website.text = @"http://www.gz.10086.cn/lx100";
        website.font = [UIFont systemFontOfSize:viewHeight/40];
        website.backgroundColor = [UIColor clearColor];
        website.numberOfLines=0;
        website.lineBreakMode=NSLineBreakByCharWrapping;
        website.backgroundColor = [UIColor clearColor];
        website.frame = CGRectMake(0, viewHeight/4+viewHeight/10+viewHeight/17+viewHeight/12, viewWidth, labelsize1.height);
        website.font =font1;
        [scrollview addSubview:website];
        [self.view addSubview:scrollview];
        
      
        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            self.view.backgroundColor = [UIColor whiteColor];
            platform.backgroundColor = [UIColor groupTableViewBackgroundColor];
            message.backgroundColor = [UIColor groupTableViewBackgroundColor];
            tel.backgroundColor = [UIColor groupTableViewBackgroundColor];
            web.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
