//
//  GoFish_Model.h
//  GoFish Model
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishCard.h"
#import "FishDeck.h"
#import "FishHand.h"
#import "FishGame.h"
#import "FishPlayer.h"
#import "FishResult.h"

@interface GoFishModel : NSObject

@property (nonatomic, strong) FishDeck *pond;
@property (nonatomic, strong) FishHand *hand;

@end
