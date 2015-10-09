//
//  WelcomeViewController.m
//  
//
//  Created by 高阳 on 15/9/27.
//
//

#import "WelcomeViewController.h"

@interface WelcomeViewController () <UITextFieldDelegate>

@property(strong,nonatomic) UIButton* fantasticButton;
@property(strong,nonatomic) UIButton* ordinaryButton;
@property(strong,nonatomic) UIButton* terribleButton;
@property(strong,nonatomic) UIView* fantasticView;
@property(strong,nonatomic) UIView* ordinaryView;
@property(strong,nonatomic) UIView* terribleView;

@property(assign,nonatomic) emotionType emotion;
@property(copy,nonatomic) NSString* comment;

@end

@implementation WelcomeViewController

static UIColor* fantasticColor;
static UIColor* ordinaryColor;
static UIColor* terribleColor;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setColors];
    [self loadSubviews];
    // Do any additional setup after loading the view.
}

- (void)dismissSelf {
    [self.delegate hasChosenEmotion:self.emotion comment:self.comment forDay:self.date];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - color set and get

- (void)setColors {
    NSInteger userColor=[[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultColorSet"] integerValue];
    switch (userColor) {
        case 1:
            fantasticColor=[UIColor colorWithRed:252/255.0 green:118/255.0 blue:7/255.0 alpha:1];
            ordinaryColor=[UIColor colorWithRed:239/255.0 green:206/255.0 blue:125/255.0 alpha:1];
            terribleColor=[UIColor colorWithRed:238/255.0 green:236/255.0 blue:188/255.0 alpha:1];
            break;
        case 2:
            fantasticColor=[UIColor colorWithRed:240/255.0 green:116/255.0 blue:132/255.0 alpha:1];
            ordinaryColor=[UIColor colorWithRed:178/255.0 green:218/255.0 blue:199/255.0 alpha:1];
            terribleColor=[UIColor colorWithRed:245/255.0 green:193/255.0 blue:148/255.0 alpha:1];
            break;
        case 3:
            fantasticColor=[UIColor colorWithRed:255/255.0 green:74/255.0 blue:121/255.0 alpha:1];
            ordinaryColor=[UIColor colorWithRed:232/255.0 green:179/255.0 blue:145/255.0 alpha:1];
            terribleColor=[UIColor colorWithRed:255/255.0 green:233/255.0 blue:163/255.0 alpha:1];
            break;
            
        default:
            break;
    }
}

+ (UIColor*) getFantasticColor {
    NSInteger userColor=[[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultColorSet"] integerValue];
    switch (userColor) {
        case 1:
            return [UIColor colorWithRed:252/255.0 green:118/255.0 blue:7/255.0 alpha:1];
            break;
        case 2:
            return [UIColor colorWithRed:240/255.0 green:116/255.0 blue:132/255.0 alpha:1];
            break;
        case 3:
            return [UIColor colorWithRed:255/255.0 green:74/255.0 blue:121/255.0 alpha:1];
            break;
            
        default:
            return nil;
            break;
    }
}

+ (UIColor*) getOrdinaryColor {
    NSInteger userColor=[[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultColorSet"] integerValue];
    switch (userColor) {
        case 1:
            return [UIColor colorWithRed:239/255.0 green:206/255.0 blue:125/255.0 alpha:1];
            break;
        case 2:
            return [UIColor colorWithRed:178/255.0 green:218/255.0 blue:199/255.0 alpha:1];
            break;
        case 3:
            return [UIColor colorWithRed:232/255.0 green:179/255.0 blue:145/255.0 alpha:1];
            break;
            
        default:
            return nil;
            break;
    }
}

+ (UIColor*) getTerribleColor {
    NSInteger userColor=[[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultColorSet"] integerValue];
    switch (userColor) {
        case 1:
            return [UIColor colorWithRed:238/255.0 green:236/255.0 blue:188/255.0 alpha:1];
            break;
        case 2:
            return [UIColor colorWithRed:245/255.0 green:193/255.0 blue:148/255.0 alpha:1];
            break;
        case 3:
            return [UIColor colorWithRed:255/255.0 green:233/255.0 blue:163/255.0 alpha:1];
            break;
            
        default:
            return nil;
            break;
    }
}

#pragma mark - load subviews

- (void)loadSubviews {
    UIView* rootView=self.view;
    CGFloat buttonHeight=rootView.frame.size.height/3;
    
    //first button
    self.fantasticButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.fantasticButton setFrame:CGRectMake(rootView.frame.origin.x, rootView.frame.origin.y, rootView.frame.size.width, buttonHeight)];
    [self.fantasticButton setBackgroundColor:fantasticColor];
    NSAttributedString* fantasticTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Fantastic"] attributes:@{
            NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:45],
            NSForegroundColorAttributeName:[UIColor whiteColor]             }];
    [self.fantasticButton setAttributedTitle:fantasticTitle forState:UIControlStateNormal];
    [self.fantasticButton addTarget:self action:@selector(addFantasticView) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:self.fantasticButton];
    
    //second button
    self.ordinaryButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.ordinaryButton setFrame:CGRectMake(rootView.frame.origin.x, rootView.frame.origin.y+buttonHeight, rootView.frame.size.width, buttonHeight)];
    [self.ordinaryButton setBackgroundColor:ordinaryColor];
    NSAttributedString* ordinaryTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Ordinary"] attributes:@{
            NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:45],
            NSForegroundColorAttributeName:[UIColor whiteColor]             }];
    [self.ordinaryButton setAttributedTitle:ordinaryTitle forState:UIControlStateNormal];
    [self.ordinaryButton addTarget:self action:@selector(addOrdinaryView) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:self.ordinaryButton];
    
    //third button
    self.terribleButton=[UIButton buttonWithType:UIButtonTypeSystem];
    [self.terribleButton setFrame:CGRectMake(rootView.frame.origin.x, rootView.frame.origin.y+2*buttonHeight, rootView.frame.size.width, buttonHeight)];
    [self.terribleButton setBackgroundColor:terribleColor];
    NSAttributedString* terribleTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Terrible"] attributes:@{
            NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:45],
            NSForegroundColorAttributeName:[UIColor whiteColor]             }];
    [self.terribleButton setAttributedTitle:terribleTitle forState:UIControlStateNormal];
    [self.terribleButton addTarget:self action:@selector(addTerribleView) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:self.terribleButton];
    
    //X button
    UIButton* Xbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    [Xbutton setFrame:CGRectMake(rootView.frame.size.width-35, 20, 30, 30)];
    UIImage* Ximg=[[UIImage imageNamed:@"Xbutton"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [Xbutton setBackgroundImage:Ximg forState:UIControlStateNormal];
    [Xbutton setTintColor:[UIColor whiteColor]];
    [Xbutton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
    [rootView addSubview:Xbutton];
    
}

#pragma mark - load and remove fantastic view
- (void)addFantasticView {
    self.fantasticView=[[UIView alloc] initWithFrame:self.fantasticButton.frame];
    self.fantasticView.backgroundColor=fantasticColor;
    [self.view addSubview:self.fantasticView];
    [UIView animateWithDuration:0.6 animations:^{
        [self.fantasticView setFrame:self.view.frame];
    } completion:^(BOOL finished){
        UILabel* fantasticLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+25, self.view.frame.origin.y, self.view.frame.size.width-35, self.view.frame.size.height/3)];
        [fantasticLabel setTextAlignment:NSTextAlignmentLeft];
        fantasticLabel.numberOfLines=0;
        NSAttributedString* fantasticTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Wow!\nYou have a fantastic day!\nYou must tell me about it"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:25],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [fantasticLabel setAttributedText:fantasticTitle];
        [self.fantasticView addSubview:fantasticLabel];
        
        UITextField* textField=[[UITextField alloc] initWithFrame:CGRectMake(fantasticLabel.frame.origin.x, fantasticLabel.frame.origin.y+fantasticLabel.frame.size.height, fantasticLabel.frame.size.width-10, fantasticLabel.frame.size.height/2)];
        [textField.layer setBorderWidth:1.0];
        [textField.layer setBorderColor:[UIColor whiteColor].CGColor];
        [textField setBorderStyle:UITextBorderStyleBezel];
        [self.fantasticView addSubview:textField];
        textField.textColor=[UIColor whiteColor];
        textField.returnKeyType=UIReturnKeyDone;
        textField.font=[UIFont fontWithName:@"STHeitik-Light" size:20];
        textField.textColor=[UIColor whiteColor];
        textField.delegate=self;
        
        CGFloat detailButtonY=self.view.frame.size.height/2+80;
        CGFloat detailButtonX=self.view.frame.size.width/4;
        CGFloat detailButtonW=self.view.frame.size.width/2;
        CGFloat detailButtonH=40;
        UIButton* detailButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [detailButton setFrame:CGRectMake(detailButtonX, detailButtonY, detailButtonW, detailButtonH)];
        [detailButton setBackgroundColor:fantasticColor];
        [detailButton.layer setBorderWidth:1.0];
        [detailButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        NSAttributedString* detailButtonTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Done"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:20],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [detailButton setAttributedTitle:detailButtonTitle forState:UIControlStateNormal];
        [detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [detailButton.layer setCornerRadius:10.0];
        [detailButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [self.fantasticView addSubview:detailButton];
        
        CGFloat reselectButtonY=self.view.frame.size.height/2+140;
        CGFloat reselectButtonX=self.view.frame.size.width/4;
        CGFloat reselectButtonW=self.view.frame.size.width/2;
        CGFloat reselectButtonH=40;
        UIButton* reselectButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [reselectButton setFrame:CGRectMake(reselectButtonX, reselectButtonY, reselectButtonW, reselectButtonH)];
        [reselectButton setBackgroundColor:fantasticColor];
        [reselectButton.layer setBorderWidth:1.0];
        [reselectButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        NSAttributedString* reselectButtonTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Back"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:20],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [reselectButton setAttributedTitle:reselectButtonTitle forState:UIControlStateNormal];
        [reselectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reselectButton.layer setCornerRadius:10.0];
        [reselectButton addTarget:self action:@selector(removeFantasticView) forControlEvents:UIControlEventTouchUpInside];
        [self.fantasticView addSubview:reselectButton];
        self.emotion=EmotionTypeFantastic;
        [self setValue:textField.text forKey:@"comment"];
        NSLog(@"%@",textField.text);
    }];
    
}

- (void)removeFantasticView {
    [UIView animateWithDuration:0.6 animations:^{
        [self.fantasticView setFrame:self.fantasticButton.frame];
        [[self.fantasticView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    } completion:^(BOOL finished){
        self.emotion=0;
        self.comment=nil;
        [self.fantasticView removeFromSuperview];
    }];
    
}

#pragma mark - load and remove ordinary view

- (void)addOrdinaryView {
    self.ordinaryView=[[UIView alloc] initWithFrame:self.ordinaryButton.frame];
    self.ordinaryView.backgroundColor=ordinaryColor;
    [self.view addSubview:self.ordinaryView];
    [UIView animateWithDuration:0.6 animations:^{
        [self.ordinaryView setFrame:self.view.frame];
    } completion:^(BOOL finished){
        UILabel* ordinaryLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+25, self.view.frame.origin.y, self.view.frame.size.width-35, self.view.frame.size.height/3)];
        [ordinaryLabel setTextAlignment:NSTextAlignmentLeft];
        ordinaryLabel.numberOfLines=0;
        NSAttributedString* ordinaryTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Emm...\nAn ordinary day, isn't it\nWhat have you done today?"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:25],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [ordinaryLabel setAttributedText:ordinaryTitle];
        [self.ordinaryView addSubview:ordinaryLabel];
        
        UITextField* textField=[[UITextField alloc] initWithFrame:CGRectMake(ordinaryLabel.frame.origin.x, ordinaryLabel.frame.origin.y+ordinaryLabel.frame.size.height, ordinaryLabel.frame.size.width-10, ordinaryLabel.frame.size.height/2)];
        [textField.layer setBorderWidth:1.0];
        [textField.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.ordinaryView addSubview:textField];
        textField.returnKeyType=UIReturnKeyDone;
        textField.font=[UIFont fontWithName:@"STHeitik-Light" size:20];
        textField.textColor=[UIColor whiteColor];
        textField.delegate=self;
        
        CGFloat detailButtonY=self.view.frame.size.height/2+80;
        CGFloat detailButtonX=self.view.frame.size.width/4;
        CGFloat detailButtonW=self.view.frame.size.width/2;
        CGFloat detailButtonH=40;
        UIButton* detailButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [detailButton setFrame:CGRectMake(detailButtonX, detailButtonY, detailButtonW, detailButtonH)];
        [detailButton setBackgroundColor:ordinaryColor];
        [detailButton.layer setBorderWidth:1.0];
        [detailButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        NSAttributedString* detailButtonTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Done"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:20],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [detailButton setAttributedTitle:detailButtonTitle forState:UIControlStateNormal];
        [detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [detailButton.layer setCornerRadius:10.0];
        [detailButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [self.ordinaryView addSubview:detailButton];
        
        CGFloat reselectButtonY=self.view.frame.size.height/2+140;
        CGFloat reselectButtonX=self.view.frame.size.width/4;
        CGFloat reselectButtonW=self.view.frame.size.width/2;
        CGFloat reselectButtonH=40;
        UIButton* reselectButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [reselectButton setFrame:CGRectMake(reselectButtonX, reselectButtonY, reselectButtonW, reselectButtonH)];
        [reselectButton setBackgroundColor:ordinaryColor];
        [reselectButton.layer setBorderWidth:1.0];
        [reselectButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        NSAttributedString* reselectButtonTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Back"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:20],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [reselectButton setAttributedTitle:reselectButtonTitle forState:UIControlStateNormal];
        [reselectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reselectButton.layer setCornerRadius:10.0];
        [reselectButton addTarget:self action:@selector(removeOrdinaryView) forControlEvents:UIControlEventTouchUpInside];
        [self.ordinaryView addSubview:reselectButton];
        self.emotion=EmotionTypeOrdinary;
        self.comment=textField.text;
    }];

}

- (void)removeOrdinaryView {
    [UIView animateWithDuration:0.6 animations:^{
        [self.ordinaryView setFrame:self.ordinaryButton.frame];
        [[self.ordinaryView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    } completion:^(BOOL finished){
        self.emotion=0;
        self.comment=nil;
        [self.ordinaryView removeFromSuperview];
    }];
}

#pragma mark - load and remove terrible view

- (void)addTerribleView {
    self.terribleView=[[UIView alloc] initWithFrame:self.terribleButton.frame];
    self.terribleView.backgroundColor=terribleColor;
    [self.view addSubview:self.terribleView];
    [UIView animateWithDuration:0.6 animations:^{
        [self.terribleView setFrame:self.view.frame];
    } completion:^(BOOL finished){
        UILabel* terribleLabel=[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+25, self.view.frame.origin.y, self.view.frame.size.width-35, self.view.frame.size.height/3)];
        [terribleLabel setTextAlignment:NSTextAlignmentLeft];
        terribleLabel.numberOfLines=0;
        NSAttributedString* terribleTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Sorry...\nBut you can tell me\nMaybe it will help"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:25],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [terribleLabel setAttributedText:terribleTitle];
        [self.terribleView addSubview:terribleLabel];
        
        UITextField* textField=[[UITextField alloc] initWithFrame:CGRectMake(terribleLabel.frame.origin.x, terribleLabel.frame.origin.y+terribleLabel.frame.size.height, terribleLabel.frame.size.width-10, terribleLabel.frame.size.height/2)];
        [textField.layer setBorderWidth:1.0];
        [textField.layer setBorderColor:[UIColor whiteColor].CGColor];
        [self.terribleView addSubview:textField];
        textField.returnKeyType=UIReturnKeyDone;
        textField.font=[UIFont fontWithName:@"STHeitik-Light" size:20];
        textField.textColor=[UIColor whiteColor];
        textField.delegate=self;
        
        CGFloat detailButtonY=self.view.frame.size.height/2+80;
        CGFloat detailButtonX=self.view.frame.size.width/4;
        CGFloat detailButtonW=self.view.frame.size.width/2;
        CGFloat detailButtonH=40;
        UIButton* detailButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [detailButton setFrame:CGRectMake(detailButtonX, detailButtonY, detailButtonW, detailButtonH)];
        [detailButton setBackgroundColor:terribleColor];
        [detailButton.layer setBorderWidth:1.0];
        [detailButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        NSAttributedString* detailButtonTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Done"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:20],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [detailButton setAttributedTitle:detailButtonTitle forState:UIControlStateNormal];
        [detailButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [detailButton.layer setCornerRadius:10.0];
        [detailButton addTarget:self action:@selector(dismissSelf) forControlEvents:UIControlEventTouchUpInside];
        [self.terribleView addSubview:detailButton];
        
        CGFloat reselectButtonY=self.view.frame.size.height/2+140;
        CGFloat reselectButtonX=self.view.frame.size.width/4;
        CGFloat reselectButtonW=self.view.frame.size.width/2;
        CGFloat reselectButtonH=40;
        UIButton* reselectButton=[UIButton buttonWithType:UIButtonTypeSystem];
        [reselectButton setFrame:CGRectMake(reselectButtonX, reselectButtonY, reselectButtonW, reselectButtonH)];
        [reselectButton setBackgroundColor:terribleColor];
        [reselectButton.layer setBorderWidth:1.0];
        [reselectButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        NSAttributedString* reselectButtonTitle=[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"Back"] attributes:@{
                NSFontAttributeName:[UIFont fontWithName:@"STHeitik-Light" size:20],
                NSForegroundColorAttributeName:[UIColor whiteColor]             }];
        [reselectButton setAttributedTitle:reselectButtonTitle forState:UIControlStateNormal];
        [reselectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [reselectButton.layer setCornerRadius:10.0];
        [reselectButton addTarget:self action:@selector(removeTerribleView) forControlEvents:UIControlEventTouchUpInside];
        [self.terribleView addSubview:reselectButton];
        self.emotion=EmotionTypeTerrible;
        self.comment=textField.text;
    }];

}

- (void)removeTerribleView {
    [UIView animateWithDuration:0.6 animations:^{
        [self.terribleView setFrame:self.terribleButton.frame];
        [[self.terribleView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    } completion:^(BOOL finished){
        self.emotion=0;
        self.comment=nil;
        [self.terribleView removeFromSuperview];
    }];
}

#pragma mark - textfield protocol
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.comment=textField.text;
    return YES;
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
