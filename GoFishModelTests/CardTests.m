//
//  CardTests.m
//  CardTests
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "Card.h"

SPEC_BEGIN(CardTests)

describe(@"GoFish Model", ^{
    __block Card *fiveHearts, *fiveHearts2, *fiveClubs, *ace, *two;
    
    beforeEach(^{ // Occurs before each enclosed "it"
        fiveHearts = [Card newWithRank:@"5" suit:@"H"];
        fiveHearts2 =[Card newWithRank:@"5" suit:@"H"];
        fiveClubs = [Card newWithRank:@"5" suit:@"C"];
        ace = [Card newWithRank:@"A" suit:@"C"];
        two = [Card newWithRank:@"2" suit:@"C"];
    });

    it(@"creates new cards from NSString values", ^{
        [[fiveHearts should] beKindOfClass:[Card class]];
    });
 
    it(@"should have a rank", ^{
        [[fiveHearts.rank should] equal:@"5"];
    });
    it(@"should have a suit", ^{
        [[fiveHearts.suit should] equal:@"H"];
    });
    it(@"similar cards with same rank.suit ranks should be equal", ^{
        [[fiveHearts should] equal:fiveHearts2];
    });
    it(@"equal ranks should be equal", ^{
        [[fiveHearts should] equal:fiveClubs];
    });
    it(@"higher rank should be greater than lower rank", ^{
        [[ace should] beGreaterThan:fiveHearts];
    });
    it(@"lower rank should be less than higher rank", ^{
        [[fiveHearts should] beLessThan:ace];
     });
});


SPEC_END