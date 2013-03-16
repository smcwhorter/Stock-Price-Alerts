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
#import "StockSearchListViewController.h"
#import "StockDetailsView.h"
#import "StockSearchListView.h"
#import "DemoView.h"


@interface StockEditViewController ()

- (IBAction) butSearchClicked:(id)sender;
- (IBAction)textFieldAction:(id)sender;

@property (nonatomic, strong) NSString *searchCriteriaString;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) SPADataDownloadManager *stockDownloadManager;
@property (nonatomic, strong) StockSearchListViewController *searchListViewController;
@property (nonatomic, strong) SPAStockDetailViewController *stockDetailViewController;
@property (nonatomic, strong) StockSearchListView *stockSearchListView;
@property (nonatomic, strong) StockDetailsView *_stockDetailsView;

- (void) toggleViewFadeInOut:(id)sender;
- (void) searchForStock:(NSString*) theSeachString;
- (void) searchForStock:(NSString*) theSeachString;
- (void) setUpConstraints;
- (void) toggleSearchResultsViewVisable:(BOOL)isVisible;
@end


@implementation StockEditViewController

//Properties
@synthesize coreDataController;
@synthesize stockDownloadManager;


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

#pragma mark - StockSearchListViewController

//Display the listsview with the search results
-(void) loadSearchListViewController{
   
    if(_searchListViewController == nil){
        _searchListViewController = [[StockSearchListViewController alloc] initWithNibName:@"StockSearchListView" bundle:nil];
    }
   
    //Set the list's data and load it
    _searchListViewController.stockDownloadManager = stockDownloadManager;
    _searchListViewController.stockSearchResultsData = _searchResults;
    [_searchListViewController.listView reloadData];
    
    //Call mehod to layout the views on the super view
    [self layoutStockSearchListView];
    
}

-(void) layoutStockSearchListView{
    
    //Remove the list view
    if(_stockSearchListView != nil){
        [_stockSearchListView removeFromSuperview];
    }

    //Get the view from the controlelr
    _stockSearchListView = _searchListViewController.view;
    [_stockSearchListView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _stockSearchListView.alphaValue = 0;
    
    //Add the view to the superview
    [self.view addSubview:_stockSearchListView];
    
    //Define the layout constraints
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[_stockSearchListView(>=200)]-(50)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockSearchListView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(150)-[_stockSearchListView(>=200)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockSearchListView)]];
    
    //TODO: Need to fix - needs bottom veritical padding
    NSLayoutConstraint *trailingVerticalConstraint = [NSLayoutConstraint constraintWithItem:_stockSearchListView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                     toItem:self.view
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1
                                                                                   constant:0];
    
    [self.view addConstraint:trailingVerticalConstraint];
    
    //Setup the animation
    [NSAnimationContext beginGrouping];
    NSAnimationContext.currentContext.duration = 1.0;
    NSAnimationContext.currentContext.completionHandler = ^{
        NSLog(@"Animation complete");
    };
    [[_stockSearchListView animator] setAlphaValue:1];
    
    [NSAnimationContext endGrouping];

}

#pragma mark - StockDetailsViewController

//Display the selected stock details - i.e., currect price, low/high price
-(void) loadStockDetailsViewController:(NSArray*)theDetails{
   
    if(_stockDetailViewController == nil)
    {
        _stockDetailViewController = [[SPAStockDetailViewController alloc] initWithNibName:@"StockDetailsView" bundle:nil];
    }
    
    _stockDetailViewController.stockDetailInfo = theDetails;
    
    [self layoutStockDetailsView];
}

-(void) layoutStockDetailsView{
    
    //Remove the list view
    [_stockSearchListView removeFromSuperview];
    
    StockDetailsView *_stockDetailsView = _stockDetailViewController.view;
    _stockDetailsView.alphaValue = 0;
    [_stockDetailsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:_stockDetailsView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[_stockDetailsView(>=200)]-(50)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockDetailsView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(150)-[_stockDetailsView(>=200)]"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockDetailsView)]];
    
    //TODO: Need to fix - needs bottom veritical padding
    NSLayoutConstraint *trailingVerticalConstraint = [NSLayoutConstraint constraintWithItem:_stockDetailsView
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                  relatedBy:NSLayoutRelationGreaterThanOrEqual
                                                                                     toItem:self.view
                                                                                  attribute:NSLayoutAttributeBottom
                                                                                 multiplier:1
                                                                                   constant:0];
    
    [self.view addConstraint:trailingVerticalConstraint];
    
    //Setup the animation
    [NSAnimationContext beginGrouping];
    NSAnimationContext.currentContext.duration = 1.0;
    NSAnimationContext.currentContext.completionHandler = ^{
      //  NSLog(@"Animation complete");
    };
    [[_stockDetailsView animator] setAlphaValue:1];
    
    [NSAnimationContext endGrouping];
}

#pragma mark - SPADataDownloadManagerDelegate
//Delegate method to is called with data has been downloaded
-(void) downloadDataCompletewithData:(NSMutableData *)theData forStockDataType:(StockDownloadDataType)theStockDataType{
    
    if(theStockDataType == StockSearchData){
        _searchResults = [SPAAppUtilies parseDownloadedDataForSearchResults:theData];
        
        if(_searchResults.count > 0){
            [self loadSearchListViewController];
        }else {
            //TODO: Display Alert - no data found

            NSLog(@"No search results");
        }
    }
    
    if(theStockDataType == AdditionalDetailsData){
        //NSString *stockDetailsData = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
        NSArray *stockDetails = [SPAAppUtilies parseDownloadedDataForAdditionalData:theData];
        
        if(stockDetails.count > 0){
            [self loadStockDetailsViewController:stockDetails];
        }else{
            //TODO:Display alert - no details found
        }
        //NSLog(@"Stock Details: %@",stockDetails);
        
    }
}

@end
