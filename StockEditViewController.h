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
#import "SPADataDownloadManager.h"
 
@interface StockEditViewController : NSViewController <JAListViewDataSource, JAListViewDelegate, SAPDataDownloadCompleteDelegate>
{
    IBOutlet NSButton *butSave;
    CoreDataController *coreDataController;
    __weak NSButton *toggleView;
    __weak BasicBackGroundView *searchResultsView;
    __weak JAListView *listView;
    SPADataDownloadManager *stockDownloadManager;
}

//Properties
@property (assign) IBOutlet NSButton *butSave;
@property (assign) IBOutlet NSTextField *stockSymbolName;
@property (weak) IBOutlet NSButton *butToggleView;
@property (weak) IBOutlet BasicBackGroundView *searchResultsView;
@property (weak) IBOutlet JAListView *listView;
@property (strong) CoreDataController *coreDataController;
@property (strong) SPADataDownloadManager *stockDownloadManager;

//Method definitions
- (IBAction)SaveStock:(id)sender;
-(void)customizeView;
- (IBAction)toggleView:(id)sender;
-(void) searchForStock;
@end
