//
//  CalendarDataSource.m
//  how are you today
//
//  Created by 高阳 on 15/10/4.
//  Copyright (c) 2015年 gaoyang. All rights reserved.
//

#import "CalendarDataSource.h"
#import "AppDelegate.h"

@interface CalendarDataSource ()

@end

@implementation CalendarDataSource

-(emotionType)emotionForDay:(NSDate *)day {
    AppDelegate* appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context=appDelegate.managedObjectContext;
    NSError* error;
    
    NSFetchRequest* request=[[NSFetchRequest new] init];
    NSEntityDescription* entityDescription=[NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];
    NSPredicate* pred=[NSPredicate predicateWithFormat:@"date == %@",day];
    [request setEntity:entityDescription];
    [request setPredicate:pred];
    NSManagedObject* theDay=nil;
    NSArray* objects=[context executeFetchRequest:request error:&error];
    emotionType emotion=0;
    if ([objects count]==0) {
        return 0;
    }
    else {
        for (NSManagedObject* obj in objects) {
            
            theDay=obj;
            emotion=[[theDay valueForKey:@"emotion"] intValue];
        }
    }
    return emotion;
}

-(NSString *)commentForDay:(NSDate *)day {
    AppDelegate* appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context=appDelegate.managedObjectContext;
    NSError* error;
    
    NSFetchRequest* request=[[NSFetchRequest new] init];
    NSEntityDescription* entityDescription=[NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];
    NSPredicate* pred=[NSPredicate predicateWithFormat:@"date == %@",day];
    [request setPredicate:pred];

    [request setEntity:entityDescription];
    NSManagedObject* theDay=nil;
    NSArray* objects=[context executeFetchRequest:request error:&error];
    NSString* comment;
    if ([objects count]==0) {
        return nil;
    }
    else {
        for (NSManagedObject* obj in objects) {
            theDay=obj;
            comment=[theDay valueForKey:@"comment"];
        }
    }
    return comment;
}

-(void)saveEmotion:(emotionType)emotion comment:(NSString *)comment forDay:(NSDate *)day {
    AppDelegate* appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context=appDelegate.managedObjectContext;
    NSError* error;
    
    NSManagedObject* theDay=[NSEntityDescription insertNewObjectForEntityForName:@"Day" inManagedObjectContext:context];

    [theDay setValue:[NSNumber numberWithInt:emotion] forKey:@"emotion"];
    [theDay setValue:comment forKey:@"comment"];
    [theDay setValue:day forKey:@"date"];
    if(![context save:&error]) {
        NSLog(@"save error");
    }
}

- (void)deleteRecord:(NSDate*)day {
    AppDelegate* appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* context=appDelegate.managedObjectContext;
    NSError* error;
    
    NSFetchRequest* request=[[NSFetchRequest new] init];
    NSEntityDescription* entityDescription=[NSEntityDescription entityForName:@"Day" inManagedObjectContext:context];
    NSPredicate* pred=[NSPredicate predicateWithFormat:@"date == %@",day];
    [request setPredicate:pred];
    
    [request setEntity:entityDescription];
    NSArray* objects=[context executeFetchRequest:request error:&error];
    for (NSManagedObject* obj in objects) {
        [context deleteObject:obj];
    }
}
@end




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

