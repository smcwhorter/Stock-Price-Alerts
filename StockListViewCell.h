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
}
@property (weak) IBOutlet NSTextField *tickerTextView;
@property (weak) IBOutlet NSTextField *companyNameTextView;
+ (StockListViewCell *)stockListViewCell;
@end
