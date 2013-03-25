//
//  StockListViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import "StockListViewController.h"
#import "DemoView.h"
#import "StockListViewCell.h"
#import "CoreDataManager.h"
#import "Stock.h"


@interface StockListViewController ()
@property (nonatomic, strong) NSArray *stockList;
@end

@implementation StockListViewController
@synthesize listView;

#pragma mark - ViewController Overrides
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        self.listView.canCallDataSourceInParallel = YES;
    }
    return self;
}

-(void)loadView{
    [super loadView];
    [self bindListViewWithStockList];
}

#pragma mark - Controller Methods

-(void)bindListViewWithStockList{
    _stockList = [[CoreDataManager sharedManager] stockList];
    [self.listView reloadData];

}
#pragma mark JAListViewDelegate

- (void)listView:(JAListView *)list willSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        //DemoView *demoView = (DemoView *) view;
        //demoView.selected = YES;
    }
}

- (void)listView:(JAListView *)list didSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        //DemoView *demoView = (DemoView *) view;
        //demoView.selected = NO;
    }
}

- (void)listView:(JAListView *)list didUnSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        //DemoView *demoView = (DemoView *) view;
        //demoView.selected = NO;
    }
}


#pragma mark JAListViewDataSource

- (NSUInteger)numberOfItemsInListView:(JAListView *)listView {
    return [_stockList count];
}

- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    //Create a new Cell
    StockListViewCell *cellView = [StockListViewCell stockListViewCell];
    //DemoView *view = [DemoView demoView];
    
    //Get the stock obect from the list
    Stock *stockData = (Stock*)[_stockList objectAtIndex:index];
    cellView.tickerTextView.stringValue = stockData.symbol;
    cellView.companyNameTextView.stringValue = stockData.companyName;
    
//    view.text = stockData.symbol;
    return cellView;
}


@end
