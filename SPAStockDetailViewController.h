//
//  StockDetailViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/9/13.
//
//

#import "SPAConstants.h"
#import <Cocoa/Cocoa.h>

@protocol SPAStockDetailsViewDelegate
-(void) stockDetailsViewControllerSavedStock;
-(void) stockDetailsViewControllerDeletedStock;
@end

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

@property (assign) StockDetailsViewMode viewMode;
@property (nonatomic, strong) NSDictionary *stockListDetailInfo;

@property (assign, nonatomic) id <SPAStockDetailsViewDelegate> delegate;

-(void) initViewWithStockDetails;
- (IBAction)saveStockClick:(id)sender;


@end
