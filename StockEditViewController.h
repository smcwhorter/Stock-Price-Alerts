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
#import "SPAStockDetailViewController.h"
#import "StockSearchListViewController.h"

@protocol SPAStockEditViewControllerDelegate
-(void) stockEditViewControllerFinished;
@end

@interface StockEditViewController : NSViewController <NSTextViewDelegate, SPADataDownloadCompleteDelegate, SPAStockDetailsViewDelegate, SPAStockSearchViewControllerDelegate>
{
    IBOutlet NSButton *butSearch;
}

//Properties
@property (assign, nonatomic) id <SPAStockEditViewControllerDelegate> delegate;

@property (assign) IBOutlet NSButton *butSearch;
@property (assign) IBOutlet NSTextField *stockSymbolName;
@property (assign) StockDetailsViewMode viewMode;

-(void)initViewLayout;
@end
