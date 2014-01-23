//
//  GoFish_ModelTests.m
//  GoFish ModelTests
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "Card.h"

SPEC_BEGIN(PlayingCardTests)

describe(@"GoFish Model", ^{
    __block Card *ace;
    beforeEach(^{ // Occurs before each enclosed "it"
    
        ace = [Card newWithRank:@"A" suit:@"H"];
    });

    it(@"should have a rank", ^{
        [[ace.rank should] equal:@"A"];
    });
    it(@"should have a suit", ^{
        [[ace.suit should] equal:@"H"];
    });
    
});


SPEC_END