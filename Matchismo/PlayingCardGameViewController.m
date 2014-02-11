//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Donal O'Shea on 11/02/2014.
//  Copyright (c) 2014 Donal O'Shea. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
