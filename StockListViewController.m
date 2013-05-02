//
//  StockListViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import "StockListViewController.h"
#import "PullToRefreshScrollView.h"
#import "DemoView.h"
#import "StockListViewCell.h"
#import "CoreDataManager.h"
#import "Stock.h"
#import "SPAStockWebServiceDataParser.h"
#import "SPADataDownloadManager.h"

//****************************Private Section************************
@interface StockListViewController () <SPADataDownloadCompleteDelegate>
@property (nonatomic, strong) NSArray *stockList;
@property (weak) IBOutlet PullToRefreshScrollView *pullToRefreshView;
@property (strong, nonatomic) SPADataDownloadManager *stockDataDownloadManager;
@property (strong, nonatomic) NSString *listOfStockSeperatedByComma;
@end

@implementation StockListViewController

//****************************Public Properties Section***************
@synthesize listView;
@synthesize pullToRefreshView;
@synthesize listOfStockSeperatedByComma;

#pragma mark - ViewController Overrides
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        self.listOfStockSeperatedByComma = [[NSString alloc] init];
        if(self.stockDataDownloadManager == nil){
            self.stockDataDownloadManager = [[SPADataDownloadManager alloc] init];
            self.stockDataDownloadManager.delegate = self;
        }
        self.listView.canCallDataSourceInParallel = YES;
        
    }
    return self;
}

-(void)loadView{
    [super loadView];
    if(pullToRefreshView != nil){
        pullToRefreshView.delegate = self;
    }
    //_listOfStockSeperatedByComma = @"";
    [self bindListViewWithStockList];
}

#pragma mark - Private Methods

-(void)bindListViewWithStockList{
    _stockList = [[CoreDataManager sharedManager] stockList];
    [self.listView reloadData];

}

-(StockListViewCell*) createANewStockListViewCellForStock:(Stock*)thisStock{
    
    //Create a new Cell
    StockListViewCell *cellView = [StockListViewCell stockListViewCell];
    
    cellView.tickerTextView.stringValue = thisStock.symbol;
    cellView.companyNameTextView.stringValue = thisStock.companyName;
    cellView.currentPriceTextView.stringValue = [NSString stringWithFormat:@"Price: $%@",thisStock.currentPrice];
    cellView.priceChangeTextView.stringValue = thisStock.percentChange;
    cellView.lowPriceTextView.stringValue = [NSString stringWithFormat:@"Low Price Alerts: $%@",thisStock.lowPriceAlert];
    cellView.highPriceTextView.stringValue =[NSString stringWithFormat:@"High Price Alert: $%@",thisStock.highPriceAlert];
    cellView.yearRangeTextView.stringValue = [NSString stringWithFormat:@"52 Week Range: %@", thisStock.priceRange];
    cellView.targetPriceTextView.stringValue = [NSString stringWithFormat:@"Target Price: %@",thisStock.priceRange];
    
    
    NSRange charToFind = [thisStock.percentChange rangeOfString:@"-"];
    if(charToFind.length > 0){
        NSImage *redImage = [NSImage imageNamed:@"redarrow.png"];
        cellView.priceDirectionImageView.image = redImage;
    }else{
        NSImage *greenImage = [NSImage imageNamed:@"greenarrow.png"];
        cellView.priceDirectionImageView.image = greenImage;
    }
    
    return  cellView;
}

-(void) buildCommaSeperatedListOfSymbols
{
    NSString *symbolComma = @"";
    for(id stockEntity in _stockList)
    {
        Stock *stockData = (Stock*)stockEntity;
        symbolComma = [symbolComma stringByAppendingString:[stockData.symbol stringByAppendingFormat:@","]];
    }
    
    self.listOfStockSeperatedByComma = symbolComma;
}


#pragma mark - ScrollToRefresh Delegate
- (void)ptrScrollViewDidTriggerRefresh:(id)sender {
    //NSLog(@"This is called by the PullToRefresh delegate protocol");
    [self buildCommaSeperatedListOfSymbols];
    [_stockDataDownloadManager fetchStockDetailInformation:self.listOfStockSeperatedByComma];
}

#pragma mark - SPAStockDownloadManager Delegate
-(void) downloadDataCompletewithData:(NSMutableData *)theData forStockDataType:(StockDownloadDataType)theStockDataType{
    NSMutableDictionary *refreshedStockListData = [SPAStockWebServiceDataParser parseDownloadedDataForAdditionalData:theData];
    //NSLog(@"Stock: %@",refreshedStockListData);
    [[CoreDataManager sharedManager] updateStockListWithPriceHistoryData:refreshedStockListData];
    [self bindListViewWithStockList];
    [pullToRefreshView stopLoading];
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
    
    //Get the stock obect from the list
    Stock *stockData = (Stock*)[_stockList objectAtIndex:index];
    StockListViewCell *cellView = [self createANewStockListViewCellForStock:stockData];
    return cellView;
}

@end
