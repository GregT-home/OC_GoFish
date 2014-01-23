//
//  Card.h
//  GoFish Model
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property NSString *rank;
@property NSString *suit;

+ (id)newWithRank:(NSString *)rank suit:(NSString *)suit;
- (instancetype)initWithRank:(NSString *)rank suit:(NSString *)suit;

/* from Christian's code*/
/* +(instancetype)newWithRank */

@end
