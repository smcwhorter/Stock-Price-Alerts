//
//  StockSearchListViewController.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/14/13.
//
//

#import "JAListView.h"
#import <Cocoa/Cocoa.h>

@protocol SPAStockSearchViewControllerDelegate

-(void) selectedStockFromListView:(NSString*)thisSelectedStock;
@end

@interface StockSearchListViewController : NSViewController <JAListViewDataSource, JAListViewDelegate> {
   
    __weak JAListView *listView;
}

@property (assign, nonatomic) id <SPAStockSearchViewControllerDelegate> delegate;

@property (weak) IBOutlet JAListView *listView;
@property (nonatomic, strong) NSArray *stockSearchResultsData;

@end
    
