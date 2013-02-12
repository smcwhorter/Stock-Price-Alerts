//
//  StockListViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import <Cocoa/Cocoa.h>

#import "JAListView.h"
#import "SPAHeaderViewController.h"

@interface StockListViewController : NSViewController <JAListViewDataSource, JAListViewDelegate>
{
    IBOutlet JAListView *listView;
    
}
@property (assign) IBOutlet JAListView *listView;

@end
