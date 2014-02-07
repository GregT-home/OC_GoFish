//
//  FishHand.h
//  GoFishModel
//
//  Created by Greg Tarsa on 1/24/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishCard.h"

@interface FishHand : NSObject
- (NSNumber *) numberOfCards;
- (NSNumber *) rankCount:(NSString *)targetRank;
- (void) receiveCards:(NSArray *)cards;
- (void) receiveCard:(FishCard *)card;
- (NSMutableArray *) giveMatchingCards:(NSString *)rank;
- (BOOL) gotBook:(NSString *)rank;
- (NSString *) description;
- (void) sort;
@end
