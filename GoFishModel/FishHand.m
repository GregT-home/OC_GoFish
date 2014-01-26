//
//  FishHand.m
//  GoFishModel
//
//  Created by Greg Tarsa on 1/24/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "FishCard.h"
#import "FishHand.h"

@interface FishHand()
// declare our cards so that they are not visible, similar to an instance variable in Ruby
// nonatomic: value can be returned without regard to multi-threading.
// strong: use automatic reference counting (ARC) with this item.
@property (nonatomic, strong) NSMutableArray *cards;

// "private" method
- (void) removeThisRank:(NSString *)rank;

@end

@implementation FishHand

- (instancetype)initWithEmptyHand {
    self = [super init];
    if (self)
        _cards = [NSMutableArray new];
    return self;
}
+ (instancetype)newWithEmptyHand {
    return [[self alloc] initWithEmptyHand];
}

+ (instancetype)newWithStackedCards:(NSMutableArray *)stackedHandCards {
//    self = [[self alloc] newWithEmptyHand];
  //  [self.cards addObjectsFromArray:stackedHandCards];
    //return self;
    return nil;
}

- (NSNumber *)numberOfCards {
    return @([_cards count]);
}

- (NSNumber *)rankCount:(NSString *)targetRank {
    int matches = 0;
    
    for (FishCard *card in _cards) {
        if ([card.rank compare:targetRank] == NSOrderedSame) matches++;
    }
    return @(matches);
    
    /*
    NSPredicate *target = [NSPredicate predicateWithFormat:@"SELF == %@", targetRank];
    
    NSArray *array = [_cards filteredArrayUsingPredicate:target];
    
    return @([array count]);
     */
}

- (BOOL) gotBook:(NSString *)rank {
    return [self rankCount:rank] > 0;
}

- (void)receiveCards:(NSMutableArray *)newCards{
    [_cards addObjectsFromArray:newCards];
}
    
- (NSMutableArray *)giveMatchingCards:(NSString *)targetRank {
    
    NSLog(@"In giveMatchingCards(%@)", targetRank);
    NSMutableArray *matchingCards = [NSMutableArray new];
    int matches = 0;
    
    for (FishCard *card in _cards) {
        NSLog(@"card.rank = %@ and targetRank = %@", card.rank, targetRank);
        if ([card.rank compare:targetRank] == NSOrderedSame){
            [matchingCards addObject:card];
            matches++;
        }
    }
    NSLog(@"found %@", @(matches));
    [self removeThisRank:targetRank];

    return matchingCards;

    /*
    NSPredicate *target = [NSPredicate predicateWithFormat:@"SELF == %@", rank];
    NSMutableArray *matches = [[_cards filteredArrayUsingPredicate:target] mutableCopy];
    [self removeThisRank:rank];
    return matches;
     */
}

- (void) sort {
    [_cards sortUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        return [(FishCard *)obj1 compare: (FishCard *)obj2];
    }];
}

- (void)removeThisRank:(NSMutableArray *)rank{
    NSPredicate *allButTarget = [NSPredicate predicateWithFormat:@"SELF != %@", rank];
    [_cards filterUsingPredicate:allButTarget];
}

- (NSString *) toString {
    NSMutableString *result = [@"[" mutableCopy];
    
    for (FishCard *card in _cards) {
        [result appendString: [card toString]];
        [result appendString:@" "];
    }
    [result replaceCharactersInRange: NSMakeRange([result length] - 1, 1) withString:@"]"];
    
    return [NSString stringWithString:result];
}
@end
