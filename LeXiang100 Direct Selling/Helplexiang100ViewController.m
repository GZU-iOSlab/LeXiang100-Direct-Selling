//
//  Helplexiang100controller.m
//  LeXiang100 Direct Selling
//
//  Created by 任魏翔 on 14-6-14.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "Helplexiang100ViewController.h"

@implementation Helplexiang100ViewController
#define viewWidth   self.view.frame.size.width
#define viewHeight  self.view.frame.size.height

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"使用帮助";
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        //解决ios7界面上移  配色等问题
        if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7) {
            self.edgesForExtendedLayout = UIRectEdgeNone;
            self.extendedLayoutIncludesOpaqueBars =NO;
            self.modalPresentationCapturesStatusBarAppearance = NO;
            self.navigationController.navigationBar.translucent = NO;
            self.view.backgroundColor = [UIColor whiteColor];
        }
        
        UIScrollView *scrollview=[[UIScrollView alloc] initWithFrame:self.view.frame];
        scrollview.contentSize=CGSizeMake(viewWidth, viewHeight*1.1);
        scrollview.showsHorizontalScrollIndicator=FALSE;
        scrollview.showsVerticalScrollIndicator=TRUE;
        
        CGSize size1 = CGSizeMake(viewWidth - viewWidth/10,MAXFLOAT);
        UIFont *font1 = [UIFont fontWithName:@"Arial" size:viewHeight/47];
        UIFont *font2=[UIFont fontWithName:@"Arial" size:viewHeight/35];
        //适用对象标题
        UILabel * user = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight/30)];
        user.text = @"   适用对象";
        user.font=font2;
        user.backgroundColor = [UIColor groupTableViewBackgroundColor];
       // [user addSubview:imgViewMetal];
        
        
      //  guid.textAlignment=UITextAlignmentCenter;
        user.layer.borderColor = [UIColor grayColor].CGColor;
        user.layer.borderWidth = 0.5;
        
        [scrollview addSubview:user];
        
        UILabel * user_intro = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        user_intro.text = @"贵州所有在乐享100注册的直销员。";
        user_intro.font = [UIFont systemFontOfSize:viewHeight/40];
        
        CGSize labelsize1 = [user_intro.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        user_intro.frame = CGRectMake(0, viewHeight/31+viewHeight/60, viewWidth, labelsize1.height);
        user_intro.font =font1;
        user_intro.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:user_intro];
        
        
        UILabel * user_introPlus = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30+viewHeight/60, viewWidth/2, viewHeight/28)];
        user_introPlus.text = @"这是一款免费软件，但软件的使用过程中会产生一定的流量费用，由运营商收取。";
        user_introPlus.font = [UIFont systemFontOfSize:viewHeight/40];
        user_introPlus.numberOfLines=0;
        user_introPlus.lineBreakMode=NSLineBreakByCharWrapping;
        user_introPlus.backgroundColor = [UIColor clearColor];
        CGSize labelsize2 = [user_introPlus.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        user_introPlus.frame = CGRectMake(0, viewHeight/18+viewHeight/60, viewWidth, labelsize2.height);
        user_introPlus.font =font1;
        user_introPlus.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:user_introPlus];
        
        
        
        //如何快速找到要推荐的业务标题
        UILabel * quickFind = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30+viewHeight/15+viewHeight/40, viewWidth, viewHeight/30)];
        quickFind.text = @"   如何快速找到要推荐的业务";
        quickFind.font=font2;
        quickFind.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //  guid.textAlignment=UITextAlignmentCenter;
        quickFind.layer.borderColor = [UIColor grayColor].CGColor;
        quickFind.layer.borderWidth = 0.5;
        [scrollview addSubview:quickFind];
        
        UILabel * findGuid = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        findGuid.text = @"在“业务推荐”界面上方有一个业务搜索框，支持按业务中文名称或业务名称的拼音首字母进行业务搜索。";
        findGuid.font = [UIFont systemFontOfSize:viewHeight/40];
        findGuid.numberOfLines=0;
        findGuid.lineBreakMode=NSLineBreakByCharWrapping;
        findGuid.backgroundColor = [UIColor clearColor];
        CGSize labelsize3 = [findGuid.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        findGuid.frame = CGRectMake(0, viewHeight/30+viewHeight/10+viewHeight/35+viewHeight/80, viewWidth, labelsize3.height);
        findGuid.font =font1;
        findGuid.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:findGuid];
        
        
        //收藏夹有什么用标题
        UILabel * favorite = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/33+viewHeight/10+viewHeight/20+viewHeight/30+viewHeight/80, viewWidth, viewHeight/30)];
        favorite.text = @"   收藏夹有什么用";
        favorite.font=font2;
        favorite.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //  guid.textAlignment=UITextAlignmentCenter;
        favorite.layer.borderColor = [UIColor grayColor].CGColor;
        favorite.layer.borderWidth = 0.5;
        [scrollview addSubview:favorite];
        
        UILabel * favorite_intro = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        favorite_intro.text = @"将经常推荐的业务添加到收藏夹，便于以后能够快速找到他们。";
        favorite_intro.font = [UIFont systemFontOfSize:viewHeight/40];
        favorite_intro.numberOfLines=0;
        favorite_intro.lineBreakMode=NSLineBreakByCharWrapping;
        favorite_intro.backgroundColor = [UIColor clearColor];
        CGSize labelsize4 = [favorite_intro.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        favorite_intro.frame = CGRectMake(0, viewHeight/5+viewHeight/60+viewHeight/33+viewHeight/80+viewHeight/100, viewWidth, labelsize4.height);
        favorite_intro.font =font1;
        favorite_intro.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:favorite_intro];
        
        //如何把业务添加到收藏夹标题
        UILabel * favorite_op = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/5+viewHeight/23+viewHeight/33+viewHeight/80+viewHeight/100, viewWidth, viewHeight/30)];
        favorite_op.text = @"   如何把业务添加到收藏夹";
        favorite_op.font=font2;
        favorite_op.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //  guid.textAlignment=UITextAlignmentCenter;
        favorite_op.layer.borderColor = [UIColor grayColor].CGColor;
        favorite_op.layer.borderWidth = 0.5;
        [scrollview addSubview:favorite_op];
        
        UILabel * favorite_opIntro = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        favorite_opIntro.text = @"在“业务推荐”界面，依次点击业务一级分类、二级分类，进入到业务列表界面，长按业务所在行将会弹出操作菜单，选择“添加到收藏夹”即可收藏该业务。";
        favorite_opIntro.font = [UIFont systemFontOfSize:viewHeight/40];
        favorite_opIntro.numberOfLines=0;
        favorite_opIntro.lineBreakMode=NSLineBreakByCharWrapping;
        favorite_opIntro.backgroundColor = [UIColor clearColor];
        CGSize labelsize5 = [favorite_opIntro.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        favorite_opIntro.frame = CGRectMake(0, viewHeight/5+viewHeight/15+viewHeight/60+viewHeight/33+viewHeight/80+viewHeight/100, viewWidth, labelsize5.height);
        favorite_opIntro.font =font1;
        favorite_opIntro.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:favorite_opIntro];
        
        //什么是热点业务标题
        UILabel * hot_busi = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/33+viewHeight/33+viewHeight/5+viewHeight/10+viewHeight/20, viewWidth, viewHeight/30)];
        hot_busi.text = @"   什么是热点业务";
        hot_busi.font=font2;
        hot_busi.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //  guid.textAlignment=UITextAlignmentCenter;
        hot_busi.layer.borderColor = [UIColor grayColor].CGColor;
        hot_busi.layer.borderWidth = 0.5;
        [scrollview addSubview:hot_busi];
        
        UILabel * hot_intro = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        hot_intro.text = @"热点业务是指直销人员推荐的最多的业务，或时下最热门的业务。";
        hot_intro.font = [UIFont systemFontOfSize:viewHeight/40];
        hot_intro.numberOfLines=0;
        hot_intro.lineBreakMode=NSLineBreakByCharWrapping;
        hot_intro.backgroundColor = [UIColor clearColor];
        CGSize labelsize6 = [hot_intro.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        hot_intro.frame = CGRectMake(0, viewHeight/33+viewHeight/10+viewHeight/5+viewHeight/20+viewHeight/80+viewHeight/100+viewHeight/20, viewWidth, labelsize6.height);
        hot_intro.font =font1;
        hot_intro.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:hot_intro];

        
        
        //如何更新软件标题
        UILabel * update = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/33+viewHeight/5+viewHeight/10+viewHeight/20+viewHeight/26+viewHeight/20+viewHeight/100+viewHeight/50, viewWidth, viewHeight/30)];
        update.text = @"   如何更新软件";
        update.font=font2;
        update.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //  guid.textAlignment=UITextAlignmentCenter;
        update.layer.borderColor = [UIColor grayColor].CGColor;
        update.layer.borderWidth = 0.5;
        [scrollview addSubview:update];
        
        UILabel * update_intro = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        update_intro.text = @"根据平台业务发展的需要，本软件会经常更新。在软件的主页面，依次点击“更多”－“检查更新”项即开始检查是否有新的版本，如果有新的版本会提示您是否需要下载更新。";
        update_intro.font = [UIFont systemFontOfSize:viewHeight/40];
        update_intro.numberOfLines=0;
        update_intro.lineBreakMode=NSLineBreakByCharWrapping;
        update_intro.backgroundColor = [UIColor clearColor];
        CGSize labelsize7 = [update_intro.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        update_intro.frame = CGRectMake(0, viewHeight/33+viewHeight/5+viewHeight/5+viewHeight/30+viewHeight/80+viewHeight/50+viewHeight/30+viewHeight/100, viewWidth, labelsize7.height);
        update_intro.font =font1;
        update_intro.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:update_intro];
        
        
        //把您的想法告诉我们标题
        
        UILabel * tell = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/5+viewHeight/5+viewHeight/20+viewHeight/18+viewHeight/33+viewHeight/40+viewHeight/50+viewHeight/40+viewHeight/50, viewWidth, viewHeight/30)];
        tell.text = @"   把您的想法告诉我们";
        tell.font=font2;
        tell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        //  guid.textAlignment=UITextAlignmentCenter;
        tell.layer.borderColor = [UIColor grayColor].CGColor;
        tell.layer.borderWidth = 0.5;
        [scrollview addSubview:tell];
        
        UILabel * tellUs = [[UILabel alloc]initWithFrame:CGRectMake(0, viewHeight/30, viewWidth/2, viewHeight/28)];
        tellUs.text = @"如果您发现本软件存在问题或有好的改进建议，请告诉我们，我们将在软件的后续版本中考虑您的建议，谢谢！\n 在主页面，依次点击“更多”－“用户建议”项，填写好您的建议点击“提交”按钮即可。";
        tellUs.font = [UIFont systemFontOfSize:viewHeight/40];
        tellUs.numberOfLines=0;
        tellUs.lineBreakMode=NSLineBreakByCharWrapping;
        tellUs.backgroundColor = [UIColor clearColor];
        CGSize labelsize8 = [update_intro.text sizeWithFont:font1 constrainedToSize:size1 lineBreakMode:NSLineBreakByWordWrapping];
        tellUs.frame = CGRectMake(0, viewHeight/10+viewHeight/5+viewHeight/5+viewHeight/25+viewHeight/33+viewHeight/80+viewHeight/30+viewHeight/30+viewHeight/100, viewWidth, labelsize8.height);
        tellUs.font =font1;
        tellUs.backgroundColor = [UIColor clearColor];
        [scrollview addSubview:tellUs];
        [self.view addSubview:scrollview];
        
        
        
        
        
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
@end
