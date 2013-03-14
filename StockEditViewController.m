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
#import "SPAStockDetailViewController.h"
#import "DemoView.h"


@interface StockEditViewController ()

@property (weak) IBOutlet NSView *placeholderView;

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
@synthesize placeholderView;
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
@synthesize placeholderHorizontalTrailingContraint;
@synthesize placeholderHorizontalLeadingConstraint;
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
    
    // Initialization code here
    SPAStockDetailViewController *stockDetailVC = [[SPAStockDetailViewController alloc] initWithNibName:@"StockDetailsView" bundle:nil];
    //stockDetailVC.view.frame = placeholderView.bounds;
    
    BasicBackGroundView *_stockDetailsView = stockDetailVC.view;
    [_stockDetailsView setTranslatesAutoresizingMaskIntoConstraints:NO];

    
    
    //NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_stockDetailsView);
    
    [self.view addSubview:_stockDetailsView];
    
   [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[_stockDetailsView(>=200)]-(50)-|"
                                                          options:0
                                                          metrics:nil
                                                          views:NSDictionaryOfVariableBindings(_stockDetailsView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(125)-[_stockDetailsView(>=200)]-|"
                                                                                 options:0
                                                                                 metrics:nil
                                                                                   views:NSDictionaryOfVariableBindings(_stockDetailsView)]];
    NSArray *constraints = [self.view constraints];
    NSLog(@"%@",constraints);
    /*
     NSLayoutConstraint *horizontalConstraint = [NSLayoutConstraint
     constraintsWithVisualFormat:@"H:|-(50)-[_stockDetailsView(>=200)]-(50)-|"
     options:0
     metrics:nil
     views:NSDictionaryOfVariableBindings(_stockDetailsView)];
     
     NSLayoutConstraint *verticalConstraint = [NSLayoutConstraint
     constraintsWithVisualFormat:@"V:|-(125)-[_stockDetailsView(>=200)]-(100)-|"
     options:0
     metrics:nil
     views:NSDictionaryOfVariableBindings(_stockDetailsView)];
     
     NSArray *constraints  = @[horizontalConstraint, verticalConstraint];
     [self.view addConstraint:horizontalConstraint];
     [self.view addConstraint:verticalConstraint];*/

    NSLog(@"Place Holder: Frame %@ - bounds %@",NSStringFromRect(self.placeholderView.frame),NSStringFromRect(self.placeholderView.bounds));
    NSLog(@"Details View Frame %@ - bounds %@",NSStringFromRect(stockDetailVC.view.frame),NSStringFromRect(stockDetailVC.view.bounds));
        
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
    //Call method to add a new stock
    if(coreDataController != nil)
    {
        [coreDataController addStockEnitiy];
        NSInteger *stockCount = [coreDataController stockEntityCount];
        NSLog(@"Number of items in the array:%d",stockCount);
    }
    
}

- (IBAction)deleteStockClicked:(id)sender {
}

- (IBAction)butSearchClicked:(id)sender {
    _searchCriteriaString = [_stockSymbolName stringValue];
    //Call the download manager to search for the stock
    [stockDownloadManager searchForStockWithCriteria:_searchCriteriaString];
}

//Display the listsview with the search results
-(void) displaySearchTableView{

    //Bind the listview
    self.listView.canCallDataSourceInParallel = YES;
    self.listView.delegate = self;
    
    /*NSArray *constrains = [[NSArray alloc]
                           initWithObjects:searchResultsVerticalLeadingConstraint,
                           searchResultsVerticalTrailingConstraint,
                           placeholderHorizontalLeadingConstraint,
                           placeholderHorizontalTrailingContraint
                           ,nil];*/
   // [stockDetailsView addConstraints:constrains];
    
    //[self.placeholderView addSubview:stockDetailsView];
   /* [self.placeholderView removeFromSuperview];
   
    NSLayoutConstraint *c = [NSLayoutConstraint constraintWithVisualFormat:
                @"V:|-[stockDetailsView(200)]-|"
                                                      options:NSLayoutFormatAlignAllLeft
                                                      metrics:nil
                                                                     views:NSDictionaryOfVariableBindings()];
    NSArray *constrains = [[NSArray alloc]
                           initWithObjects:c,nil];
    [stockDetailsView addConstraints:constrains];
     [self.view addSubview:stockDetailsView];*/
    //if(searchResultsView.isHidden){
        //Display the search results
    //    [self toggleSearchResultsViewVisable:YES];
    //}
    [self.stockDetailsView setHidden:YES];
    [self.listView reloadData];
}

//Display the selected stock details - i.e., currect price, low/high price
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

//This will animate the tableview visable by changing its alpha and auto layout contraint
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
//Delegate method to is called with data has been downloaded
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
    return view;
}
@end
