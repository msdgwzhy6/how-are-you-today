//
//  TodayStatusViewController.h
//  how are you today
//
//  Created by 高阳 on 15/10/5.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelcomeViewController.h"

@interface TodayStatusViewController : UIViewController

@property (copy,nonatomic) NSString* comment;
@property (assign,nonatomic) emotionType emotion;
@property (retain,nonatomic) NSDate* date;

@end
