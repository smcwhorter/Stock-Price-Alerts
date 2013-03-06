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
 
@interface StockEditViewController : NSViewController <NSTextViewDelegate, JAListViewDataSource, JAListViewDelegate, SAPDataDownloadCompleteDelegate>
{
    IBOutlet NSButton *butSearch;
    CoreDataController *coreDataController;
    __weak NSButton *toggleView;
    __weak BasicBackGroundView *searchResultsView;
    __weak JAListView *listView;
    __weak SquareBorderView *stockDetailsView;
    SPADataDownloadManager *stockDownloadManager;
    __weak NSLayoutConstraint *searchResultsVerticalLeadingConstraint;
    __weak NSLayoutConstraint *searchResultsVerticalTrailingConstraint;
    __weak NSButton *deleteStock;
    __weak NSLayoutConstraint *saveStockButton;
    BasicBackGroundView *saveStockClicked;
}

//Properties
@property (assign) IBOutlet NSButton *butSearch;
@property (assign) IBOutlet NSTextField *stockSymbolName;
@property (weak) IBOutlet BasicBackGroundView *searchResultsView;
@property (weak) IBOutlet JAListView *listView;
@property (weak) IBOutlet SquareBorderView *stockDetailsView;

@property (weak) IBOutlet NSLayoutConstraint *searchResultsVerticalLeadingConstraint;
@property (weak) IBOutlet NSLayoutConstraint *searchResultsVerticalTrailingConstraint;

@property (nonatomic, strong) CoreDataController *coreDataController;
@property (nonatomic, strong) SPADataDownloadManager *stockDownloadManager;
@property (nonatomic, strong) NSArray *searchResults;
@property (strong, nonatomic) NSArray *searchRessultsViewVisibleConstraints, *searchRessultsViewNotVisibleConstraints;

@end
