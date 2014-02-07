//
//  FishResult.m
//  GoFishModel
//
//  Created by Greg Tarsa on 2/4/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "FishResult.h"

@implementation FishResult

- (instancetype)initWithPlayer:(FishPlayer *)requester victim:(FishPlayer *)victim targetRank:(NSString *)targetRank {
    self = [super init];
    if (self) {
        _requester = requester;
        _victim = victim;
        _rank = targetRank;
        _matches = @0;
        _receivedFromPlayer = NO;
        _receivedFromPond = NO;
        _bookMade = NO;
    }
    return self;
}

+ (instancetype)newWithPlayer:(FishPlayer *)requester victim:(FishPlayer *)victim targetRank:(NSString *)targetRank {
    return[[self alloc] initWithPlayer:requester victim:victim targetRank:targetRank];
}

-(NSString *)description {
    NSString *part1, *part2, *part3;
    
    if (self.receivedFromPlayer) {
        part1 = [NSString stringWithFormat:@"Player got %@ matches.", self.matches];
    }
    else {
        part1 = @"Player was told to 'Go Fish' and ";
        if ([self.matches isEqual:@0])
            [part1 stringByAppendingString:@"he did not get what he asked for from the pond."];
        else
            [part1 stringByAppendingString:@"he got one from the pond."];
    }

   if (! [self bookMade])
       part2 = @"he did not make a book";
   else
       if ([self surpriseRank] != Nil)
           [part2 stringByAppendingFormat: @"He was surprised to make a book of %@s.", self.surpriseRank];
       else
           [part2 stringByAppendingFormat: @"He made a book of %@s.", self.rank];
    
    if (self.gameOver)
        part3 = @"\nThe Game is now over";
    else
        part3 = @"";
    
    return [[[part1 stringByAppendingString:@"\n" ] stringByAppendingString:part2] stringByAppendingString:part3];
}
@end
