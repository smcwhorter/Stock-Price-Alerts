//
//  StockEditViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import <Cocoa/Cocoa.h>

@interface StockEditViewController : NSViewController
{
    IBOutlet NSButton *butSave;
}
@property (assign) IBOutlet NSButton *butSave;
@property (assign) IBOutlet NSTextField *stockSymbolName;

- (IBAction)SaveStock:(id)sender;
@end
