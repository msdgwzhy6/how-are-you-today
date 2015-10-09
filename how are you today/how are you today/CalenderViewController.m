//
//  CalenderViewController.m
//  how are you today
//
//  Created by 高阳 on 15/9/28.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import "CalenderViewController.h"
#import "WelcomeViewController.h"
#import "CalendarDataSource.h"
#import "TodayStatusViewController.h"
#import "ColorPickerController.h"

@interface CalenderViewController () {
    NSDate* _dateSelected;
}

@property (strong,nonatomic) id<CalendarDataSource> datasource;

@end

@implementation CalenderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    CalendarDataSource* calendarDataSouece=[CalendarDataSource new];
    self.datasource=calendarDataSouece;
    
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(colorHasChanged) name:@"colorChanged" object:nil];
    
    //JTCalender
    _calendarManager=[JTCalendarManager new];
    _calendarManager.delegate=self;
    
    _calendarMenuView=[[JTCalendarMenuView alloc] initWithFrame:CGRectMake(0,  0.1*self.view.frame.size.height, self.view.frame.size.width, 0.1*self.view.frame.size.height)];
    [self.view addSubview:_calendarMenuView];
    
    _calendarContentView=[[JTHorizontalCalendarView alloc] initWithFrame:CGRectMake(0, 0.2*self.view.frame.size.height, self.view.frame.size.width, 0.6*self.view.frame.size.height)];
    [self.view addSubview:_calendarContentView];
    
    [_calendarManager setMenuView:_calendarMenuView];
    [_calendarManager setContentView:_calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    
    UIButton* colorPickerButton=[UIButton buttonWithType:UIButtonTypeSystem];
    UIImage* colorPickImg=[UIImage imageNamed:@"ColorPicker"];
    UIImage* renderColorPicker=[colorPickImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [colorPickerButton setImage:renderColorPicker forState:UIControlStateNormal];
    [colorPickerButton setFrame:CGRectMake(self.view.bounds.size.width-40, 40, 40, 40)];
    [self.view addSubview:colorPickerButton];
    [colorPickerButton addTarget:self action:@selector(presentColorPicker) forControlEvents:UIControlEventTouchUpInside];
                                 
}

- (void)colorHasChanged {
    [_calendarManager reload];
}

- (void)presentColorPicker {
    ColorPickerController* colorPickerVC=[ColorPickerController new];
    [colorPickerVC.view setFrame:CGRectMake(0.2*self.view.frame.size.width, 0.2*self.view.frame.size.height, 0.6*self.view.frame.size.width, 0.6*self.view.frame.size.height)];
    [self presentViewController:colorPickerVC animated:YES completion:nil];
}

#pragma mark - CalendarManager delegate

// Used to customize the appearance of dayView
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView
{
    emotionType emotionToday=[self.datasource emotionForDay:dayView.date];
    // Today
    if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        //[self.datasource saveEmotion:EmotionTypeFantastic comment:@"what" forDay:dayView.date];
        
        if (emotionToday==0) {
            //if today has not had input
            dayView.circleView.hidden = NO;
            dayView.circleView.backgroundColor = [UIColor whiteColor];
            [dayView.circleView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            [dayView.circleView.layer setBorderWidth:1.0];
            dayView.textLabel.textColor = [UIColor blackColor];
        } else {
            switch (emotionToday) {
                case EmotionTypeFantastic:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getFantasticColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                case EmotionTypeOrdinary:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getOrdinaryColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                case EmotionTypeTerrible:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getTerribleColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                default:
                    break;
            }
        }
    }
    // Selected date
//    else if(_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]){
//        dayView.circleView.hidden = NO;
//        dayView.circleView.backgroundColor = [UIColor redColor];
//        dayView.dotView.backgroundColor = [UIColor whiteColor];
//        dayView.textLabel.textColor = [UIColor whiteColor];
//    }
    // Other month
    else if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if (emotionToday==0) {
            //if today has not had input
            dayView.circleView.hidden = YES;
            dayView.circleView.backgroundColor = [UIColor whiteColor];
            //[dayView.circleView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            //[dayView.circleView.layer setBorderWidth:1.0];
            dayView.textLabel.textColor = [UIColor lightGrayColor];
        } else {
            switch (emotionToday) {
                case EmotionTypeFantastic:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getFantasticColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                case EmotionTypeOrdinary:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getOrdinaryColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                case EmotionTypeTerrible:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getTerribleColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                default:
                    break;
            }
        }

    }
    // Another day of the current month
    else{
        if (emotionToday==0) {
            //if today has not had input
            dayView.circleView.hidden = YES;
            dayView.circleView.backgroundColor = [UIColor whiteColor];
            //[dayView.circleView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
            //[dayView.circleView.layer setBorderWidth:1.0];
            dayView.textLabel.textColor = [UIColor blackColor];
        } else {
            switch (emotionToday) {
                case EmotionTypeFantastic:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getFantasticColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                case EmotionTypeOrdinary:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getOrdinaryColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                case EmotionTypeTerrible:
                    dayView.circleView.hidden = NO;
                    dayView.circleView.backgroundColor = [WelcomeViewController getTerribleColor];
                    dayView.textLabel.textColor = [UIColor whiteColor];
                    break;
                default:
                    break;
            }
        }

    }

    dayView.dotView.hidden = YES;
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView
{
    _dateSelected = dayView.date;
    
    // Animation for the circleView
//    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
//    [UIView transitionWithView:dayView
//                      duration:.3
//                       options:0
//                    animations:^{
//                        dayView.circleView.transform = CGAffineTransformIdentity;
//                        [_calendarManager reload];
//                    } completion:nil];
    emotionType emotionForDay=[self.datasource emotionForDay:dayView.date];
    if ([[NSDate date] compare: dayView.date]==NSOrderedDescending) {
        if (emotionForDay==0) {
            [self presentWelcomeView:dayView];

        }
        else {
            [self presentTodayStatusView:dayView];

        }
    }
    
    // Load the previous or next page if touch a day from another month
    
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}


#pragma mark - present modal view
- (void)presentWelcomeView:(JTCalendarDayView *)dayView {
    WelcomeViewController* welcomeVC=[WelcomeViewController new];
    welcomeVC.delegate=self;
    welcomeVC.date=dayView.date;
    [self presentViewController:welcomeVC animated:YES completion:nil];
}

- (void)presentTodayStatusView:(JTCalendarDayView *)dayView {
    emotionType emotionToday=[self.datasource emotionForDay:dayView.date];
    NSString* commentToday=[self.datasource commentForDay:dayView.date];
    TodayStatusViewController* todayStatusVC=[TodayStatusViewController new];
    todayStatusVC.emotion=emotionToday;
    todayStatusVC.comment=commentToday;
    todayStatusVC.date=dayView.date;
    [self presentViewController:todayStatusVC animated:YES completion:nil];
}

- (void)presentPreviousStatusView:(JTCalendarDayView *)dayView {
    
}

#pragma mark - selectEmotionProtocol
-(void)hasChosenEmotion:(emotionType)emotion comment:(NSString *)comment forDay:(NSDate *)date {
    [self.datasource saveEmotion:emotion comment:comment forDay:date];
    [_calendarManager reload];
}

#pragma mark - memory warning
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
