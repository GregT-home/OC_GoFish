//
//  Card.m
//  GoFish Model
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Card.h"

@implementation Card
+ (instancetype)newWithRank:(NSString *)rank suit:(NSString *)suit  {
    return [[self alloc] initWithRank:rank suit:suit];
    }
- (instancetype)initWithRank:(NSString *)rank suit:(NSString *)suit {
    self = [super init];
    if(self) {
        _rank = rank;
        _suit = suit;
    }
    return self;
}

@end
