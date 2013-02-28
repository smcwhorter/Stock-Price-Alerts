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
@synthesize stockDetailsView;
@synthesize coreDataController;
@synthesize stockDownloadManager;
@synthesize searchResults;
@synthesize searchResultsVerticalLeadingConstraint;
@synthesize searchResultsVerticalTrailingConstraint;
@synthesize searchRessultsViewVisibleConstraints, searchRessultsViewNotVisibleConstraints;

#pragma mark - NSViewController methods

//Returns an NSViewController object initialized to the nib file in the specified bundle.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Initialization code here
    
        //Create a new SPANetworkManager object
        stockDownloadManager = [[SPADataDownloadManager alloc] init];
        stockDownloadManager.delegate = self;
    }
   
    return self;
}

//Instantiate the receiver’s view and set up the initial display
- (void)loadView{
    [super loadView];
    //[self toggleSearchResultsView];
    //The search results are hidden by default
    [self.searchResultsView setHidden:YES];
    [self.stockDetailsView setHidden:YES];
}




#pragma mark - StockEditViewController method

- (void)setUpConstraints
{
    
    
    [NSAnimationContext beginGrouping];
    NSAnimationContext.currentContext.duration = 0.5;
    //NSAnimationContext.currentContext.completionHandler = ^{[self removeConstraint:collapseConstraint];};
    [searchResultsVerticalTrailingConstraint.animator setConstant:30];
    [NSAnimationContext endGrouping];
    //
   // searchResultsVerticalTrailingConstraint.constant = 150;
   /*
    searchRessultsViewVisibleConstraints = [self.searchResultsView constraints];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(searchResultsView);
    NSLog(@"%@",views);
    NSDictionary *metrics = NSDictionaryOfVariableBindings(@500,@10);
    
    NSArray *c1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-500-[searchResultsView]-0-|"
                                                          options:NSLayoutFormatDirectionLeadingToTrailing
                                                          metrics:metrics
                                                            views:views];
    
    NSMutableArray *newConstraints = [NSMutableArray array];
    
    //[self mergeArraysInto:&newConstraints, c1, nil];
    
    searchRessultsViewNotVisibleConstraints = newConstraints;*/
}

//This t
-(void) searchForStock{
    NSString *searchCriteria = [self.stockSymbolName stringValue];
    searchCriteria = [searchCriteria stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    //Call the download manager to search for the stock
    [stockDownloadManager searchForStockWithCriteria:searchCriteria];
    
    //TODO: Show loading dialog
}

- (IBAction)butSearchClicked:(id)sender {
    NSString *val = [_stockSymbolName stringValue];
    //NSLog(@"Stock Edit Button clicked - %@",val);
    
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

- (void) toggleSearchResultsViewVisable:(BOOL)isVisible{
    
    CGFloat currentValue = searchResultsVerticalTrailingConstraint.constant;
    CGFloat startAlphValue = 0.0;
    CGFloat endAlphValue = 0.0;
    if(isVisible == YES){
        currentValue = 50.0;
        startAlphValue = 0.0;
        endAlphValue = 1.0;
        [searchResultsView setHidden:NO];
    }else{
        currentValue = 200.0;
        startAlphValue = 1.0;
        endAlphValue = 0.0;
    }
    
   
    [searchResultsView setAlphaValue:startAlphValue];
    
    //Setup the animation
    [NSAnimationContext beginGrouping];
    NSAnimationContext.currentContext.duration = 0.2;
    NSAnimationContext.currentContext.completionHandler = ^{
        if(!isVisible){
             [searchResultsView setHidden:YES];
        }
    };
    [[searchResultsView animator] setAlphaValue:endAlphValue];
    [searchResultsVerticalTrailingConstraint.animator setConstant:currentValue];
    [NSAnimationContext endGrouping];
}


- (IBAction)toggleViewFadeInOut:(id)sender {
    
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
            //NSLog(@"Add Animation Complete");
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
           //NSLog(@"Add Animation Complete");
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
    
    //Get the search results from the downloaded data
    self.searchResults = [SPAAppUtilies parseDownloadedDataForSearchResults:theData];
    
    //Bind the listview
    self.listView.canCallDataSourceInParallel = YES;
    [self.listView reloadData];
    self.listView.delegate = self;
    
    if(searchResultsView.isHidden){
        //Display the search results
        [self toggleSearchResultsViewVisable:YES];
    }
}

#pragma mark - JAListViewDelegate

- (void)listView:(JAListView *)list willSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = YES;
        [self toggleSearchResultsViewVisable:NO];
        [self.stockDetailsView setHidden:NO];
    }
}

- (void)listView:(JAListView *)list didSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = NO;
        NSLog(@"Selected: %@", demoView.text);
        
    }
}

- (void)listView:(JAListView *)list didUnSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = NO;
    }
}


#pragma mark - JAListViewDataSource

//return the number of items for the list
- (NSUInteger)numberOfItemsInListView:(JAListView *)listView {
    return [searchResults count];
}

//Returns a view for each index
- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    //Create a new custom view for the cell
    DemoView *view = [DemoView demoView];
    
    //Get the object out of the array
    NSDictionary *searchItem = [searchResults objectAtIndex:index];
    NSString *textForCell =  [searchItem objectForKey:@"name"];
    textForCell = [textForCell stringByAppendingString:@" - "];
    textForCell = [textForCell stringByAppendingString:[searchItem objectForKey:@"symbol"]];
    view.text = textForCell;
    //view.textField = @"test";
    //view.shadowTextField = @"b";
    //NSLog(@"%@",searchItem);
    return view;
}
@end
