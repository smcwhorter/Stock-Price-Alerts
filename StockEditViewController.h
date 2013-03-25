//
//  StockEditViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import <Cocoa/Cocoa.h>
#import "CoreDataManager.h"
#import "BasicBackGroundView.h"
#import "SquareBorderView.h"
#import "JAListView.h"
#import "SPADataDownloadManager.h"
 
@interface StockEditViewController : NSViewController <NSTextViewDelegate, SPADataDownloadCompleteDelegate>
{
    IBOutlet NSButton *butSearch;
}

//Properties
@property (assign) IBOutlet NSButton *butSearch;
@property (assign) IBOutlet NSTextField *stockSymbolName;

@end
