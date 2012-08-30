//
//  CurrencyInputViewController.m
//  Rakiteer
//
//  Created by Aubrey Goodman on 8/27/12.
//  Copyright (c) 2012 Migrant Studios. All rights reserved.
//

#import "CurrencyInputViewController.h"

@interface CurrencyInputViewController ()

@end

@implementation CurrencyInputViewController

@synthesize textInput = _textInput;
@synthesize textDisplay = _textDisplay;
@synthesize keyPath = _keyPath;
@synthesize value = _value;
@synthesize cancelBlock = _cancelBlock;
@synthesize saveBlock = _saveBlock;

- (void)cancelPressed
{
    if( self.cancelBlock!=nil ) {
        self.cancelBlock();
    }
}

- (void)savePressed
{
    if( self.saveBlock!=nil ) {
        self.saveBlock(self.keyPath, self.value);
    }
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textInput addTarget:self action:@selector(textDidChange:) forControlEvents:UIControlEventEditingChanged];

    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)] autorelease];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)] autorelease];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.textInput.text = self.value;
    [self.textInput becomeFirstResponder];
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

#pragma mark - UITextInputDelegate

- (void)textWillChange:(id<UITextInput>)textInput
{
    
}

- (void)textDidChange:(id<UITextInput>)textInput
{
    NSNumberFormatter* tIn = [[NSNumberFormatter new] autorelease];
    tIn.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumberFormatter* tOut = [[NSNumberFormatter new] autorelease];
    tOut.numberStyle = NSNumberFormatterCurrencyStyle;
    
    double tPennies = [tIn numberFromString:self.textInput.text].doubleValue;
    double tDollars = tPennies / 100.00;
    
    self.textDisplay.text = [tOut stringFromNumber:[NSNumber numberWithDouble:tDollars]];
    self.value = [tIn stringFromNumber:[NSNumber numberWithDouble:tDollars]];
}

@end