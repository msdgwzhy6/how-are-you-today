//
//  TodayStatusViewController.m
//  how are you today
//
//  Created by 高阳 on 15/10/5.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import "TodayStatusViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface TodayStatusViewController ()

@end

@implementation TodayStatusViewController

@synthesize emotion;
@synthesize comment;
@synthesize date;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel* dateLabelView=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.frame.size.width*0.8, self.view.frame.size.height*0.3)];
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString* dateString=[dateFormatter stringFromDate:self.date];
    NSAttributedString* attriburedDateString=[[NSAttributedString alloc] initWithString:dateString attributes:@{
        NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:45],
        NSForegroundColorAttributeName:[UIColor whiteColor]             }];
    [dateLabelView setAttributedText:attriburedDateString];
    [self.view addSubview:dateLabelView];
    
    UILabel* commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(30., self.view.frame.size.height*0.3, self.view.frame.size.width-60, self.view.frame.size.height*0.3)];
    [commentLabel.layer setMasksToBounds:YES];
    [commentLabel.layer setCornerRadius:10.5];
    [commentLabel.layer setBorderWidth:1.0];
    [commentLabel.layer setBorderColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"DotedImage.png"]].CGColor];
    [commentLabel.layer setBorderColor:[UIColor whiteColor].CGColor];
    NSAttributedString* commentString=[[NSAttributedString alloc] initWithString:self.comment attributes:@{
            NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:35],
            NSForegroundColorAttributeName:[UIColor whiteColor]             }];
    [commentLabel setAttributedText:commentString];
    commentLabel.numberOfLines=0;
    commentLabel.adjustsFontSizeToFitWidth=YES;
    
    CGFloat doneButtonY=self.view.frame.size.height/2+100;
    CGFloat doneButtonX=self.view.frame.size.width/4;
    CGFloat doneButtonW=self.view.frame.size.width/2;
    CGFloat doneButtonH=40;
    UIButton* doneButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [doneButton setFrame:CGRectMake(doneButtonX, doneButtonY, doneButtonW, doneButtonH)];
    [doneButton.layer setBorderWidth:1.0];
    [doneButton.layer setBorderColor:[UIColor whiteColor].CGColor];
    NSAttributedString* doneButtonTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Done"] attributes:@{
            NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:20],
            NSForegroundColorAttributeName:[UIColor whiteColor]             }];
    [doneButton setAttributedTitle:doneButtonTitle forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [doneButton.layer setCornerRadius:10.0];
    [doneButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:doneButton];

    [self.view addSubview:commentLabel];
    switch (self.emotion) {
        case EmotionTypeFantastic:
            self.view.backgroundColor=[WelcomeViewController getFantasticColor];
            dateLabelView.backgroundColor=[WelcomeViewController getFantasticColor];
            commentLabel.backgroundColor=[WelcomeViewController getFantasticColor];
            break;
        case EmotionTypeOrdinary:
            self.view.backgroundColor=[WelcomeViewController getOrdinaryColor];
            dateLabelView.backgroundColor=[WelcomeViewController getOrdinaryColor];
            commentLabel.backgroundColor=[WelcomeViewController getOrdinaryColor];
            break;
        case EmotionTypeTerrible:
            self.view.backgroundColor=[WelcomeViewController getTerribleColor];
            dateLabelView.backgroundColor=[WelcomeViewController getTerribleColor];
            commentLabel.backgroundColor=[WelcomeViewController getTerribleColor];
            break;
        default:
            break;
    }
    
    // Do any additional setup after loading the view.
}

- (void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
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
