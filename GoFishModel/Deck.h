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
- (NSUInteger)count;
- (instancetype)shuffle;
- (Card *)give_card;
- (id)receive_card:(Card *)newcard;

@end