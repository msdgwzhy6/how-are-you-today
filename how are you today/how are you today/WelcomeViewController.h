//
//  WelcomeViewController.h
//  
//
//  Created by 高阳 on 15/9/27.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, emotionType){
    EmotionTypeFantastic = 1,
    EmotionTypeOrdinary,
    EmotionTypeTerrible
};

@protocol selectEmotionProtocal

@required
- (void)hasChosenEmotion:(emotionType)emotion comment:(NSString*)comment forDay:(NSDate*)date;

@end

@interface WelcomeViewController : UIViewController

@property(weak,nonatomic) id<selectEmotionProtocal> delegate;
@property(strong,nonatomic) NSDate* date;

+ (UIColor*) getFantasticColor;
+ (UIColor*) getOrdinaryColor;
+ (UIColor*) getTerribleColor;

@end
