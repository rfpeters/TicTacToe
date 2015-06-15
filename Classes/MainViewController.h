//
//  MainViewController.h
//  TicTacToe
//
//  Created by Man-Chi Leung on 2/15/11.
//  Modified by Ryan Peters on 3/27/14
//      Added AI logic for the different computer strategies. Added logic
//      for handling player and computer turns, checking for a winner, and
//      ending the game.  Added logic to view for changing the computer's
//      strategy.
//  Copyright 2011 WAKE TECH COMM COLLEGE. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate> 
{
	IBOutlet UIButton *but00;
	IBOutlet UIButton *but01;
	IBOutlet UIButton *but02;
	IBOutlet UIButton *but10;
	IBOutlet UIButton *but11;
	IBOutlet UIButton *but12;
	IBOutlet UIButton *but20;
	IBOutlet UIButton *but21;
	IBOutlet UIButton *but22;
		
	char cell[3][3];
	char turn;
	char goFirst;
	char winner;
	NSInteger numCellsEmpty;
    NSInteger strategy;
}

@property(nonatomic, readwrite) char goFirst;
@property(nonatomic, readonly) NSInteger numCellsEmpty;
@property(nonatomic, readwrite) NSInteger strategy;


- (IBAction)showInfo:(id)sender;
- (IBAction) button_touchUpInside: (id) sender;
- (void) resetGame;
- (void) checkWin;
- (void) gameEnded;
- (void) computerTurn;
- (BOOL) playToWinRow: (NSInteger*) row
                  Col: (NSInteger*) col;
- (BOOL) playNotToLose: (NSInteger*) row
                   Col: (NSInteger*) col;
- (void) randomPickRow: (NSInteger*) row
               PickCol: (NSInteger*) col;
- (void) placeTokenRow: (NSInteger) row
              TokenCol: (NSInteger) col;

@end
