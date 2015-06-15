//
//  FlipsideViewController.h
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

#import <UIKit/UIKit.h>

@protocol FlipsideViewControllerDelegate;


@interface FlipsideViewController : UIViewController 
{
	id <FlipsideViewControllerDelegate> delegate;
	
	IBOutlet UISwitch *goFirstSwitch;
    IBOutlet UISwitch *strategy1Switch;
    IBOutlet UISwitch *strategy2Switch;
    IBOutlet UISwitch *strategy3Switch;
}

@property (nonatomic, assign) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;
- (IBAction)strategy:(id)sender;
@end

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

