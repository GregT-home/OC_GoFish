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
    context(@"Create a number of sample cards from NSString rank/suit names", ^{
        __block Deck *deck, *shuffledDeck;
        
        beforeEach(^{ // Occurs before each enclosed "it"
            deck = [Deck newWithCards];
        });
        
        it(@"creates new cards from NSString values", ^{
            [[deck should] beKindOfClass:[Deck class]];
        });
        
        it(@"creates new deck with 52 cards", ^{
            [[deck.numberOfCards should] equal:@52];
        });
        
        it(@"new decks have cards in the same order", ^{
            shuffledDeck = [Deck newWithCards];
            [[deck should] equal:shuffledDeck];
        });
        
        it(@"shuffling should change the order", ^{
            shuffledDeck = [Deck newWithCards];
            [shuffledDeck shuffle];
            [[deck shouldNot] equal:shuffledDeck];
        });

        it(@".give_card gives the first card from the deck", ^{
            int deckSize = [[deck numberOfCards] intValue];
            Card *firstCard = [deck give_card];
            [[theValue(deckSize) should] equal:theValue([[deck numberOfCards] intValue] + 1)];
            [[firstCard should] equal:[Card newWithRank:@"2" suit:@"C"]];
        });

        it(@".receive_card puts a card at the end of the deck", ^{
            int deck_size = [[deck numberOfCards] intValue];
            Card *last_card;
            Card *first_card = [deck give_card];
            
            [deck receive_card:first_card];
            [[theValue(deck_size) should] equal:@52];
            for (int i = 0;i < 52; i++ ){
                last_card = [deck give_card];
            }
        });

    }); // end deck/shuffled_deck context

    context(@"", ^{
        
    });
});


SPEC_END
