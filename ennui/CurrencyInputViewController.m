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

- (void)textDidChange
{
    NSNumberFormatter* tIn = [NSNumberFormatter new];
    tIn.numberStyle = NSNumberFormatterDecimalStyle;
    
    NSNumberFormatter* tOut = [NSNumberFormatter new];
    tOut.numberStyle = NSNumberFormatterCurrencyStyle;
    
    double tPennies = [tIn numberFromString:self.textInput.text].doubleValue;
    double tDollars = tPennies / 100.00;
    
    self.textDisplay.text = [tOut stringFromNumber:[NSNumber numberWithDouble:tDollars]];
    self.value = [NSNumber numberWithDouble:tDollars];
}

#pragma mark - View life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.textInput addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelPressed)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(savePressed)];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.textInput.text = [NSString stringWithFormat:@"%d",(int)([self.value floatValue]*100.0)];
    
    NSNumberFormatter* tFormat = [NSNumberFormatter new];
    tFormat.numberStyle = NSNumberFormatterCurrencyStyle;
    self.textDisplay.text = [tFormat stringFromNumber:self.value];
    
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

@end
