//
//  StatisticsViewController.m
//  how are you today
//
//  Created by 高阳 on 15/10/8.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import "StatisticsViewController.h"
#import "WelcomeViewController.h"
#import "AppDelegate.h"
#import "JTDateHelper.h"

@interface StatisticsViewController ()
@property (copy,nonatomic) NSArray* sliceColors;
@property (strong,nonatomic) NSMutableArray* monthStatistics;
@property (strong,nonatomic) NSMutableArray* yearStatistics;

@property (strong,nonatomic) JTDateHelper* dateHelper;

@end

@implementation StatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.dateHelper=[JTDateHelper new];
    
    [self loadStatistics];
    
    //self.segmentControl.selectedSegmentIndex=0;
    [self.segmentControl addTarget:self action:@selector(loadCharts:) forControlEvents:UIControlEventValueChanged];
    [self loadCharts:self.segmentControl];
    
    NSArray* monthName=[NSArray arrayWithObjects:@"Jan.",@"Feb.",@"Mar.",@"Apr.",@"May.",@"Jun.",@"Jul.",@"Aug.",@"Sep.",@"Oct.",@"Nov.",@"Dec.", nil];
    self.yearViews=[NSMutableArray new];
    self.labViews=[NSMutableArray new];
    for (int i=0; i<12; ++i) {
        CGFloat chartR=50.0;
        CGFloat inter=20.0;
        CGFloat interY=15.0;
        CGFloat chartX=20+(i%3)*(inter+2*chartR);
        CGFloat labelH=20.0;
        CGFloat chartY=80+(i/3)*(interY+labelH+2*chartR);
        CGFloat labelX=chartX;
        CGFloat labelY=chartY+2*chartR;
        CGFloat chartH=labelH+2*chartR;
        
        XYPieChart* chart=[[XYPieChart alloc] initWithFrame:CGRectMake(chartX, chartY, 2*chartR, chartH)];
        chart.tag=i;
        [chart setDataSource:self];
        [chart setStartPieAngle:M_PI_2];
        [chart setAnimationSpeed:1.0];
        [chart setLabelFont:[UIFont fontWithName:@"STHeitik-Light" size:20]];
        [chart setLabelRadius:0];
        [chart setShowPercentage:NO];
        [chart setUserInteractionEnabled:NO];
        [chart setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
        [self.view addSubview:chart];
        chart.hidden=YES;
        [self.yearViews addObject: chart];
        
        UILabel* lab=[[UILabel alloc] initWithFrame:CGRectMake(labelX, labelY, chartR*2, labelH)];
        lab.text=monthName[i];
        [lab setTextAlignment:NSTextAlignmentCenter];
        [lab setFont:[UIFont fontWithName:@"STHeitik-Light" size:15]];
        [self.view addSubview:lab];
        lab.hidden=YES;
        [self.labViews addObject:lab];
        
    }
    self.sliceColors=[NSArray arrayWithObjects:
                      [WelcomeViewController getFantasticColor],
                      [WelcomeViewController getOrdinaryColor],
                      [WelcomeViewController getTerribleColor], nil];
    
    // Do any additional setup after loading the view from its nib.
}

//-(void)viewDidUnload {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"dayDataChanged" object:nil];
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadStatistics {
    AppDelegate* appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context=appDelegate.managedObjectContext;
    NSError* error;
    self.monthStatistics=[NSMutableArray new];
    self.yearStatistics=[NSMutableArray new];
    for (int i=0; i<=12; ++i) {
        [self.yearStatistics addObject:[NSMutableArray arrayWithObjects:@0,@0,@0,@0, nil]];
    }
    
    NSFetchRequest* request=[[NSFetchRequest new] init];
    NSEntityDescription* entityDescription=[NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];
    [request setEntity:entityDescription];
    NSArray* objects=[context executeFetchRequest:request error:&error];
    for (NSManagedObject* obj in objects) {
        NSInteger emotion=[[obj valueForKey:@"emotion"] integerValue];
        NSDate* date=[obj valueForKey:@"date"];
        NSDateComponents* datecomponent=[self.dateHelper.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date ];
        NSInteger month=datecomponent.month;
        NSInteger temp=[[[self.yearStatistics objectAtIndex:month] objectAtIndex:emotion] integerValue];
        [[self.yearStatistics objectAtIndex:month] replaceObjectAtIndex:emotion withObject:@(temp+1)];
    }
    NSDateComponents* todaycomponent=[self.dateHelper.calendar components:NSCalendarUnitMonth fromDate:[NSDate date]];
    NSInteger thisMonth=todaycomponent.month;
    self.monthStatistics=[self.yearStatistics objectAtIndex:thisMonth];
}

- (void)loadCharts: (UISegmentedControl*) seg {
    if (seg.selectedSegmentIndex==0) {
        self.pieChartMonth.hidden=NO;
        for (XYPieChart* chart in self.yearViews) {
            chart.hidden=YES;
        }
        for (UILabel* lab in self.labViews) {
            lab.hidden=YES;
        }
        [self.pieChartMonth setDataSource:self];
        [self.pieChartMonth setStartPieAngle:M_PI_2];
        [self.pieChartMonth setAnimationSpeed:1.0];
        [self.pieChartMonth setLabelFont:[UIFont fontWithName:@"STHeitik-Light" size:20]];
        [self.pieChartMonth setLabelRadius:60];
        [self.pieChartMonth setShowPercentage:NO];
        [self.pieChartMonth setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
        //[self.pieChartMonth setPieCenter:CGPointMake(240, 240)];
        [self.pieChartMonth setUserInteractionEnabled:NO];
        //[self.pieChartMonth setLabelShadowColor:[UIColor blackColor]];
    } else {
        self.pieChartMonth.hidden=YES;
        //self.yearCollectionView.hidden=NO;
        for (XYPieChart* chart in self.yearViews) {
            chart.hidden=NO;
        }
        for (UILabel* lab in self.labViews) {
            lab.hidden=NO;
        }
        //[self.view addSubview:self.yearCollectionView];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadStatistics];
    [self.pieChartMonth reloadData];
    for (XYPieChart* chart in self.yearViews) {
        [chart reloadData];
    }
}


#pragma mark - XYPieChartDataSource
-(NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart {
    return 3;
}

-(CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index {
    if (pieChart==self.pieChartMonth) {
        return [[self.monthStatistics objectAtIndex:index+1] floatValue];
    }
    else if([self.yearViews indexOfObject:pieChart]!=NSNotFound) {
        NSMutableArray* arrayMonth=[self.yearStatistics objectAtIndex:[self.yearViews indexOfObject:pieChart]+1];
        CGFloat f=[[arrayMonth objectAtIndex:index+1] floatValue];
        return f;
    }
    return 0;
}

-(UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index {
    return [self.sliceColors objectAtIndex:index];
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
