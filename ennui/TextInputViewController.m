//
//  TextInputViewController.m
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "TextInputViewController.h"

@interface TextInputViewController ()
@property (strong) NSArray* autocompleteResults;
@end


@implementation TextInputViewController

@synthesize searchBar = _searchBar;
@synthesize tableView = _tableView;
@synthesize keyPath = _keyPath;
@synthesize value = _value;
@synthesize autocompleteResults = _autocompleteResults;
@synthesize cancelBlock = _cancelBlock;
@synthesize saveBlock = _saveBlock;
@synthesize autocompleteDataSource = _autocompleteDataSource;
@synthesize autocompleteConditions = _autocompleteConditions;

- (void)cancelPressed
{
    if( self.cancelBlock!=nil ) {
        self.cancelBlock();
    }
}

- (void)savePressed
{
    if( self.saveBlock!=nil ) {
        self.saveBlock(self.keyPath, self.searchBar.text);
    }
}

- (void)refreshAutocomplete
{
    NSString* tObject = [self.autocompleteDataSource objectForKeyPath:self.keyPath];
    NSString* tField = [self.autocompleteDataSource fieldForKeyPath:self.keyPath];
    AutocompleteBlock tCallback = ^(NSArray* aResults) {
        async_main(^{
            self.autocompleteResults = aResults;
            [self.tableView reloadData];
        });
    };
    [self.autocompleteDataSource optionsForObject:tObject
                                            field:tField
                                       startsWith:self.searchBar.text
                                       conditions:self.autocompleteConditions
                                         callback:tCallback];
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.textInput addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.searchBar.text = self.value;
    [self.searchBar becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self refreshAutocomplete];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.autocompleteResults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if( cell==nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString* tOption = [self.autocompleteResults objectAtIndex:indexPath.row];
    cell.textLabel.text = tOption;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* tOption = [self.autocompleteResults objectAtIndex:indexPath.row];
    if( self.saveBlock!=nil ) {
        self.saveBlock(self.keyPath, tOption);
    }
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self refreshAutocomplete];
}

@end
