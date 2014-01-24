//
//  DeckTests.m
//  DeckTests
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "Card.h"
#import "Deck.h"

SPEC_BEGIN(DeckTests)

describe(@"GoFish Model: Deck Class Creation and Basic Function", ^{
    __block Deck *deck, *shuffled;
    
    beforeEach(^{ // Occurs before each enclosed "it"
        deck = [Deck newWithCards];
        shuffled = [Deck newWithCards];
    });
    /* What is the right format for this class check?
     it(@"newWithCards creates a new deck", ^{
     [[deck should] beKindOfClass:(Class)Deck];
     });
     */

    it(@"creates new deck with 52 cards", ^{
        [[@(deck.count) should] equal:@52];
    });

    
    it(@"new decks should be contain the same cards", ^{
        //how to iterate over two decks in tandem?
    });
});


SPEC_END
