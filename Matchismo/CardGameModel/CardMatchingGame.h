//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Donal O'Shea on 06/01/2014.
//  Copyright (c) 2014 Donal O'Shea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initialiser
- (instancetype)initWithCardCount:(NSUInteger)index
                        usingDeck:(Deck *) deck;

- (void)chooseCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger gameMode;
@end
