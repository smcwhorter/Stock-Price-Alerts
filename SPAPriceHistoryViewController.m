//
//  SPAPriceHistoryViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 5/2/13.
//
//

#import "JAListView.h"
#import "DemoView.h"
#import "PullToRefreshScrollView.h"
#import "SPAPriceHistoryViewController.h"

@interface SPAPriceHistoryViewController ()
@property (weak) IBOutlet PullToRefreshScrollView *pullToRefreshView;

@end

@implementation SPAPriceHistoryViewController
@synthesize pullToRefreshView;
@synthesize listView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
    self.listView.canCallDataSourceInParallel = YES;
    
    return self;
}

-(void)loadView{
    [super loadView];
    if(pullToRefreshView != nil){
        pullToRefreshView.delegate = self;
    }
}

-(void) ptrScrollViewDidTriggerRefresh:(id)sender{
    
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
    return 10;
}

- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    DemoView *cellView = [[DemoView alloc] init];
    cellView.textField.value = @"test";
    return cellView;
}

@end
