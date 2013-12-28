//
//  Deck.h
//  Matchismo
//
//  Created by Donal O'Shea on 26/12/2013.
//  Copyright (c) 2013 Donal O'Shea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
