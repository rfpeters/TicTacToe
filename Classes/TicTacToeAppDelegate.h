//
//  TicTacToeAppDelegate.h
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

@class MainViewController;

@interface TicTacToeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MainViewController *mainViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MainViewController *mainViewController;

@end

