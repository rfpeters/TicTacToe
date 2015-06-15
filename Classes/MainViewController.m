//
//  MainViewController.m
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

#import "MainViewController.h"


@implementation MainViewController

@synthesize goFirst;
@synthesize numCellsEmpty;
@synthesize strategy;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
	[super viewDidLoad];
	
	goFirst = 'x';
    strategy = 1;
    srandom(time(NULL));
	[self resetGame];
	
}

// Resets the game by emptying all squares
- (void) resetGame
{
	[but00 setTitle:@"" forState:0];
	[but01 setTitle:@"" forState:0];
	[but02 setTitle:@"" forState:0];
	[but10 setTitle:@"" forState:0];
	[but11 setTitle:@"" forState:0];
	[but12 setTitle:@"" forState:0];
	[but20 setTitle:@"" forState:0];
	[but21 setTitle:@"" forState:0];
	[but22 setTitle:@"" forState:0];
	
	for (int i = 0; i < 3; i++)
	{
		for (int j = 0; j < 3; j++)
		{
			cell[i][j] = ' '; // empty
		}
	}
	
	turn = goFirst;
	winner = ' ';
	numCellsEmpty = 9;
    
    if (turn == 'x')
    {
        [self computerTurn];
    }
}

// Handles player selection
- (IBAction) button_touchUpInside: (id) sender
{
	NSInteger row;
	NSInteger col;
	if (sender == but00)
	{
		row = 0;
		col = 0;
	}
	else if (sender == but01)
	{
		row = 0;
		col = 1;
	}
	else if (sender == but02)
	{
		row = 0;
		col = 2;
	}
	else if (sender == but10)
	{
		row = 1;
		col = 0;
	}
	else if (sender == but11)
	{
		row = 1;
		col = 1;
	}
	else if (sender == but12)
	{
		row = 1;
		col = 2;
	}
	else if (sender == but20)
	{
		row = 2;
		col = 0;
	}
	else if (sender == but21)
	{
		row = 2;
		col = 1;
	}
	else if (sender == but22)
	{
		row = 2;
		col = 2;
	}
	
	if (cell[row][col] == ' ')
    {
        numCellsEmpty--;
        cell[row][col] = 'o';
        [sender setTitle:@"O" forState:0];
        [self checkWin];
        if (winner != ' ')
        {
            [self gameEnded];
        }
        else
        {
            turn = 'x';
            [self computerTurn];
        }
    }
    
}

// Check if there is a winner
- (void) checkWin
{
		
	// check rows
	for (int row = 0; row < 3; row++)
	{
		if (cell[row][0] == turn && cell[row][1] == turn && cell[row][2] == turn)
		{
			winner = turn;
			return;
		}
	}
	
	// check columns
	for (int col = 0; col < 3; col++)
	{
		if (cell[0][col] == turn && cell[1][col] == turn && cell[2][col] == turn)
		{
			winner = turn;
			return;
		}
	}

	// check diagonals
	if (cell[0][0] == turn && cell[1][1] == turn && cell[2][2] == turn)
	{
		winner = turn;
		return;
	}
	else if (cell[0][2] == turn && cell[1][1] == turn && cell[2][0] == turn)
	{
		winner = turn;
		return;
	}
	
	// check tie game
	if (numCellsEmpty == 0)
		winner = 't';  // tie game;
	
}

// display winner and reset button
- (void) gameEnded
{
	NSString *message;
	if (winner == 'x')
    {
		message = @"X wins";
    }
	else if (winner == 'o')
    {
		message = @"O wins";
    }
	else if (winner == 't')
    {
		message = @"Tie";
    }
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:message delegate: self cancelButtonTitle:@"Reset Game" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

// Handles the computer's turn
- (void) computerTurn
{
    numCellsEmpty--;
    NSInteger row;
    NSInteger col;
    
    
    if (strategy == 1)
    {
        if(![self playToWinRow: &row Col: &col])
        {
            [self randomPickRow: &row PickCol: &col];
        }
        cell[row][col] = turn;
    }
    else if (strategy == 2)
    {
        if(![self playNotToLose: &row Col: &col])
        {
            [self randomPickRow: &row PickCol: &col];
        }
        winner = ' ';
        turn = 'x';
        cell[row][col] = turn;
        
    }
    else if (strategy == 3)
    {
        [self randomPickRow: &row PickCol: &col];
        cell[row][col] = turn;
    }
    
    [self placeTokenRow:row TokenCol:col];
    [self checkWin];
    if (winner != ' ')
    {
        [self gameEnded];
    }
    else
    {
        turn = 'o';
    }
    
}

// Handles the play to win strategy
- (BOOL) playToWinRow: (NSInteger*) row
                  Col: (NSInteger*) col
{
    for(int i = 0; i < 3; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            if(cell[i][j] == ' ')
            {
                cell[i][j] = turn;
                [self checkWin];
                if(winner == turn)
                {
                    *row = i;
                    *col = j;
                    turn = 'x';
                    winner = ' ';
                    return YES;
                }
                else
                {
                    cell[i][j] = ' ';
                }
            }
        }
    }

    return NO;
}

// Handles the play not to lose strategy
- (BOOL) playNotToLose: (NSInteger*) row
                   Col: (NSInteger*) col
{
    turn = 'o';
    for(int i = 0; i < 3; i++)
    {
        for(int j = 0; j < 3; j++)
        {
            if(cell[i][j] == ' ')
            {
                cell[i][j] = turn;
                [self checkWin];
                if(winner == turn)
                {
                    cell[i][j] = 'x';
                    *row = i;
                    *col = j;
                    return YES;
                }
                else
                {
                    cell[i][j] = ' ';
                }
            }
        }
    }

    
    return NO;
}

// Handles the random pick strategy
- (void) randomPickRow: (NSInteger*) row
               PickCol: (NSInteger*) col
{
    do {
        *row = random() % 3;
        *col = random() % 3;
    } while (cell[*row][*col] != ' ');
    
}

// Place the token for computers turn
- (void) placeTokenRow: (NSInteger) row
              TokenCol: (NSInteger) col
{
    if(row == 0 && col == 0)
    {
        [but00 setTitle:@"X" forState:0];
    }
    else if(row == 0 && col == 1)
    {
        [but01 setTitle:@"X" forState:0];
    }
    else if(row == 0 && col == 2)
    {
        [but02 setTitle:@"X" forState:0];
    }
    else if(row == 1 && col == 0)
    {
        [but10 setTitle:@"X" forState:0];
    }
    else if(row == 1 && col == 1)
    {
        [but11 setTitle:@"X" forState:0];
    }
    else if(row == 1 && col == 2)
    {
        [but12 setTitle:@"X" forState:0];
    }
    else if(row == 2 && col == 0)
    {
        [but20 setTitle:@"X" forState:0];
    }
    else if(row == 2 && col == 1)
    {
        [but21 setTitle:@"X" forState:0];
    }
    else if(row == 2 && col == 2)
    {
        [but22 setTitle:@"X" forState:0];
    }
}

- (void) alertView: (UIAlertView *) alertView clickedButtonAtIndex: (NSInteger) buttonIndex
{
	[self resetGame];
}

- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller {
    
	[self dismissModalViewControllerAnimated:YES];
}


- (IBAction)showInfo:(id)sender {    
	
	FlipsideViewController *controller = [[FlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
	controller.delegate = self;
	
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void)dealloc 
{	
    [super dealloc];
}


@end
