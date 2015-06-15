//
//  FlipsideViewController.m
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
#import "MainViewController.h"


@implementation FlipsideViewController

@synthesize delegate;


- (void)viewDidLoad 
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];   
	
	if ([(MainViewController *) self.delegate goFirst] == 'x')
	{
		[goFirstSwitch setOn:YES];
	}
	else 
	{
		[goFirstSwitch setOn:NO];
	}
	
    // Set the switched to proper strategy 
    if ([(MainViewController *) self.delegate strategy] == 1)
	{
		[strategy1Switch setOn:YES];
	}
    else if ([(MainViewController *) self.delegate strategy] == 2)
	{
		[strategy2Switch setOn:YES];
	}
    else if ([(MainViewController *) self.delegate strategy] == 3)
	{
		[strategy3Switch setOn:YES];
	}

}


- (IBAction)done:(id)sender 
{
	if (goFirstSwitch.on == YES)
	{
		[(MainViewController *) self.delegate setGoFirst: 'x'];
	}
	else 
    {
			[(MainViewController *) self.delegate setGoFirst: 'o'];
	}
    
	// reset immediately oif new game
	if ([(MainViewController *) self.delegate numCellsEmpty] == 9)
	{
		[(MainViewController *) self.delegate resetGame];
	}

	[self.delegate flipsideViewControllerDidFinish:self];	
}

// Set the computer strategy
- (IBAction)strategy:(id)sender
{
    if(sender == strategy1Switch)
    {
        [strategy1Switch setOn:YES];
        [strategy2Switch setOn:NO];
        [strategy3Switch setOn:NO];
        [(MainViewController *) self.delegate setStrategy: 1];
    }    
    else if(sender == strategy2Switch)
    {
        [strategy1Switch setOn:NO];
        [strategy2Switch setOn:YES];
        [strategy3Switch setOn:NO];
        [(MainViewController *) self.delegate setStrategy: 2];
    }
    else if(sender == strategy3Switch)
    {
        [strategy1Switch setOn:NO];
        [strategy2Switch setOn:NO];
        [strategy3Switch setOn:YES];
        [(MainViewController *) self.delegate setStrategy: 3];
    }

    
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc {
    [super dealloc];
}


@end
