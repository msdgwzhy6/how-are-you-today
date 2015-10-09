//
//  rootTabBarController.m
//  how are you today
//
//  Created by 高阳 on 15/9/29.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import "rootTabBarController.h"
#import "CalenderViewController.h"
#import "WelcomeViewController.h"
#import "StatisticsViewController.h"

@interface rootTabBarController ()

@end

@implementation rootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setChildViewControllers];
    // Do any additional setup after loading the view.
    
}

- (void)setChildViewControllers {
    CalenderViewController* calenderVC=[CalenderViewController new];
    UIImage* calenderImageSelected=[UIImage imageNamed:@"Calender"];
    UITabBarItem* calenderTabBarItem=[[UITabBarItem alloc] initWithTitle:@"Calender" image:calenderImageSelected selectedImage:calenderImageSelected];
    calenderVC.tabBarItem=calenderTabBarItem;
    
    StatisticsViewController* staticsVC=[StatisticsViewController new];
    UIImage* staticImageSelected=[UIImage imageNamed:@"Statics"];
    UITabBarItem* staticsTabBarItem=[[UITabBarItem alloc] initWithTitle:@"Statics" image:staticImageSelected selectedImage:staticImageSelected];
    staticsVC.tabBarItem=staticsTabBarItem;
    
    NSArray* childViewControllers=[[NSArray alloc] initWithObjects:calenderVC,staticsVC, nil];
    [self setViewControllers:childViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
