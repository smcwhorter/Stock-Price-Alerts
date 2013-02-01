//
//  SettingsViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import <Cocoa/Cocoa.h>

@interface SettingsViewController : NSViewController {
    NSButton *settingSaveButton;
    NSTextField *setting1;
}
@property (assign) IBOutlet NSTextField *setting1;

@property (assign) IBOutlet NSButton *settingSaveButton;
- (IBAction)saveSettings:(id)sender;

@end
