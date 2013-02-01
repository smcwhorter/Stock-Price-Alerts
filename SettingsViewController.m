//
//  SettingsViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize setting1;
@synthesize settingSaveButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        [setting1 setStringValue:@"Setting 1"];
    }
    
    return self;
}

- (IBAction)saveSettings:(id)sender {
    NSString *val = [setting1 stringValue];
    NSLog(@"Setting save button clicked: %@",val);
}
@end
