//
//  FishGame.m
//  GoFishModel
//
//  Created by Greg Tarsa on 2/4/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "FishGame.h"
#import "FishDeck.h"
#import "FishHand.h"
#import "FishResult.h"

@implementation FishGame {
    NSMutableDictionary *booksList;
    BOOL gameOver;
    NSInteger currentPlayerIndex;
    BOOL gameIsStarted;
    FishDeck *pond;
    BOOL stackDeck;
}


- (instancetype)init {
    self = [super init];
    
    if (self) {
        booksList = [@{} mutableCopy];
        gameOver = NO;
        currentPlayerIndex = 0;
        gameIsStarted = NO;
        _players = @[];
        }
    return self;
}

- (void)setTestMode {
    stackDeck = YES;
}

- (void) startGame {
    if (gameIsStarted) return;
    
    pond = [FishDeck newWithCards];
    [pond shuffle];
    
    if (stackDeck)
        pond = [FishDeck newStackedDeck];
   
    for (FishPlayer *player in self.players) {
        booksList[player.number] = [@[] mutableCopy];
    }
    
    currentPlayerIndex = 0;
    [self deal:([NSNumber numberWithInteger:( ([self.players count] > 4) ? 5 : 7) ])];
    gameIsStarted = YES;
}

- (BOOL) isStarted {
    return gameIsStarted;
}


- (BOOL) isOver {
    return gameOver;
}

- (void) deal:(NSNumber *)number {
    // deal cards in chunks of X to facilitate stacking
    for (FishPlayer *player in self.players) {
        for (int i = 0; i < [number intValue]; i++ ) {
            [player.hand receiveCard:[pond giveCard]];
        }
    }
}

- (NSNumber *) pondSize {
    return [pond numberOfCards];
}
- (NSNumber *) numberOfPlayers {
    return @([self.players count]);
}

- (void) addPlayer:(NSNumber *)number name:(NSString *)name {
    if ( ! gameIsStarted) {
        FishHand *hand = [FishHand new];
        FishPlayer *player = [FishPlayer newWithNumber:number name:name hand:hand];
        self.players = [self.players arrayByAddingObject:player];
        [player tell:@"Waiting for the rest of the players."];
        [self advanceToNextPlayer];
    }
}

- (FishPlayer *)currentPlayer {
    return self.players[currentPlayerIndex];
}

- (void) advanceToNextPlayer {
    currentPlayerIndex = (currentPlayerIndex + 1) % [[self numberOfPlayers] integerValue];
}

- (NSArray *) books:(FishPlayer *)player {
    return booksList[player.number];
}
- (NSString *)booksDescription:(FishPlayer *)player {
    NSArray *booksString = [self books:player];
    if (!booksString || [booksString count] == 0)
        return @"";
    else
        return [booksString componentsJoinedByString:@", "];
}

- (NSNumber *) numberOfBooks:(FishPlayer *)player {
    return @([[self books:player] count]);
    
}

- (BOOL) processBooksYesIfFound:(NSString *)targetRank {
    NSArray *cards = [self.currentPlayer.hand giveMatchingCards:targetRank];
    if ([cards count] == 4) {
//        [booksList[self.currentPlayer.number] addObject:targetRank];
        [[booksList objectForKey:self.currentPlayer.number] addObject:targetRank];
        return YES;
    }

    [self.currentPlayer.hand receiveCards:cards];
    return NO;
}

- (FishResult *)playRound:(FishPlayer *)targetPlayer targetRank:(NSString *)targetRank {
    FishResult *result = [FishResult newWithPlayer:self.currentPlayer victim:targetPlayer targetRank:targetRank];
    
    if ([[targetPlayer.hand rankCount:targetRank] intValue] > 0) {
        // target has at least one card
        NSArray *matchCards = [targetPlayer.hand giveMatchingCards:targetRank];
        [self.currentPlayer.hand receiveCards:matchCards];
        
        result.matches = @([matchCards count]);
        result.receivedFromPlayer = true;
    }
    else {
        FishCard *card = [pond giveCard];
        if (!card)
            // no cards, game is over.
            gameOver = result.gameOver = YES;
        else {
            [self.currentPlayer.hand receiveCard: card];
            result.receivedFromPond = true;
            if ([card.rank isEqualToString:targetRank])  // intended match
                result.matches = @1;
            else { // possible surprise match
                if ([self processBooksYesIfFound:card.rank]) {
                    result.bookMade = true;
                    result.surpriseRank = card.rank;
                }
                [self advanceToNextPlayer];
            }
        }
    }

    if (! result.bookMade)
        result.bookMade = [self processBooksYesIfFound:targetRank];

        return result;

}


@end
