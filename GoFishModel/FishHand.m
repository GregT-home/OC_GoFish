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
        self.cards = [NSMutableArray new];
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
    return @([self.cards count]);
}

- (NSNumber *)rankCount:(NSString *)targetRank {
    int matches = 0;
    
    for (FishCard *card in self.cards) {
        if ([card.rank compare:targetRank] == NSOrderedSame) matches++;
    }
    return @(matches);
    
    /*
     NSPredicate *target = [NSPredicate predicateWithFormat:@"SELF == %@", targetRank];
     
     NSArray *array = [self.cards filteredArrayUsingPredicate:target];
     
     return @([array count]);
     */
}

- (BOOL) gotBook:(NSString *)rank {
    return [self rankCount:rank] > 0;
}

- (void)receiveCards:(NSMutableArray *)newCards{
    [self.cards addObjectsFromArray:newCards];
}

- (NSMutableArray *)giveMatchingCards:(NSString *)targetRank {
    NSMutableArray *matchingCards = [NSMutableArray new];
    int matches = 0;
    
    for (FishCard *card in self.cards) {
        if ([card.rank compare:targetRank] == NSOrderedSame){
            [matchingCards addObject:card];
            matches++;
        }
    }
    [self removeThisRank:targetRank];
    return matchingCards;
}

- (void) sort {
    [self.cards sortUsingComparator: ^NSComparisonResult(id obj1, id obj2) {
        return [(FishCard *)obj1 compare: (FishCard *)obj2];
    }];
}

- (void)removeThisRank:(NSString *)targetRank{
    NSMutableArray *resulting_cards = [self.cards mutableCopy];
    
    for (FishCard *card in self.cards) {
        if ([card.rank compare:targetRank] == NSOrderedSame)
            [resulting_cards removeObject:card];
        
    }
    self.cards = resulting_cards;
}

- (NSString *) toString {
    NSMutableString *result = [@"[" mutableCopy];
    
    for (FishCard *card in self.cards) {
        [result appendString: [card toString]];
        [result appendString:@" "];
    }
    [result replaceCharactersInRange: NSMakeRange([result length] - 1, 1) withString:@"]"];
    
    return [NSString stringWithString:result];
}
@end
