//
//  GamePoint.m
//  traffic
//
//  Created by Mac04 on 12/10/23.
//  Copyright 2012年 國立台北教育大學. All rights reserved.
//

#import "GamePoint.h"


@implementation GamePoint
-(id) init
{
    typeA = typeB = typeC = 0;
    return self;
}
-(void) addTypeA
{
    typeA ++;
    printf("typeA : %i--------",typeA);
}
-(void) addTypeB
{
    typeB++;
    printf("typeB : %i--------",typeB);
}
-(void) addTypeC
{
    typeC++;
    printf("typeC : %i--------",typeC);
}
-(NSString*) goToPage
{
    int num;
    NSString *name;
    
    num = typeA;
    name = @"publicCar";
    
    if (num < typeB) {
        num = typeB;
        name = @"jobCar";
    }
    if (num < typeC) {
        num = typeC;
        name = @"homeCar";
    }
    return name;
}
@end
