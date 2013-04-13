//
//  SPAListViewCellBackground.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/24/13.
//
//

#import <Cocoa/Cocoa.h>
#import "JAListViewItem.h"

@interface StockListViewCell : JAListViewItem
{
    BOOL selected;
    __weak NSTextField *tickerTextView;
    __weak NSTextField *companyNameTextView;
    __weak NSTextField *currentPriceTextView;
    __weak NSTextField *priceChangeTextView;
    __weak NSTextField *lowPriceTextView;
    __weak NSTextField *highPriceTextView;
    __weak NSTextField *yearRangeTextView;
    __weak NSTextField *targetPriceTextView;
    __weak NSImageView *priceDirectionImageView;
    __weak NSImageView *lowPriceImageView;
    __weak NSImageView *highPriceImageView;
}
@property (weak) IBOutlet NSTextField *tickerTextView;
@property (weak) IBOutlet NSTextField *companyNameTextView;
@property (weak) IBOutlet NSTextField *currentPriceTextView;
@property (weak) IBOutlet NSTextField *priceChangeTextView;
@property (weak) IBOutlet NSTextField *lowPriceTextView;
@property (weak) IBOutlet NSTextField *highPriceTextView;

@property (weak) IBOutlet NSTextField *yearRangeTextView;
@property (weak) IBOutlet NSTextField *targetPriceTextView;
@property (weak) IBOutlet NSImageView *priceDirectionImageView;
@property (weak) IBOutlet NSImageView *lowPriceImageView;
@property (weak) IBOutlet NSImageView *highPriceImageView;

+ (StockListViewCell *)stockListViewCell;
@end
