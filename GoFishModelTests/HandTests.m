//
//  HandTests.m
//  GoFishModel
//
//  Created by Greg Tarsa on 1/24/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "FishCard.h"
#import "FishDeck.h"
#import "FishHand.h"

SPEC_BEGIN(HandTests)

describe(@"GoFish Model", ^{
    __block FishHand *hand;
    
    it(@".new: can create an empty hand",^{
        hand = [FishHand new];
        [[hand should] beKindOfClass:[FishHand class]];
    });
    
    it(@".numberOfCards: new deck has 0 cards", ^{
        [[[hand numberOfCards] should] equal:@0];
    });
    
    context(@"Create a number of sample cards from NSString rank/suit names", ^{
        __block FishDeck *deck;
        __block FishHand *hand;
        __block FishCard *card;
        
        beforeEach(^{ // Occurs before each enclosed "it"
            FishDeck *deck = [FishDeck newWithCards];
            FishHand *hand = [FishHand new];
        });
        
        it(@".receiveCards: hand can receive one card", ^{
            card = [deck give_card];
            [hand receiveCards:card];
            [[[hand numberOfCards] should] equal:@1];
        });
        
        it(@".receiveCards: hand can receive multiple cards", ^{
            int starting_count = [[hand numberOfCards] intValue];
            for (int i = 0; i < 8; i++) {
                card = [deck give_card];
                [hand receiveCards:card];
            }
            [[[hand numberOfCards] should] equal:theValue(starting_count + 7)];
        });
        
        it(@".gotBook: can detect books of 4", ^{
            // [[fiveHearts should] beKindOfClass:[FishHand class]];
        });
        
        it(@".giveMatchingCards: returns array of matched cards that are removed from hand", ^{
            // [[fiveHearts should] beKindOfClass:[FishHand class]];
        });
        
        it(@".giveMatchingCards also deletes books", ^{
            // Is this redundant?  Do we need the test?
            // [[fiveHearts should] beKindOfClass:[FishHand class]];
        });
        
        it(@".toS: displays a hand as a string", ^{
            // [[fiveHearts should] beKindOfClass:[FishHand class]];
        });
        
        it(@".sort: sort a hand", ^{
            // [[fiveHearts should] beKindOfClass:[FishHand class]];
        });
    });
});

SPEC_END
