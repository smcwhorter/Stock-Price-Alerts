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

@end

@implementation StockSearchListViewController
@synthesize listView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
        self.listView.canCallDataSourceInParallel = YES;
        self.listView.delegate = self;
        [self.listView reloadData];
    }
    
    return self;
}

/** AutoLayout causes this to break*/
//-(void)loadView{}

#pragma mark JAListViewDelegate

- (void)listView:(JAListView *)list willSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = YES;
    }
}

- (void)listView:(JAListView *)list didSelectView:(JAListViewItem *)view {
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
    return 100;
}

- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    DemoView *view = [DemoView demoView];
    view.text = [NSString stringWithFormat:@"Row %d", (int)index + 1];
    return view;
}

@end
