//
//  CardTests.m
//  CardTests
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "Card.h"
#import "Deck.h"
//#import "Game.h"

SPEC_BEGIN(GameTests)

describe(@"GoFish Model: Game tests", ^{
    __block Card *fiveHearts, *fiveClubs, *ace, *two;
    
    beforeEach(^{ // Occurs before each enclosed "it"
        fiveHearts = [Card newWithRank:@"5" suit:@"H"];
        fiveClubs = [Card newWithRank:@"5" suit:@"C"];
        ace = [Card newWithRank:@"A" suit:@"C"];
        two = [Card newWithRank:@"2" suit:@"C"];
    });
/* What is the right format for this class check?
 it(@"creates new cards from NSString values", ^{
        [[fiveHearts should] beKindOfClass:(Class)Card];
    });
 */
    it(@"should have a rank", ^{
        [[fiveHearts.rank should] equal:@"5"];
    });
});


SPEC_END
