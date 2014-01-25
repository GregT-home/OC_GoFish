//
//  FishDeck.h
//  GoFishModel
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishCard.h"

@interface FishDeck : NSObject
+ (instancetype)newWithCards;
- (instancetype)initWithCards;
- (NSNumber *)numberOfCards;
- (void)shuffle;
- (FishCard *)give_card;
- (void)receive_card:(FishCard *)newcard;

@end