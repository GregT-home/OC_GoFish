//
//  Deck.h
//  GoFishModel
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject
+ (instancetype)newWithCards;
- (instancetype)initWithCards;
- (NSNumber *)numberOfCards;
- (void)shuffle;
- (Card *)give_card;
- (void)receive_card:(Card *)newcard;

@end