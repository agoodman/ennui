//
//  EditorViewController.m
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "EditorViewController.h"
#import "OptionsViewController.h"
#import "TextInputViewController.h"
#import "CurrencyInputViewController.h"


@interface EditorViewController ()
-(NSDictionary*)constructConditionsForKeyPath:(NSString*)aKeyPath;
@end


@implementation EditorViewController

@synthesize tableView = _tableView;
@synthesize config = _config;
@synthesize keys = _keys;
@synthesize fields = _fields;
@synthesize cancelBlock = _cancelBlock;
@synthesize saveBlock = _saveBlock;
@synthesize autocompleteDataSource = _autocompleteDataSource;

- (void)cancelPressed
{
    if( self.cancelBlock!=nil ) {
        self.cancelBlock();
    }
}

- (void)savePressed
{
    if( self.saveBlock!=nil ) {
        self.saveBlock(self.fields);
    }
}

- (NSDictionary*)constructConditionsForKeyPath:(NSString*)aKeyPath
{
    NSMutableDictionary* tConditions = [NSMutableDictionary dictionary];

    NSLog(@"fields: %@",self.fields);
    NSArray* tKeyConditions = [[self.config objectForKey:aKeyPath] objectForKey:@"conditions"];
    if( tKeyConditions!=nil ) {
        NSArray* tKeys = [self.fields allKeys];
        NSLog(@"looking for intersection between [%@] and [%@]",tKeyConditions,tKeys);
        for (NSString* key in tKeys) {
            if( [tKeyConditions containsObject:key] ) {
                NSString* tField = [self.autocompleteDataSource fieldForKeyPath:key];
                NSString* tValue = [self.fields valueForKey:key];
                [tConditions setValue:tValue forKey:tField];
            }
        }
    }
    NSLog(@"resulting conditions: %@",tConditions);

    return [NSDictionary dictionaryWithDictionary:tConditions];
}

#pragma mark - View life cycle

- (id)init
{
    self = [super initWithNibName:@"EditorView" bundle:[NSBundle mainBundle]];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(savePressed)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
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
    return self.keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* tKeyPath = [self.keys objectAtIndex:indexPath.row];
    NSDictionary* tConfig = [self.config objectForKey:tKeyPath];
    NSString* tTag = [tConfig objectForKey:@"tag"];
    NSNumber* tRequired = [tConfig objectForKey:@"required"];
    NSString* tType = [tConfig objectForKey:@"type"];
    NSString* tValue = [self.fields objectForKey:tKeyPath];
    NSString* tCellType = [tConfig objectForKey:@"cell"];
    
//    if( [@"enum" isEqualToString:tType] || [@"currency" isEqualToString:tType] || [@"text" isEqualToString:tType] ) {
        static NSString *CellIdentifier = @"Type1Cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if( cell==nil ) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
        }
        
        cell.textLabel.text = tTag;
        cell.detailTextLabel.text = tValue;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;

//    }else{
//        static NSString *CellIdentifier = @"SubtitleCell";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//        
//        if( cell==nil ) {
//            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
//        }
//        
//        cell.textLabel.text = tValue;
//        cell.detailTextLabel.text = tTag;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        
//        return cell;
        
//    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* tKeyPath = [self.keys objectAtIndex:indexPath.row];

    NSDictionary* tConfig = [self.config objectForKey:tKeyPath];
    NSString* tType = [tConfig objectForKey:@"type"];
    NSString* tValue = [self.fields objectForKey:tKeyPath];

    if( [tType isEqualToString:@"enum"] ) {
        OptionsViewController* tOptions = [[[OptionsViewController alloc] initWithNibName:@"OptionsView" bundle:[NSBundle mainBundle]] autorelease];
        tOptions.keyPath = tKeyPath;
        tOptions.selectedValue = tValue;
        tOptions.options = [tConfig objectForKey:@"options"];
        tOptions.title = [tConfig objectForKey:@"tag"];
        tOptions.saveBlock = ^(NSString* aKeyPath, id aOption) {
            NSMutableDictionary* tFields = [NSMutableDictionary dictionaryWithDictionary:self.fields];
            [tFields setValue:aOption forKey:aKeyPath];
            self.fields = tFields;
            async_main(^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        };
        [self.navigationController pushViewController:tOptions animated:YES];
        
    }else if( [tType isEqualToString:@"text"] ) {
        TextInputViewController* tText = [[[TextInputViewController alloc] initWithNibName:@"TextInputView" bundle:[NSBundle mainBundle]] autorelease];
        tText.keyPath = tKeyPath;
        tText.value = tValue;
        tText.title = [tConfig objectForKey:@"tag"];
        tText.cancelBlock = ^{
            async_main(^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        };
        tText.saveBlock = ^(NSString* aKeyPath, NSString* aValue) {
            NSMutableDictionary* tFields = [NSMutableDictionary dictionaryWithDictionary:self.fields];
            [tFields setValue:aValue forKey:aKeyPath];
            self.fields = tFields;
            async_main(^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        };
        tText.autocompleteConditions = [self constructConditionsForKeyPath:tKeyPath];
        tText.autocompleteDataSource = self.autocompleteDataSource;
        [self.navigationController pushViewController:tText animated:YES];
        
    }else if( [tType isEqualToString:@"currency"] ) {
        CurrencyInputViewController* tCurrency = [[[CurrencyInputViewController alloc] initWithNibName:@"CurrencyInputView" bundle:[NSBundle mainBundle]] autorelease];
        tCurrency.keyPath = tKeyPath;
        tCurrency.value = tValue;
        tCurrency.title = [tConfig objectForKey:@"tag"];
        tCurrency.cancelBlock = ^{
            async_main(^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        };
        tCurrency.saveBlock = ^(NSString* aKeyPath, NSString* aValue) {
            NSMutableDictionary* tFields = [NSMutableDictionary dictionaryWithDictionary:self.fields];
            [tFields setValue:aValue forKey:aKeyPath];
            self.fields = tFields;
            async_main(^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        };
        [self.navigationController pushViewController:tCurrency animated:YES];
        
    }
    
}

@end
