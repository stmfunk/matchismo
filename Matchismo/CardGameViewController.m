//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Donal O'Shea on 25/12/2013.
//  Copyright (c) 2013 Donal O'Shea. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong, nonatomic) Deck *cardDeck;
@property (nonatomic) int flipCount;

@end

@implementation CardGameViewController

- (Deck *)cardDeck {
    _cardDeck = [[PlayingCardDeck alloc] init];
    return _cardDeck;
}

- (void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flops: %d", self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if (![sender.currentTitle length]) {
        UIImage *cardImage = [UIImage imageNamed:@"cardfront"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        Card *randomCard = [self.cardDeck drawRandomCard];
        [sender setTitle:randomCard.contents forState:UIControlStateNormal];
        
    } else {
        UIImage *cardImage = [UIImage imageNamed:@"cardback"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    self.flipCount++;
}

@end
