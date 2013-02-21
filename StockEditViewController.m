//
//  StockEditViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import "StockEditViewController.h"
#import "CoreDataController.h"
#import "SPAAppUtilies.h"
#import "SPADataDownloadManager.h"
#import "BasicBackGroundView.h"
#import "DemoView.h"


@interface StockEditViewController ()

@end

@implementation StockEditViewController

//Properties
@synthesize searchResultsView;
@synthesize listView;
@synthesize coreDataController;
@synthesize stockDownloadManager;


#pragma mark - NSViewController methods

//Returns an NSViewController object initialized to the nib file in the specified bundle.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Initialization code here.
        self.listView.canCallDataSourceInParallel = YES;
        [self.listView reloadData];
        
        //Create a new SPANetworkManager object
        stockDownloadManager = [[SPADataDownloadManager alloc] init];
        stockDownloadManager.delegate = self;
    }
   
    return self;
}

//Instantiate the receiver’s view and set it
- (void)loadView{
    [super loadView];
   
}


#pragma mark - StockEditViewController method
-(void)customizeView{
   /*NSView *currentView = [self view];
    
    NSRect rec = NSMakeRect(currentView.frame.origin.x + 5, currentView.frame.origin.y+5, currentView.frame.size.width, currentView.frame.size.height);
    NSColor *mycolor = [SPAAppUtilies darkGray];
    [mycolor setFill];
    NSRectFill(rec);*/
    
}


-(void) searchForStock{
    //Call the download manager to search for the stock
    [stockDownloadManager searchForStockWithCriteria:@"S"];
    
    //TODO: Show loading dialog
}

- (IBAction)SaveStock:(id)sender {
    NSString *val = [_stockSymbolName stringValue];
    NSLog(@"Stock Edit Button clicked - %@",val);
    
    //Call method to search for the stock
    [self searchForStock];
    
    //NSRect frame = NSMakeRect(200.0, 0.0, 200.0, 200.0);
    //StockEditViewController *anotherStockEditViewController = [[StockEditViewController alloc] initWithNibName:@"StockEditViewController" bundle:nil];
    //NSView *nextView = [anotherStockEditViewController view];
    //[nextView setFrame:frame];
    
    //[[self.view superview] addSubview:nextView positioned:NSWindowAbove relativeTo:self.view];
    //[self]
    /*
     //Call method to add a new stock
     if(coreDataController != nil)
     {
     [coreDataController addStockEnitiy];
     NSInteger *stockCount = [coreDataController stockEntityCount];
     NSLog(@"Number of items in the array:%d",stockCount);
     }
     */
}


- (IBAction)toggleView:(id)sender {
    
    NSRect frame = searchResultsView.frame;
    if(frame.size.height == 0)
    {
         frame.size.height = 200;
    }
    if(frame.size.height > 0)
    {
        frame.size.height = 0;
    }
    
       
    if([searchResultsView isHidden] == YES)
    {
         [[searchResultsView animator] setAlphaValue:1.0];
        
        //[searchResultsView setNeedsDisplay:YES];
        
        [NSAnimationContext beginGrouping];
        
        [[NSAnimationContext currentContext] setCompletionHandler:^{
            NSLog(@"Add Animation Complete");
            [searchResultsView setHidden:NO];
            
        }];
        
        [[NSAnimationContext currentContext] setDuration:0.5];
        //Set this view's frame out of the main window's view
         [[searchResultsView animator] setAlphaValue:1.0];
        
        [NSAnimationContext endGrouping];

    }
   else
   {
       
       [NSAnimationContext beginGrouping];
       
       [[NSAnimationContext currentContext] setCompletionHandler:^{
           NSLog(@"Add Animation Complete");
           [searchResultsView setHidden:YES];
           
       }];
       
       [[NSAnimationContext currentContext] setDuration:0.5];
       //Set this view's frame out of the main window's view
       [[searchResultsView animator] setAlphaValue:0.0];
       
       [NSAnimationContext endGrouping];;

    }

}

#pragma mark - SPADataDownloadManagerDelegate
-(void) downloadDataCompletewithData:(NSMutableData *)theData {
    
    NSArray *searchResults = [SPAAppUtilies parseDownloadedDataForSearchResults:theData];
   // NSLog(@"%@",searchResults);
    //NSEnumerator *iterator = [searchResults keyEnumerator];
    
    
    for(NSDictionary *thisJSONObject in searchResults){
        //id value = [searchResults objectForKey:thisKey];
       // NSLog(@"%@",thisJSONObject);
        NSString *s = [thisJSONObject objectForKey:@"name"];
        NSLog(@"%@",s);

    }
  // NSArray* searchResultsArray = [searchResults objectForKey:@""];
}

#pragma mark - JAListViewDelegate

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


#pragma mark - JAListViewDataSource

- (NSUInteger)numberOfItemsInListView:(JAListView *)listView {
    return 100;
}

- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    DemoView *view = [DemoView demoView];
    view.text = [NSString stringWithFormat:@"Row %d", (int)index + 1];
    return view;
}
@end
