//
//  StockSearchListViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/14/13.
//
//

#import "DemoView.h"
#import "StockSearchListViewController.h"

@interface StockSearchListViewController ()

@property (nonatomic, strong) NSDictionary *selectedStockData;
@end

@implementation StockSearchListViewController
@synthesize listView;
@synthesize delegate;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        //self.listView.delegate = self;
        //self.listView.dataSource = self;
    }
    
    return self;
}


-(void)loadView{
    [super loadView];//Must call or AutoLayout will break
}

#pragma mark - JAListViewDelegate

- (void)listView:(JAListView *)list willSelectView:(JAListViewItem *)view {
    //NSLog(@"I will be selected");
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = YES;
        
        NSString *selectedSymbol = demoView.stockSymbol;
        
        if(delegate != nil){
            [delegate selectedStockFromListView:selectedSymbol];
        }
    }
}

- (void)listView:(JAListView *)list didSelectView:(JAListViewItem *)view {
   // NSLog(@"I was selected");
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = NO;
    }
}

- (void)listView:(JAListView *)list didUnSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = NO;
    }
}


#pragma mark JAListViewDataSource

- (NSUInteger)numberOfItemsInListView:(JAListView *)listView {
    return [_stockSearchResultsData count];
}

- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    DemoView *view = [DemoView demoView];
    
    //Get the object out of the array
    NSDictionary *searchItem = [_stockSearchResultsData objectAtIndex:index];
    NSString *textForCell =  [searchItem objectForKey:@"name"];
    textForCell = [textForCell stringByAppendingString:@" - "];
    textForCell = [textForCell stringByAppendingString:[searchItem objectForKey:@"symbol"]];
    
    view.text = textForCell;
    view.stockSymbol = [searchItem objectForKey:@"symbol"];

    return view;
}

@end
