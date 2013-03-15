//
//  StockSearchListViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/14/13.
//
//

#import "JAListView.h"
#import <Cocoa/Cocoa.h>


@interface StockSearchListViewController : NSViewController <JAListViewDataSource, JAListViewDelegate> {
   
    __weak JAListView *listView;
}
 


@property (weak) IBOutlet JAListView *listView;
@end
    
