//
//  StockDetailViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/9/13.
//
//

#import "SPAConstants.h"
#import "Stock.h"
#import "CoreDataManager.h"
#import <Cocoa/Cocoa.h>

@interface SPAStockDetailViewController : NSViewController {
    __weak NSTextField *d;
    __weak NSTextField *currentPriceTextview;
    __weak NSTextField *lowPriceTextView;
    __weak NSTextField *highPriceTextView;
    __weak NSTextField *numberOfSharesTextView;
    __weak NSButton *deleteStockButton;
    __weak NSButton *saveStockButton;
    __weak NSButton *deleteStockClick;
}
@property (weak) IBOutlet NSTextField *currentPriceTextview;
@property (weak) IBOutlet NSTextField *lowPriceTextView;
@property (weak) IBOutlet NSTextField *highPriceTextView;
@property (weak) IBOutlet NSTextField *numberOfSharesTextView;
@property (weak) IBOutlet NSButton *deleteStockButton;
@property (weak) IBOutlet NSButton *saveStockButton;
@property (weak) IBOutlet NSButton *deleteStockClick;

- (IBAction)saveStockClick:(id)sender;

@property ViewMode *viewMode;
@property (nonatomic, strong) Stock *stockEnity;
@property (nonatomic, strong) NSArray *stockDetailInfo;
@end
