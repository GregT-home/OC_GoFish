//
//  CardTests.m
//  CardTests
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//
#import "Kiwi.h"
#import "GoFishModel.h"

SPEC_BEGIN(GameTests)

#if FALSE
describe(@"GoFish Model: Game tests", ^{
    __block FishCard *fiveHearts, *fiveClubs, *ace, *two;
    
    beforeEach(^{ // Occurs before each enclosed "it"
        fiveHearts = [FishCard newWithRank:@"5" suit:@"H"];
        fiveClubs = [FishCard newWithRank:@"5" suit:@"C"];
        ace = [FishCard newWithRank:@"A" suit:@"C"];
        two = [FishCard newWithRank:@"2" suit:@"C"];
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
#endif

describe(@"GoFish Model: Initial game setup. ", ^{
    __block FishGame *game;
    
    beforeEach(^{ // Occurs before each enclosed "it"
        NSArray *names = @[@"One", @"Two", @"Three"];
        NSInteger handCount = [names count];
        game = [FishGame new];
        for (NSInteger i = 0; i < handCount; i++) {
            [game addPlayer:@(i+10) name:names[i]];
        }
    });
    
    it(@"#new creates a new game", ^{
        [[game should] beKindOfClass:[FishGame class]];
    });
    
    it(@"#new creates a new game that is not started", ^{
        [[theValue([game isStarted]) should] equal:@(NO)];
    });
    
    it(@"#numberOfPlayers tells how many players there are", ^{
        [[[game numberOfPlayers] should] equal:@3];
    });
    
    it(@"#pondSize should be non-existent (Nil) before the game starts", ^{
        [[[game pondSize] should] beNil];
    });

    
    it(@"#startGame starts the game", ^{
        [game startGame];
        [[theValue([game isStarted]) should] beYes];
    });
    
    it(@"all players have hands in a running game", ^{
        [game startGame];
        for (FishPlayer *player in game.players) {
            [[[player.hand numberOfCards] should] equal:@7];
        }
    });

});

describe(@"GoFish Model: Running game tests. ", ^{
    __block FishGame *game;
    
    beforeEach(^{ // Occurs before each enclosed "it"
        NSArray *names = @[@"One", @"Two", @"Three"];
        NSInteger handCount = [names count];
        game = [FishGame new];
        for (NSInteger i = 0; i < handCount; i++) {
            [game addPlayer:@(i+10) name:names[i]];
        }
        [game startGame];
    });

    it(@"a running game has a pond with 52 cards", ^{
        int dealtCards = 52 - [[game numberOfPlayers] intValue] * 7;
        [[[game pondSize] should] equal:@(dealtCards)];
    });
});

describe(@"GoFish Model: Play Round tests.", ^{
    context(@"Given a deck with known player hands...", ^{
        __block FishGame *game;
        
        beforeEach(^{ // Occurs before each enclosed "it"
            NSArray *names = @[@"First", @"Second", @"Third"];
            NSInteger handCount = [names count];
            game = [FishGame new];
            //TestMode stacks the deck as follows...
            // hand 1: 2C 2H 3C QH 5C 4H 9H
            // hand 2: 2S 2D 3S 3D 5S 4D 9C
            // hand 3: 10C 10H 10S 10D AC AH 9S
            [game setTestMode];
            
            for (NSInteger i = 0; i < handCount; i++) {
                [game addPlayer:@(i+10) name:names[i]];
            }
            [game startGame];
        }); // beforeEach
     
        it(@"#testMode results in expected hands.", ^{
            FishPlayer *player = game.players[0];
            NSString *hand = [NSString stringWithFormat:@"%@", player.hand];
            [[hand should] startWithString:@"[2-C 2-H 3-C Q-H 5-C 4-H 9-H]"];

            player = game.players[1];
            hand = [NSString stringWithFormat:@"%@", player.hand];
            [[hand should] startWithString:@"[2-S 2-D 3-S 3-D 5-S 4-D 9-C]"];
            
            player = game.players[2];
            hand = [NSString stringWithFormat:@"%@", player.hand];
            [[hand should] startWithString:@"[10-C 10-H 10-S 10-D A-C A-H 9-S]"];
        });
        
        it (@"#playRound, case 1: ask Victim: none; Pond: No; Book: N/A; next player.", ^{
            FishPlayer *startPlayer = game.currentPlayer;
            NSNumber *startedWith = [startPlayer.hand rankCount:@"4"];
            
            // hand 2 has no 4s, nor the pond
            FishResult *result = [game playRound:game.players[2] targetRank:@"4"];
            
            [[result.requester should] equal:startPlayer];
            [[result.victim should] equal:game.players[2]];
            [[result.rank should] equal:@"4"];
            [[result.matches should] equal:@0];
            [[theValue(result.receivedFromPond) should] beTrue];
            [[theValue(result.bookMade) should] beFalse];
            
            [[startedWith should] equal:[startPlayer.hand rankCount:@"4"]];
            [[game.currentPlayer shouldNot] equal:startPlayer];
        });
        
        it (@"#playRound, case 2: ask Victim: gets; Pond: N/A; Book: no; plays again.", ^{
            FishPlayer *startPlayer = game.currentPlayer;
            
            // hand 0 has 1 3 and hand 1 has 2 x 3s
            FishResult *result = [game playRound:game.players[1] targetRank:@"3"];
            
            [[result.matches should] equal:@2];
            [[theValue(result.receivedFromPlayer) should] beTrue];
            [[theValue(result.bookMade) should] beFalse];
            
            [[[startPlayer.hand rankCount:@"3"] should] equal:@3];
            [[game.currentPlayer should] equal:startPlayer];
        });
        
        it (@"#playRound, case 3: ask Victim: gets; Pond: N/A; Book: Yes; plays again.", ^{
            FishPlayer *startPlayer = game.currentPlayer;
            
            // hand 0 has 2 x 2s, hand 1 has 2 x 2s
            FishResult *result = [game playRound:game.players[1] targetRank:@"2"];
            
            [[result.matches should] equal:@2];
            [[theValue(result.receivedFromPlayer) should] beTrue];
            [[theValue(result.bookMade) should] beTrue];
            
            [[[startPlayer.hand rankCount:@"2"] should] equal:@0];
            [[game.currentPlayer should] equal:startPlayer];
        });

        it (@"#playRound, case 4: ask Victim: no get; Pond: get; Book: no; plays again.", ^{
            FishPlayer *startPlayer = game.currentPlayer;
            
            // hand 0 has 1 x 3, hand 2 has none, the pond has one on top
            FishResult *result = [game playRound:game.players[2] targetRank:@"3"];
            
            [[result.matches should] equal:@1];
            [[theValue(result.receivedFromPond) should] beTrue];
            [[theValue(result.bookMade) should] beFalse];
            
            [[[startPlayer.hand rankCount:@"3"] should] equal:@2];
            [[game.currentPlayer should] equal:startPlayer];
        });
        
        it (@"#playRound, case 5: ask Victim: no get; Pond: get; Book: yes; plays again.", ^{
            FishPlayer *startPlayer = game.currentPlayer;
            
            // We pick from two hands for this test
            // Preparation: grab the 3s from hand 1 (test case #2)
            FishResult *result = [game playRound:game.players[1] targetRank:@"3"];
            
            // Now ask hand 2 for 3's.  He has none, but the pond does.
            result = [game playRound:game.players[2] targetRank:@"3"];
            
            [[result.matches should] equal:@1];
            [[theValue(result.receivedFromPond) should] beTrue];
            [[theValue(result.bookMade) should] beTrue];
            
            [[game.currentPlayer should] equal:startPlayer];
            [[[game books:startPlayer] should] contain:@"3"];
        });
        
        it (@"#playRound, case 6: ask Victim: no get; Pond: get; Book: yes-surprise; next player.", ^{
            FishPlayer *startPlayer = game.currentPlayer;
            
            // We pick from two hands for this test
            // Preparation: grab the 3s from hand 1 (test case #2)
            FishResult *result = [game playRound:game.players[1] targetRank:@"3"];
            
            // Now ask hand 2 for Qs. He has none, but we get a surprise book of 3s from pond.
            result = [game playRound:game.players[2] targetRank:@"Q"];
            
            [[result.matches should] equal:@0];
            
            [[theValue(result.receivedFromPlayer) should] beFalse];
            [[theValue(result.receivedFromPond) should] beTrue];
            [[theValue(result.bookMade) should] beTrue];
            
            [[game.currentPlayer shouldNot] equal:startPlayer];
            [[[game books:startPlayer] should] contain:@"3"];
        });
        
        it (@"#booksDescription returns null string when no books are held.", ^{
            NSString *booksAsString = [game booksDescription:game.currentPlayer];
            [[booksAsString should] equal:@""];
        });
        
        it (@"#booksDescription can represent the books held as a string", ^{
            // Preparation: remove any matching cards from the current hand
            [game.currentPlayer.hand giveMatchingCards:@"2"];
            [game.currentPlayer.hand giveMatchingCards:@"K"];
            [game.currentPlayer.hand giveMatchingCards:@"A"];

            // Stack the hand with three books
            NSArray *rankSuit = [@"2 C 2 S 2 D 2 H K C K S K D K H A C A S A D A H"
                                 componentsSeparatedByString:@" "];
            NSMutableArray *lotsOfBooks;
            for (int i = 0; i < [rankSuit count] - 1; i = i + 2)
                [lotsOfBooks addObject:[FishCard newWithRank:rankSuit[i] suit:rankSuit[i+1]]];
            
            [game.currentPlayer.hand receiveCards:lotsOfBooks];
            
//            [[theValue([game processBooksYesIfFound:@"2"]) should] equal:@YES];
//            [[theValue([game processBooksYesIfFound:@"K"]) should] equal:@YES];
//            [[theValue([game processBooksYesIfFound:@"A"]) should] equal:@YES];
//            
//            NSString *bookList = @"2s, As, Ks";
//            [[[game booksDescription:[game currentPlayer]] should] equal:bookList];
        });
        
        it (@".playRound ends the game when the last card is taken from the pond.", ^{
            // Prep: ask for a Q from player 1, does not get.  Player 0 gets last card in pond.
            FishResult *result = [game playRound:game.players[1] targetRank:@"Q"];
            [[theValue(result.gameOver) should] beNo];
            
            // It is now player 1's turn.  Ask for 3 from Hand 2, he does not have one. Game ends.
            result = [game playRound:game.players[2] targetRank:@"3"];
            [[theValue(result.gameOver) should] beYes];
            
        });
    });  // context
});

SPEC_END
