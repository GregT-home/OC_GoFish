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
    it(@"creates new cards from NSString values", ^{
        FishDeck *deck = [FishDeck newWithCards];
        [[deck should] beKindOfClass:[FishDeck class]];
    });
    
    it(@"creates new deck with 52 cards", ^{
        FishDeck *deck = [FishDeck newWithCards];
        [[deck.numberOfCards should] equal:@52];
    });
    
    context(@"Create a number of sample cards from NSString rank/suit names", ^{
        __block FishDeck *deck, *shuffledDeck;
        
        beforeEach(^{ // Occurs before each enclosed "it"
            deck = [FishDeck newWithCards];
            shuffledDeck = [FishDeck newWithCards];
       });
        
        it(@"new decks have cards in the same order", ^{
            [[[deck numberOfCards] should] equal:@52];
            [[deck should] equal:shuffledDeck];
        });
        
        it(@"shuffling should change the order", ^{
            [deck shuffle];
            [[[shuffledDeck numberOfCards] should] equal:@52];
            [[deck shouldNot] equal:shuffledDeck];
        });

        it(@".giveCard gives the first card from the deck", ^{
            FishCard *firstCard = [deck giveCard];
            [[[deck numberOfCards] should] equal:@51];
            [[firstCard should] equal:[FishCard newWithRank:@"2" suit:@"C"]];
        });
        
        it(@".giveCard gives nil when there are no more cards", ^{
            FishCard *firstCard;
            for (int i = 0; i < 52; i++) {
                firstCard = [deck giveCard];
            }
            firstCard = [deck giveCard];
            [[firstCard should] beNil];
        });
        
        it(@".receiveCard puts a card at the end of the deck", ^{
            int deckSize = [[deck numberOfCards] intValue];
            FishCard *lastCard;
            FishCard *firstCard = [deck giveCard];
            
            [deck receiveCard:firstCard];
            [[theValue(deckSize) should] equal:@52];
            for (int i = 0;i < 52; i++ ){
                lastCard = [deck giveCard];
            }
        });

    }); // end deck/shuffled_deck context

    context(@"", ^{
        
    });
});


SPEC_END
