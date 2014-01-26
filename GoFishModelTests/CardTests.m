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
        });
        
        it(@"newWithRank creates new cards from NSString values", ^{
            [[fiveHearts should] beKindOfClass:[FishCard class]];
        });
        
        it(@"they have a rank", ^{
            [[fiveHearts.rank should] equal:@"5"];
        });
        
        it(@"they have a suit", ^{
            [[fiveHearts.suit should] equal:@"H"];
        });
        
        it(@"similar cards with same rank.suit ranks are equal", ^{
            [[fiveHearts should] equal:fiveHearts2];
        });
        
        it(@"equal ranks are equal regrdless of suit", ^{
            fiveClubs = [FishCard newWithRank:@"5" suit:@"C"];
            [[fiveHearts should] equal:fiveClubs];
        });
        
        it(@"higher rank are greater than lower rank", ^{
            ace = [FishCard newWithRank:@"A" suit:@"C"];
            [[fiveHearts should] beLessThan:ace];
        });
        
        it(@"lower rank are less than higher rank", ^{
            two = [FishCard newWithRank:@"2" suit:@"C"];
            [[fiveHearts should] beGreaterThan:two];
        });
        
        it(@"toString: returns a string representation of the card", ^{
            NSString *string = [fiveHearts toString];
            [[string should] equal:@"5-H"];
        });
    }); // end context with sample cards
    
});

SPEC_END