//
//  StockEditViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import <Cocoa/Cocoa.h>
#import "CoreDataController.h"
#import "BasicBackGroundView.h"
#import "JAListView.h"
 
@interface StockEditViewController : NSViewController <JAListViewDataSource, JAListViewDelegate>
{
    IBOutlet NSButton *butSave;
    CoreDataController *coreDataController;
    __weak NSButton *toggleView;
    __weak BasicBackGroundView *searchResultsView;
    __weak JAListView *listView;
}

//Properties
@property (assign) IBOutlet NSButton *butSave;
@property (assign) IBOutlet NSTextField *stockSymbolName;
@property (strong) CoreDataController *coreDataController;
@property (weak) IBOutlet NSButton *butToggleView;
@property (weak) IBOutlet BasicBackGroundView *searchResultsView;
@property (weak) IBOutlet JAListView *listView;

//Method definitions
- (IBAction)SaveStock:(id)sender;
-(void)customizeView;
- (IBAction)toggleView:(id)sender;

@end
