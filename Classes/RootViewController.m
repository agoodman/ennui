//
//  RootViewController.m
//  ennui
//
//  Created by Aubrey Goodman on 1/16/11.
//  Copyright 2011 Migrant Studios LLC. All rights reserved.
//

#import "RootViewController.h"


@implementation RootViewController

#pragma mark -
#pragma mark SingleLabelTextFieldDelegate

- (void)singleLabelTextFieldDidCancel:(SingleLabelTextFieldViewController *)src
{
	if( didPresentModal ) {
		[src.navigationController dismissModalViewControllerAnimated:YES];
	}else{
		[src.navigationController popViewControllerAnimated:YES];
	}
	Alert(@"implement me",@"singleLabelTextFieldDidCancel");
}

- (void)singleLabelTextField:(SingleLabelTextFieldViewController *)src didCompleteWithText:(NSString *)text
{
	if( didPresentModal ) {
		[src.navigationController dismissModalViewControllerAnimated:YES];
	}else{
		[src.navigationController popViewControllerAnimated:YES];
	}
	Alert(@"implement me",@"singleLabelTextField:didCompleteWithText:");
}

#pragma mark -
#pragma mark DoubleLabelTextFieldDelegate

- (void)doubleLabelTextFieldDidCancel:(DoubleLabelTextFieldViewController *)src
{
	if( didPresentModal ) {
		[src.navigationController dismissModalViewControllerAnimated:YES];
	}else{
		[src.navigationController popViewControllerAnimated:YES];
	}
	Alert(@"implement me",@"doubleLabelTextFieldDidCancel");
}

- (void)doubleLabelTextField:(DoubleLabelTextFieldViewController *)src didCompleteWithText1:(NSString *)text1 text2:(NSString *)text2
{
	if( didPresentModal ) {
		[src.navigationController dismissModalViewControllerAnimated:YES];
	}else{
		[src.navigationController popViewControllerAnimated:YES];
	}
	Alert(@"implement me",@"doubleLabelTextField:didCompleteWithText1:text2:");
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad 
{
    [super viewDidLoad];
	self.navigationItem.title = @"Examples";
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if( section==0 ) {
		return @"Push";
	}else if( section==1 ) {
		return @"Modal";
	}
	return nil;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if( indexPath.row==0 ) {
		cell.textLabel.text = @"Single Text Field";
	}else if( indexPath.row==1 ) {
		cell.textLabel.text = @"Double Text Field";
	}
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	if( indexPath.row==0 ) {
		SingleLabelTextFieldViewController* tSingle = [[[SingleLabelTextFieldViewController alloc] initWithTitle:@"Title" label:@"label" caption:@"caption" text:@"text"] autorelease];
		tSingle.delegate = self;
		if( indexPath.section==0 ) {
			didPresentModal = NO;
			[self.navigationController pushViewController:tSingle animated:YES];
		}else if( indexPath.section==1 ) {
			didPresentModal = YES;
			UINavigationController* tWrapper = [[[UINavigationController alloc] initWithRootViewController:tSingle] autorelease];
			[self.navigationController presentModalViewController:tWrapper animated:YES];
		}
	}else if( indexPath.row==1 ) {
		DoubleLabelTextFieldViewController* tDouble = [[[DoubleLabelTextFieldViewController alloc] initWithTitle:@"Title" label1:@"label1" label2:@"label2" caption1:@"caption1" caption2:@"caption2" text1:@"text1" text2:@"text2"] autorelease];
		tDouble.delegate = self;
		if( indexPath.section==0 ) {
			didPresentModal = NO;
			[self.navigationController pushViewController:tDouble animated:YES];
		}else if( indexPath.section==1 ) {
			didPresentModal = YES;
			UINavigationController* tWrapper = [[[UINavigationController alloc] initWithRootViewController:tDouble] autorelease];
			[self.navigationController presentModalViewController:tWrapper animated:YES];
		}
	}
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

