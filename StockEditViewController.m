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


@property (nonatomic, strong) NSString *searchCriteriaString;

@property (weak) IBOutlet NSTextField *currentPriceLabel;
@property (weak) IBOutlet NSTextField *lowPriceTextField;
@property (weak) IBOutlet NSTextField *highPriceTextField;
@property (weak) IBOutlet NSTextField *numOfSharesTextField;
@property (weak) IBOutlet NSButton *deleteStockButton;
@property (weak) IBOutlet NSLayoutConstraint *saveStockButton;

- (IBAction) butSearchClicked:(id)sender;
- (IBAction)textFieldAction:(id)sender;
- (IBAction)saveStockClicked:(id)sender;
- (IBAction)deleteStockClicked:(id)sender;

- (void) toggleViewFadeInOut:(id)sender;
- (void) searchForStock:(NSString*) theSeachString;
- (void) searchForStock:(NSString*) theSeachString;
- (void) setUpConstraints;
- (void) toggleSearchResultsViewVisable:(BOOL)isVisible;
@end

@implementation StockEditViewController

//Properties
@synthesize currentPriceLabel;
@synthesize lowPriceTextField;
@synthesize highPriceTextField;
@synthesize numOfSharesTextField;
@synthesize saveStockButton;
@synthesize searchResultsView;
@synthesize listView;
@synthesize stockDetailsView;
@synthesize coreDataController;
@synthesize stockDownloadManager;
@synthesize searchResultsVerticalLeadingConstraint;
@synthesize searchResultsVerticalTrailingConstraint;
@synthesize searchRessultsViewVisibleConstraints, searchRessultsViewNotVisibleConstraints;

-(void) setsearchCriteriaString:(NSString *)searchCriteriaString{
    _searchCriteriaString = searchCriteriaString;
    _searchCriteriaString = [_searchCriteriaString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
}

#pragma mark - NSViewController methods

//Returns an NSViewController object initialized to the nib file in the specified bundle.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        // Initialization code here
    
    }
   
    return self;
}

//Instantiate the receiver’s view and set up the initial display
- (void)loadView{
    [super loadView];
    
    //Create a new SPANetworkManager object
    if(self.stockDownloadManager == nil){
        self.stockDownloadManager = [[SPADataDownloadManager alloc] init];
        self.stockDownloadManager.delegate = self;
    }
    
    //The search results are hidden by default
    [self.searchResultsView setHidden:YES];
    [self.stockDetailsView setHidden:YES];
}

#pragma mark - StockEditViewController method

-(IBAction)textFieldAction:(id)sender{
    _searchCriteriaString = [_stockSymbolName stringValue];
    //Call the download manager to search for the stock
    [self.stockDownloadManager searchForStockWithCriteria:_searchCriteriaString];
}

- (IBAction)saveStockClicked:(id)sender {
}

- (IBAction)deleteStockClicked:(id)sender {
}

- (IBAction)butSearchClicked:(id)sender {
    _searchCriteriaString = [_stockSymbolName stringValue];
    //Call the download manager to search for the stock
    [stockDownloadManager searchForStockWithCriteria:_searchCriteriaString];
    
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

-(void) displaySearchTableView{
    
    
    //Bind the listview
    self.listView.canCallDataSourceInParallel = YES;
    self.listView.delegate = self;
    
    if(searchResultsView.isHidden){
        //Display the search results
        [self toggleSearchResultsViewVisable:YES];
    }
    [self.stockDetailsView setHidden:YES];
    [self.listView reloadData];
}

-(void) displayStockDetails:(NSArray*)theDetails{
    [self toggleSearchResultsViewVisable:NO];
    [self.stockDetailsView setHidden:NO];
       
    if(theDetails.count >= 10){
        
         [self.currentPriceLabel setStringValue:[NSString stringWithFormat:@"%@ - Price: $%@",[theDetails objectAtIndex:1],[theDetails objectAtIndex:4]]];
    }
    else{
       [self.currentPriceLabel setStringValue:[NSString stringWithFormat:@"%@ - Price: $%@",[theDetails objectAtIndex:1],[theDetails objectAtIndex:3]]];
    }
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

#pragma mark - SPADataDownloadManagerDelegate
-(void) downloadDataCompletewithData:(NSMutableData *)theData forStockDataType:(StockDownloadDataType)theStockDataType{
    
    if(theStockDataType == StockSearchData){
        //NSString *sringData = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
        //NSLog(@"%@",sringData);
        //Get the search results from the downloaded data
        
        _searchResults = [SPAAppUtilies parseDownloadedDataForSearchResults:theData];
        
        if(_searchResults.count > 0){
            [self displaySearchTableView];
        }else {
            //TODO: Display Alert
            NSLog(@"No search results");
        }
    }
    
    if(theStockDataType == AdditionalDetailsData){
        //NSString *stockDetailsData = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
        NSArray *stockDetails = [SPAAppUtilies parseDownloadedDataForAdditionalData:theData];
        
        if(stockDetails.count > 0){
            [self displayStockDetails:stockDetails];
        }else{
            //TODO:Display alert
        }
        //NSLog(@"Stock Details: %@",stockDetails);
        
    }
}

#pragma mark - JAListViewDelegate

- (void)listView:(JAListView *)list willSelectView:(JAListViewItem *)view {
    if(list == self.listView) {
        DemoView *demoView = (DemoView *) view;
        demoView.selected = YES;
        
        //Call method to download the stock details
        //self.stockDownloadManager.
        [self.stockDownloadManager fetchStockDetailInformation:[_stockSymbolName stringValue]];
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


#pragma mark - JAListViewDataSource Delegate

//return the number of items for the list
- (NSUInteger)numberOfItemsInListView:(JAListView *)listView {
    return [_searchResults count];
}

//Returns a view for each index
- (JAListViewItem *)listView:(JAListView *)listView viewAtIndex:(NSUInteger)index {
    //Create a new custom view for the cell
    DemoView *view = [DemoView demoView];
    
    //Get the object out of the array
    NSDictionary *searchItem = [_searchResults objectAtIndex:index];
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
