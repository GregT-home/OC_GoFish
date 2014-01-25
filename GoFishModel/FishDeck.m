//
//  FishDeck.m
//  GoFishModel
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "FishDeck.h"
#import "FishCard.h"

@interface FishDeck()
// declare a Cards property so that they are not visible
// similar to an instance variable in Ruby
@property (nonatomic, strong) NSMutableArray *cards;
@end


@implementation FishDeck
+ (instancetype)newWithCards {
    return[[self alloc] initWithCards];
}

- (instancetype)initWithCards {
    self = [super init];
    if (self) {
        [self createCards];
    }
    [self createCards]; /* is this OK to do? */
    return self;
}

- (void)createCards {
    // below is shorthand equiv for:    [self setCards:[NSMutableArray new]];
    self.cards = [NSMutableArray new];
    for (NSString *rank in RANKS) {
        for (NSString *suit in SUITS) {
            [self.cards addObject:[FishCard newWithRank:rank suit:suit]];
        }
    }
}

- (NSNumber *)numberOfCards   {
    return @([self.cards count]);
}

- (BOOL)isEqual:(FishDeck *)aDeck {
    __block BOOL result;
    [self.cards enumerateObjectsUsingBlock:^(FishCard *card, NSUInteger i, BOOL *stopearly) {
        result = [card isEqual:[aDeck.cards objectAtIndex:i]];
        if (!result)
            *stopearly = YES;
    }];
    return result;
}

- (void)shuffle {
    {
        int count = [[self numberOfCards] intValue];
        for (int i = 0; i < count; ++i) {
            // Select a random element between i and end of array to swap with.
            int nElements = count - i;
            int n = arc4random_uniform(nElements) + i;
            [self.cards exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
    }
}

- (FishCard *)give_card {
    FishCard *card = [self.cards firstObject];
    [self.cards removeObjectAtIndex:0];
    return card;
}

- (void)receive_card:(FishCard *)newcard {
    [self.cards insertObject:newcard atIndex:[self.cards count] - 1];
}

@end
