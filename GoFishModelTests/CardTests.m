//
//  CardTests.m
//  CardTests
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "FishCard.h"

SPEC_BEGIN(FishCardTests)

describe(@"GoFish Model", ^{
    context(@"Create a number of sample cards from NSString rank/suit names", ^{
        __block FishCard *fiveHearts, *fiveHearts2, *fiveClubs, *ace, *two;
        
        beforeEach(^{ // Occurs before each enclosed "it"
            fiveHearts = [FishCard newWithRank:@"5" suit:@"H"];
            fiveHearts2 =[FishCard newWithRank:@"5" suit:@"H"];
            fiveClubs = [FishCard newWithRank:@"5" suit:@"C"];
            ace = [FishCard newWithRank:@"A" suit:@"C"];
            two = [FishCard newWithRank:@"2" suit:@"C"];
        });
        
        it(@"creates new cards from NSString values", ^{
            [[fiveHearts should] beKindOfClass:[FishCard class]];
        });
        
        it(@"should have a rank", ^{
            [[fiveHearts.rank should] equal:@"5"];
            if([fiveHearts isEqual:fiveHearts2])
                NSLog(@"================== 5H = 5H(2) =============");
            else
                NSLog(@"------------------ 5H != 5H(2)-------------");
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
    }); // end context with sample cards
});

SPEC_END