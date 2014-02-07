//
//  PlayerTests.m
//  GoFishModel
//
//  Created by Greg Tarsa on 2/6/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "Kiwi.h"
#import "GoFishModel.h"
#import "FishPlayer.h"


SPEC_BEGIN(PlayerTests)

describe(@"GoFish Model: Player object tests. ", ^{
    
    __block FishPlayer *player;
    __block NSArray *messages;

    it(@"#new creates a new player", ^{
        player = [FishPlayer newWithNumber:@0 name:@"No Name" hand:nil];
        
        [[player should] beKindOfClass:[FishPlayer class]];
        [[player.name should] equal:@"No Name"];
        [[player.number should] equal:@0];
        [[player.hand should] beNil];
    });
    
    it (@"#tell sends a message to a player.", ^{
        player = [FishPlayer new];
        
        [player tell:@"message one"];
        [player tell:@"message two"];
    });
    
    it (@"#messagesWaiting indicates that messages are waiting.", ^{
//        FishPlayer *player = [FishPlayer new];
        [[@([player messagesWaiting]) should] beYes];
    });

    it (@"#messages will retreive an array of waiting messages and preserve them.", ^{
        messages = [player messages:NO];
        
        [[messages[0] should] equal:@"message one"];
        [[messages[1] should] equal:@"message two"];
        
        [[@([player messagesWaiting]) should] beYes];
    });
    
    it (@"#messages will retreive an array of waiting messages and delete them.", ^{
        messages = [player messages:YES];
        
        [[messages[0] should] equal:@"message one"];
        [[messages[1] should] equal:@"message two"];
        
        [[@([player messagesWaiting]) should] beNo];
    });

});
    

SPEC_END
