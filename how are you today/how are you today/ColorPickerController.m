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
    NSInteger defaultChoice=[[[NSUserDefaults standardUserDefaults] valueForKey:@"defaultColorSet"] integerValue];
    switch (defaultChoice) {
        case 1:
            [self.colorSet1.layer setBorderColor:[UIColor redColor].CGColor];
            [self.colorSet1.layer setBorderWidth:2.5];
            break;
        case 2:
            [self.colorSet2.layer setBorderColor:[UIColor redColor].CGColor];
            [self.colorSet1.layer setBorderWidth:2.5];
            break;
        case 3:
            [self.colorSet3.layer setBorderColor:[UIColor redColor].CGColor];
            [self.colorSet1.layer setBorderWidth:2.5];
            break;
            
        default:
            break;
    }
}

- (void)selectColor1 {
    [[NSUserDefaults standardUserDefaults] setValue:@1 forKey:@"defaultColorSet"];
}

- (void)selectColor2 {
    [[NSUserDefaults standardUserDefaults] setValue:@2 forKey:@"defaultColorSet"];
}

- (void)selectColor3 {
    [[NSUserDefaults standardUserDefaults] setValue:@3 forKey:@"defaultColorSet"];
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
