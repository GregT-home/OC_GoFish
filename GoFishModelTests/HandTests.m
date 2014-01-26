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
    
    it(@".newWithEmptyHand: can create an empty hand",^{
        hand = [FishHand newWithEmptyHand];
        [[hand should] beKindOfClass:[FishHand class]];
    });
    
    it(@".numberOfCards: new deck has 0 cards", ^{
        [[[hand numberOfCards] should] equal:@0];
    });
    
    context(@"Create a number of sample cards from NSString rank/suit names", ^{
        __block FishDeck *deck;
        __block FishHand *hand;
        __block FishCard *card;
        __block NSMutableArray *cards;
        
        beforeEach(^{ // Occurs before each enclosed "it"
           deck = [FishDeck newWithCards];
           hand = [FishHand newWithEmptyHand];
        });
        
        it(@".receiveCards: hand can receive one card", ^{
            card = [deck give_card];
            [hand receiveCards: [NSMutableArray arrayWithObjects:card, nil]];
            [[[hand numberOfCards] should] equal:@1];
        });
        
        it(@".receiveCards: hand can receive multiple cards", ^{
            int starting_count = [[hand numberOfCards] intValue];
            for (int i = 0; i < 7; i++) {
                card = [deck give_card];
                [hand receiveCards: [NSMutableArray arrayWithObjects:card, nil]];
            }
            [[[hand numberOfCards] should] equal:theValue(starting_count + 7)];
        });
        
        context(@"Create a hand of 5s and misc cards for rank count test.", ^{
            beforeEach(^{
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
            
            it(@".rankCount: can count the number of ranks", ^{
                int i = 5; NSLog(@"??? ? ? ?? ? ? ? ? ? ? ? ?%d ? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?", i);
//                NSLog(@"[hand rankCount:(at)5 = %@", [hand rankCount:@"5"]);
//                NSLog(@"(at)4 = %@", @4);
                ++i; NSLog(@"??? ? ? ?? ? ? ? ? ? ? ? ?%d ? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?", i);
                
 //               [[[hand rankCount:@"5"] should] equal:@4];
 //               [[[hand rankCount:@"5"] should] equal:@4];
 //               [[[hand rankCount:@"5"] should] equal:@4];
                ++i; NSLog(@"??? ? ? ?? ? ? ? ? ? ? ? ?%d ? ? ? ? ? ? ? ? ? ? ? ? ? ?? ?", i);
                
                //              [[theValue([hand rankCount:@"5"]) should] equal:theValue(4)];
  //              [[theValue([hand rankCount:@"J"]) should] equal:theValue(1)];
  //              [[theValue([hand rankCount:@"A"]) should] equal:theValue(0)];
            });
            
            it(@".gotBook: returns YES when is sees for of the target in the hand", ^{
                [[theValue([hand gotBook:@"5"]) should] equal:theValue(YES)];
            });
            
            it(@".giveMatchingCards: returns array of matched cards that are removed from hand", ^{
                cards = [hand giveMatchingCards:@"5"];
                [[theValue([cards count]) should] equal:theValue(4)];
            });
            
            it(@".giveMatchingCards: matched cards are removed from hand", ^{
                [[theValue([hand rankCount:@"10"]) should] equal:theValue(1)];
                cards = [hand giveMatchingCards:@"10"];
                [[theValue([hand rankCount:@"10"]) should] equal:theValue(0)];
            });
            
        });
        
        it(@".toString: displays a hand as a string", ^{
            [hand toString];
        });
        
        it(@".sort: sort a hand", ^{
            // [[fiveHearts should] beKindOfClass:[FishHand class]];
        });
    });
});

SPEC_END
