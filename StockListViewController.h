//
//  StockListViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import <Cocoa/Cocoa.h>
#import "JAListView.h"

@interface StockListViewController : NSViewController <JAListViewDataSource, JAListViewDelegate>
{
    IBOutlet __unsafe_unretained JAListView *listView;
}
@property (assign) __unsafe_unretained IBOutlet JAListView *listView;

-(void)bindListViewWithStockList;
@end
