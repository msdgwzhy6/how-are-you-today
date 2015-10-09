//
//  StatisticsViewController.h
//  how are you today
//
//  Created by 高阳 on 15/10/8.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYPieChart.h"

@interface StatisticsViewController : UIViewController <XYPieChartDelegate,XYPieChartDataSource>

@property (strong, nonatomic) IBOutlet XYPieChart *pieChartMonth;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong,nonatomic) NSMutableArray* yearViews;
@property (strong,nonatomic) NSMutableArray* labViews;
@end
