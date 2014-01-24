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
    for (NSString *rank in [Deck ranks]) {
        for (NSString *suit in [Deck suits]) {
            [self.cards addObject:[Card newWithRank:rank suit:suit]];
        }
    }
}

- (NSUInteger)count {
    return [self.cards count];
}

- (instancetype)shuffle {
    // how to shuffle?
    // check out: http://stackoverflow.com/questions/56648/whats-the-best-way-to-shuffle-an-nsmutablearray
    return nil;
}
- (Card *)give_card {
    // how to pop from a NSMutableArray?
    // check NSMutableArray Class Reference for this and for unshifting
    // another reference: http://saturnboy.com/2011/02/stack-queue-nsmutablearray/
    return nil;

}
- (Card *)receive_card:(Card *)newcard {
    // how to unshift from a NSMutableArray?
    return nil;
}


// make this an enum (or maybe a dictionary?)
+ (NSArray *)ranks {
    return RANKS;
    }

+ (NSArray *)suits {
    return [@"C D S H" componentsSeparatedByString:@" "];
}


@end
