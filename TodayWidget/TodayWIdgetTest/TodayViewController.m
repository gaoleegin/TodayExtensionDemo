//
//  TodayViewController.m
//  TodayWIdgetTest
//
//  Created by gaolijun on 15/4/11.
//  Copyright (c) 2015年 Lijun. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

#import "UIViewAdditions.h"

@interface TodayViewController () <NCWidgetProviding,NSURLConnectionDataDelegate>

@property(nonatomic,weak)UILabel *weatherLabel;

@property (strong,nonatomic) NSMutableData *datas;


@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //加载数据
    [self loadData];
    
    
    //创建子控件
    [self creatChildsViews];
}

-(void)loadData{
    
    NSURL *url = [NSURL URLWithString:@"http://www.weather.com.cn/data/sk/101010100.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        _datas = [NSMutableData new];
    }
}

-(void)creatChildsViews{
    
    //调节TodayViewController的view的尺寸
    self.preferredContentSize = CGSizeMake(0, 365);
    
    UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 365)];
    mainView.backgroundColor = [UIColor redColor];
    
    UILabel *weatherLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    weatherLabel.text = @"weather";
    weatherLabel.font = [UIFont boldSystemFontOfSize:17.0];
    
    weatherLabel.backgroundColor = [UIColor whiteColor];
    self.weatherLabel = weatherLabel;
    
    UIButton *jumpMain = [[UIButton alloc]initWithFrame:CGRectMake(0, 80, self.view.width, 60)];
    jumpMain.backgroundColor = [UIColor whiteColor];
    [jumpMain setTitle:@"点击我！！跳转并且传出数据" forState:UIControlStateNormal];
    jumpMain.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [jumpMain setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [jumpMain addTarget:self action:@selector(btnClick:) forControlEvents: UIControlEventTouchUpInside];
    [mainView addSubview:jumpMain];
    [mainView addSubview:weatherLabel];
    [self.view addSubview:mainView];
    
}

-(void)btnClick:(UIButton *)btn{
    
        NSString *movieUrl = [NSString stringWithFormat:@"TodayExtension://%@",self.weatherLabel.text];
        [self.extensionContext openURL:[NSURL URLWithString:movieUrl] completionHandler:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//时不时的调用
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

/*NSURLConnectionDataDelegate*/
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_datas appendData:data];
}

-(void) connection:(NSURLConnection *)connection didFailWithError: (NSError *)error {
    NSLog(@"%@",[error localizedDescription]);
}

- (void) connectionDidFinishLoading: (NSURLConnection*) connection {
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:_datas
                                                           options:NSJSONReadingAllowFragments error:nil];
    
    NSString * temp =        result[@"weatherinfo"][@"temp"];
    NSString * time =        result[@"weatherinfo"][@"time"];
    
    NSString * weatherstr = [NSString stringWithFormat:@"beijing%@-%@",temp,time];
    self.weatherLabel.text = weatherstr;

}

//调节边距的方法
-(UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets{
    return defaultMarginInsets;
}


/*
 需要注意的地方
 1.关于布局
 1.如果在TodayExtension里面自带的storyboard里面进行布局，需要注意，必须明确距离父控件的底部的距离，否则会发现意想不到的效果！其他的和普通的没有什么区别！
 2.不要使用重量刑的组件，比如说UITableView，如果既使用了UITableView
 ，又在里面进行网络的加载，会特别卡！（当然可以试一试）！
 
 2.关于跳转
 NSString *movieUrl = [NSString stringWithFormat:@"TodayExtension://%@",self.weatherLabel.text];
 [self.extensionContext openURL:[NSURL URLWithString:movieUrl] completionHandler:nil];
 
 
 3.关于网络
 1.不能够倒入第三方框架AFNetworking，SDWebImage，AFNetworking
 原因是在这两个里面调用了 [UIApplication sharedApplication] 这个方法;
 
 4.关于共享数据
 NSUserDefaults * ud = [[NSUserDefaults alloc] initWithSuiteName:@"group.groupname"];
 
  NSString * str = [NSString stringWithFormat:@"%@-%@-%@",city,temp,time];
 
 [ud setObject:str    forKey:@"weather"];
 
 [ud synchronize];
 */

@end
