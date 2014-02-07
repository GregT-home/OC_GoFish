//
//  FishGame.h
//  GoFishModel
//
//  Created by Greg Tarsa on 2/4/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GoFishModel.h"
#import "FishPlayer.h"
#import "FishResult.h"




@interface FishGame : NSObject
@property (nonatomic, strong) NSArray *players;

- (instancetype)init;
- (void) startGame;
- (BOOL) isStarted;
- (BOOL) isOver;
- (void) deal:(NSNumber *)number;
- (NSNumber *) pondSize;
- (NSNumber *) numberOfPlayers;
- (void) addPlayer:(NSNumber *)number name:(NSString *)name;
- (FishPlayer *)currentPlayer;
- (void) advanceToNextPlayer;
- (NSArray *) books:(FishPlayer *)player;
- (NSString *) booksDescription:(FishPlayer *)player;
- (NSNumber *) numberOfBooks:(FishPlayer *)player;
- (BOOL) processBooksYesIfFound:(NSString *)target_rank;
- (FishResult *)playRound:(FishPlayer *)targetPlayer targetRank:(NSString *)targetRank;
- (void)setTestMode;

@end
