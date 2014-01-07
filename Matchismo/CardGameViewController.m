//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Donal O'Shea on 25/12/2013.
//  Copyright (c) 2013 Donal O'Shea. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UISegmentedControl *modeButton;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

- (NSString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
@end

@implementation CardGameViewController

- (IBAction)touchGameMode:(id)sender {
    self.game.gameMode = [sender selectedSegmentIndex] ? 3 : 2;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc]
                         initWithCardCount:[self.cardButtons count]
                         usingDeck:[self createDeck]];
    return _game;
}
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)redealCards:(id)sender {
    NSInteger gameMode = self.game.gameMode;
    self.game = [[CardMatchingGame alloc]
                 initWithCardCount:[self.cardButtons count]
                 usingDeck:[self createDeck]];
    self.game.gameMode = gameMode;
    self.modeButton.enabled = YES;
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    self.modeButton.enabled = NO;
    [self updateUI];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end