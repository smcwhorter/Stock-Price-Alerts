//
//  StockListViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import <Cocoa/Cocoa.h>
#import "PXListView.h"

@interface StockListViewController : NSViewController <PXListViewDelegate>
{
    IBOutlet PXListView	*listView;
    NSMutableArray *_listItems;
}

- (IBAction)reloadTable:(id)sender;
@end
