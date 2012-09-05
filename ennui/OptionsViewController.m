//
//  OptionsViewController.m
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "OptionsViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

@synthesize tableView = _tableView;
@synthesize keyPath = _keyPath;
@synthesize options = _options;
@synthesize selectedValue = _selectedValue;
@synthesize cancelBlock = _cancelBlock;
@synthesize saveBlock = _saveBlock;

- (void)viewDidLoad
{
    [super viewDidLoad];

    if( self.cancelBlock==nil ) {
        self.cancelBlock = ^{
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    
    if( self.saveBlock==nil ) {
        self.saveBlock = ^(NSString* aKeyPath, id aObject) {
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.options.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if( cell==nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    NSString* tOption = [self.options objectAtIndex:indexPath.row];
    cell.textLabel.text = tOption;
    if( [tOption isEqual:self.selectedValue] ) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* tOption = [self.options objectAtIndex:indexPath.row];
    self.saveBlock(self.keyPath, tOption);
}

@end
