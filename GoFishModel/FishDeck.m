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
// declare our cards so that they are not visible, similar to an instance variable in Ruby
// nonatomic: value can be returned without regard to multi-threading.
// strong: use automatic reference counting (ARC) with this item.
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
    return self;
}

- (void)createCards {
    // below is shorthand equiv for:    [self setCards:[NSMutableArray new]];
    // ??? is _cards equivalent to _cards?
    _cards = [NSMutableArray new];
    for (NSString *rank in RANKS) {
        for (NSString *suit in SUITS) {
            [_cards addObject:[FishCard newWithRank:rank suit:suit]];
        }
    }
}

- (NSNumber *)numberOfCards   {
    return @([_cards count]);
}

- (BOOL)isEqual:(FishDeck *)aDeck {
    __block BOOL result;
    [_cards enumerateObjectsUsingBlock:^(FishCard *card, NSUInteger i, BOOL *stopearly) {
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
            [_cards exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
    }
}

- (FishCard *)give_card {
    FishCard *card = [_cards firstObject];
    [_cards removeObjectAtIndex:0];
    return card;
}

- (void)receive_card:(FishCard *)newcard {
    [_cards insertObject:newcard atIndex:[_cards count] - 1];
}

@end
