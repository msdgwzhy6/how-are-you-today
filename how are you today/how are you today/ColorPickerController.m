//
//  ColorPickerController.m
//  how are you today
//
//  Created by 高阳 on 15/10/9.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import "ColorPickerController.h"

@interface ColorPickerController ()

@end

@implementation ColorPickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIImage* im1=[[UIImage imageNamed:@"ColorSet1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* im2=[[UIImage imageNamed:@"ColorSet2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage* im3=[[UIImage imageNamed:@"ColorSet3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [self.colorSet1 setImage:im1 forState:UIControlStateNormal];
    [self.colorSet1 addTarget:self action:@selector(selectColor1) forControlEvents:UIControlEventTouchUpInside];
    [self.colorSet2 setImage:im2 forState:UIControlStateNormal];
    [self.colorSet2 addTarget:self action:@selector(selectColor2) forControlEvents:UIControlEventTouchUpInside];
    [self.colorSet3 setImage:im3 forState:UIControlStateNormal];
    [self.colorSet3 addTarget:self action:@selector(selectColor3) forControlEvents:UIControlEventTouchUpInside];
    
    self.imOK1.image=[UIImage imageNamed:@"OK"];
    self.imOK2.image=[UIImage imageNamed:@"OK"];
    self.imOK3.image=[UIImage imageNamed:@"OK"];
    self.imOK1.hidden=YES;
    self.imOK2.hidden=YES;
    self.imOK3.hidden=YES;
}

- (void)viewDidAppear:(BOOL)animated {
    NSInteger defaultChoice=[[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultColorSet"] integerValue];
    switch (defaultChoice) {
        case 1:
            self.imOK1.hidden=NO;
            self.imOK2.hidden=YES;
            self.imOK3.hidden=YES;
            break;
        case 2:
            self.imOK1.hidden=YES;
            self.imOK2.hidden=NO;
            self.imOK3.hidden=YES;
            break;
        case 3:
            self.imOK1.hidden=YES;
            self.imOK2.hidden=YES;
            self.imOK3.hidden=NO;
            break;
            
        default:
            break;
    }
}

- (void)selectColor1 {
    NSInteger choice=1;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:choice] forKey:@"defaultColorSet"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorChanged" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectColor2 {
    NSInteger choice=2;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:choice] forKey:@"defaultColorSet"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorChanged" object:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)selectColor3 {
    NSInteger choice=3;
    [[NSUserDefaults standardUserDefaults] setValue:[NSNumber numberWithInteger:choice] forKey:@"defaultColorSet"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"colorChanged" object:nil];
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
