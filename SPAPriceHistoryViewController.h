//
//  SPAPriceHistoryViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 5/2/13.
//
//

#import "JAListView.h"
#import "PullToRefreshScrollView.h"
#import <Cocoa/Cocoa.h>

@interface SPAPriceHistoryViewController : NSViewController <PullToRefreshDelegate>{
  
    __weak JAListView *listView;
    __weak PullToRefreshScrollView *pullToRefreshView;
}


@property (weak) IBOutlet JAListView *listView;
@end
