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
#import "SquareBorderView.h"
#import "JAListView.h"
#import "SPADataDownloadManager.h"
 
@interface StockEditViewController : NSViewController <NSTextViewDelegate, SAPDataDownloadCompleteDelegate>
{
    IBOutlet NSButton *butSearch;
}

//Properties
@property (assign) IBOutlet NSButton *butSearch;
@property (assign) IBOutlet NSTextField *stockSymbolName;
@property (nonatomic, strong) CoreDataController *coreDataController;

@end
