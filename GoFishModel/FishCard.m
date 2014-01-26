//
//  FishCard.m
//  GoFish Model
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//º

#import "FishCard.h"

//    NSString *result = [NSString stringWithFormat:@"[%@]", [_cards componentsJoinedByString:@" "]];
@implementation FishCard

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

-(NSNumber *)value {
    NSNumber *v =@([RANKS indexOfObject:self.rank]);
   return v;
   // return [[NSNumber numberWithUnsignedInteger:[RANKS indexOfObject:self.rank]]]
}

-(NSString *) toString {
    return [NSString stringWithFormat:@"%@-%@", self.rank, self.suit];
}

- (BOOL)isEqual:(id)object {
    return [[self value] isEqual:[object value]];
}

- (NSComparisonResult)compare:(FishCard *)aCard {
    NSNumber *val1 = [self value];
    NSNumber *val2 = [aCard value];
    return [val1 compare:val2];
  }
@end
