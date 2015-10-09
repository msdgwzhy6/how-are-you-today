//
//  CalenderViewController.h
//  how are you today
//
//  Created by 高阳 on 15/9/28.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>
#import "WelcomeViewController.h"

@interface CalenderViewController : UIViewController <JTCalendarDelegate,selectEmotionProtocal>

@property (strong,nonatomic) JTCalendarMenuView *calendarMenuView;
@property (strong,nonatomic) JTHorizontalCalendarView* calendarContentView;
@property (strong,nonatomic) JTCalendarManager* calendarManager;

@end

@protocol CalendarDataSource

@required

- (emotionType) emotionForDay: (NSDate*)day;
- (NSString*) commentForDay: (NSDate*)day;
- (void) saveEmotion: (emotionType)emotion comment: (NSString*)comment forDay: (NSDate*)day;
- (void)deleteRecord:(NSDate*)day;

@end