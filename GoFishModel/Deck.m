//
//  Deck.m
//  GoFishModel
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Deck.h"
#import "Card.h"

@interface Deck()
// declare a Cards property so that they are not visible
// similar to an instance variable in Ruby
@property (nonatomic, strong) NSMutableArray *cards;
@end


@implementation Deck

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createCards];
    }
    return self;
}

- (void)createCards {
// below is shorthand equiv for:    [self setCards:[NSMutableArray new]];
    self.cards = [NSMutableArray new];
    for (NSString *rank in [Deck ranks]) {
        for (NSString *suit in [Deck suits]) {
            [self.cards addObject:[Card newWithRank:rank suit:suit]];
        }
    }
}

+ (NSArray *)ranks {
    return @[@"2",  @"3",  @"4",  @"5",  @"6",  @"7",  @"8",  @"9",  @"J",  @"Q",  @"K",  @"A"];
}
+ (NSArray *)suits {
    return @[@"C",  @"D",  @"S",  @"S",  @"H"];
}

@end
