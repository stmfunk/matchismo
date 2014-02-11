//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Donal O'Shea on 25/12/2013.
//  Copyright (c) 2013 Donal O'Shea. All rights reserved.
//
//  Abstract class

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// protected
- (Deck *)createDeck; // abstract

@end