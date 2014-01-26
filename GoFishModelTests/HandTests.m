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
    __block FishDeck *deck;
    __block FishHand *hand;
    __block FishCard *card;
    
    __block NSMutableArray *cards;
    it(@".newWithEmptyHand: creates an empty hand",^{
        hand = [FishHand newWithEmptyHand];
        [[hand should] beKindOfClass:[FishHand class]];
    });
    
    it(@".numberOfCards: shows the size of the hand", ^{
        hand = [FishHand newWithEmptyHand];
        [[[hand numberOfCards] should] equal:@0];
    });
    
    context(@"Given a number of sample cards from NSString rank/suit names", ^{
        beforeEach(^{ // Occurs before each enclosed "it"
            deck = [FishDeck newWithCards];
            hand = [FishHand newWithEmptyHand];
        });
        
        it(@".receiveCards: receives one card into a hand", ^{
            card = [deck give_card];
            [hand receiveCards: [NSMutableArray arrayWithObjects:card, nil]];
            [[[hand numberOfCards] should] equal:@1];
        });
        
        it(@".receiveCards: also receives multiple cards into a hand", ^{
            int starting_count = [[hand numberOfCards] intValue];
            for (int i = 0; i < 7; i++) {
                card = [deck give_card];
                [hand receiveCards: [NSMutableArray arrayWithObjects:card, nil]];
            }
            [[[hand numberOfCards] should] equal:theValue(starting_count + 7)];
        });
    });
    
    
    context(@"Given a hand of 4 of a kind (and 0 or more  other cards).", ^{
        beforeEach(^{
            deck = [FishDeck newWithCards];
            hand = [FishHand newWithEmptyHand];
            [hand receiveCards:[NSMutableArray arrayWithObjects:
                                [FishCard newWithRank:@"5" suit:@"C"],
                                [FishCard newWithRank:@"5" suit:@"H"],
                                [FishCard newWithRank:@"5" suit:@"S"],
                                [FishCard newWithRank:@"5" suit:@"D"],
                                [FishCard newWithRank:@"10" suit:@"H"],
                                [FishCard newWithRank:@"J" suit:@"H"],
                                [FishCard newWithRank:@"K" suit:@"H"],
                                nil]];
        });
        
        it(@".rankCount: returns the count for a given rank", ^{
            
            [[[hand rankCount:@"5"] should] equal:@4];
            [[[hand rankCount:@"J"] should] equal:@1];
            [[[hand rankCount:@"10"] should] equal:@1];
            [[[hand rankCount:@"A"] should] equal:@0];
        });
        
        it(@".gotBook: returns YES when is sees for of the target in the hand", ^{
            [[theValue([hand gotBook:@"5"]) should] equal:@(YES)];
        });
        
        it(@".giveMatchingCards: returns array of matched cards that are removed from hand", ^{
            cards = [hand giveMatchingCards:@"5"];
            [[theValue([cards count]) should] equal:@4];
        });
        
        it(@".giveMatchingCards: also removes the given cards from hand", ^{
            [[[hand rankCount:@"10"] should] equal:@1];
            cards = [hand giveMatchingCards:@"10"];
            [[[hand rankCount:@"10"] should] equal:@0];
        });
    });
    
    context(@"given a hand of cards", ^{
        beforeEach(^{
            hand = [FishHand newWithEmptyHand];
            [hand receiveCards:[NSMutableArray arrayWithObjects:
                                [FishCard newWithRank:@"9" suit:@"C"],
                                [FishCard newWithRank:@"6" suit:@"H"],
                                [FishCard newWithRank:@"10" suit:@"H"],
                                [FishCard newWithRank:@"2" suit:@"H"],
                                nil]];
        });
        
        it(@".sort: sorts a hand", ^{
            [hand sort];
            [[[hand toString] should] equal:@"[2-H 6-H 9-C 10-H]"];
        });
        
        it(@"toString: returns a string representation of the card", ^{
            NSString *string = [hand toString];
            [[string should] equal:@"[9-C 6-H 10-H 2-H]"];
        });
    }); // end context
    
});

SPEC_END
