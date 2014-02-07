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

+ (instancetype)newStackedDeck {
    return[[self alloc] initStackedDeck];
}

- (instancetype)initStackedDeck {
    self = [super init];
    if (self) {
        // stack a deck for three known hands and an extra card
        self.cards = [NSMutableArray new];
        NSArray *rankSuit = [@"2 C 2 H 3 C Q H 5 C 4 H 9 H "
                             @"2 S 2 D 3 S 3 D 5 S 4 D 9 C "
                             @"10 C 10 H 10 S 10 D A C A H 9 S "
                             @"3 H" componentsSeparatedByString:@" "];
        
        for (int i = 0; i < [rankSuit count] - 1; i = i + 2)
            [_cards addObject:[FishCard newWithRank:rankSuit[i] suit:rankSuit[i+1]]];
    }
    return self;
}

- (void)createCards {
    self.cards = [NSMutableArray new];
    for (NSString *suit in SUITS) {
        for (NSString *rank in RANKS) {
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

- (FishCard *)giveCard {
    FishCard *card = [self.cards count] > 0 ? [self.cards objectAtIndex:0] : nil;

    if (card != nil)
        [self.cards removeObjectAtIndex:0];

    return card;
}

- (void)receiveCard:(FishCard *)newcard {
    [self.cards insertObject:newcard atIndex:[self.cards count] - 1];
}

@end
