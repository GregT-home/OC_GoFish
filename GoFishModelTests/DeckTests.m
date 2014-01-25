//
//  DeckTests.m
//  DeckTests
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "FishCard.h"
#import "FishDeck.h"

SPEC_BEGIN(DeckTests)

describe(@"GoFish Model: Deck Class Creation and Basic Function", ^{
    context(@"Create a number of sample cards from NSString rank/suit names", ^{
        __block FishDeck *deck, *shuffledDeck;
        
        beforeEach(^{ // Occurs before each enclosed "it"
            deck = [FishDeck newWithCards];
        });
        
        it(@"creates new cards from NSString values", ^{
            [[deck should] beKindOfClass:[FishDeck class]];
        });
        
        it(@"creates new deck with 52 cards", ^{
            [[deck.numberOfCards should] equal:@52];
        });
        
        it(@"new decks have cards in the same order", ^{
            shuffledDeck = [FishDeck newWithCards];
            [[deck should] equal:shuffledDeck];
        });
        
        it(@"shuffling should change the order", ^{
            shuffledDeck = [FishDeck newWithCards];
            [shuffledDeck shuffle];
            [[deck shouldNot] equal:shuffledDeck];
        });

        it(@".give_card gives the first card from the deck", ^{
            int deckSize = [[deck numberOfCards] intValue];
            FishCard *firstCard = [deck give_card];
            [[theValue(deckSize) should] equal:theValue([[deck numberOfCards] intValue] + 1)];
            [[firstCard should] equal:[FishCard newWithRank:@"2" suit:@"C"]];
        });

        it(@".receive_card puts a card at the end of the deck", ^{
            int deck_size = [[deck numberOfCards] intValue];
            FishCard *last_card;
            FishCard *first_card = [deck give_card];
            
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
