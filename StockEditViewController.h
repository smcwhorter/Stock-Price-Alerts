//
//  StockEditViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import <Cocoa/Cocoa.h>
#import "CoreDataController.h"

@interface StockEditViewController : NSViewController
{
    IBOutlet NSButton *butSave;
    CoreDataController *coreDataController;
}

//Properties
@property (assign) IBOutlet NSButton *butSave;
@property (assign) IBOutlet NSTextField *stockSymbolName;
@property (strong) CoreDataController *coreDataController;

//Method definitions
- (IBAction)SaveStock:(id)sender;
-(void)customizeView;
@end
