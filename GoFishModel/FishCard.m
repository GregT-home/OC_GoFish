//
//  FishCard.m
//  GoFish Model
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//º

#import "FishCard.h"

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

-(NSNumber *)cardValue {
   return @([RANKS indexOfObject:self.rank]);
}

-(NSString *) description {
    return [NSString stringWithFormat:@"%@-%@", self.rank, self.suit];
}

-(NSString *) BasicFileBaseName {
    return [[NSString stringWithFormat:@"%@%@", self.suit, self.rank] lowercaseString];
}

-(NSString *) FancyFileBaseName {
    return [[NSString stringWithFormat:@"%@%@", self.rank, self.suit] lowercaseString];
}

- (BOOL)isEqual:(id)object {
   return [[self cardValue] isEqual:[object cardValue]];
}

/*
 - (BOOL)isEqual:(id)object {
    return (self == object || ([self isKindOfClass:[object class]] && [self isEqualToPlayingCard:object]));
    }

- (BOOL)isEqualToPlayingCard:(FishCard *)card {
    return [self value] == [card value];
    //return self.rank == card.rank && self.suit == card.suit;
}
 */

- (NSComparisonResult)compare:(FishCard *)aCard {
    NSNumber *val1 = [self cardValue];
    NSNumber *val2 = [aCard cardValue];
    return [val1 compare:val2];
  }
@end
