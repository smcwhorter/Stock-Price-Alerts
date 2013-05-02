//
//  StockEditViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import "StockEditViewController.h"
#import "CoreDataManager.h"
#import "SPAStockWebServiceDataParser.h"
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

//Views and controllers
@property (nonatomic, strong) StockSearchListViewController *searchListViewController;
@property (nonatomic, strong) SPAStockDetailViewController *stockDetailViewController;
@property (nonatomic, strong) StockSearchListView *stockSearchListView;
@property (nonatomic, strong) StockDetailsView *stockDetailsView;

//Objects
@property (nonatomic, strong) NSString *searchCriteriaString;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic, strong) SPADataDownloadManager *stockDownloadManager;
@property (nonatomic, strong) NSMutableDictionary *stockListContainingStockDetails;

- (void) toggleViewFadeInOut:(id)sender;
- (void) searchForStock:(NSString*) theSeachString;
- (void) searchForStock:(NSString*) theSeachString;
- (void) setUpConstraints;
- (void) toggleSearchResultsViewVisable:(BOOL)isVisible;
@end


@implementation StockEditViewController

//**********************Properties******************************
@synthesize stockDownloadManager;
@synthesize delegate;

-(void) setsearchCriteriaString:(NSString *)searchCriteriaString{
    _searchCriteriaString = searchCriteriaString;
    _searchCriteriaString = [_searchCriteriaString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
   
}

-(void)setStockDetails:(NSMutableDictionary*)theStockListWithDetails{
    if(_stockListContainingStockDetails == nil){
        _stockListContainingStockDetails = [[NSMutableDictionary alloc] init];
    }
    
    _stockListContainingStockDetails = theStockListWithDetails;
}

//**********************Methods******************************

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
//Method to setup the view based on application state
-(void) initViewLayout{
    [_stockSearchListView removeFromSuperview];
    [_stockDetailsView removeFromSuperview];
    _stockSymbolName.stringValue = @"";
}

//TextField enter Action
-(IBAction)textFieldAction:(id)sender{
    _searchCriteriaString = [_stockSymbolName stringValue];
    
    if(![_searchCriteriaString isEqualToString:@""]){
    
        //Call the download manager to search for the stock
        [self.stockDownloadManager searchForStockWithCriteria:_searchCriteriaString];
    }else{
        
    }
}

- (IBAction)butSearchClicked:(id)sender {
    _searchCriteriaString = [_stockSymbolName stringValue];
    
    if(![_searchCriteriaString isEqualToString:@""]){
        //Call the download manager to search for the stock
        [stockDownloadManager searchForStockWithCriteria:_searchCriteriaString];
    }else{
        
    }
}

#pragma mark - StockSearchListViewController

//Display the listsview with the search results
-(void) loadSearchListViewController{
   
    if(_searchListViewController == nil){
        _searchListViewController = [[StockSearchListViewController alloc] initWithNibName:@"StockSearchListView" bundle:nil];
    }
   
    //Set the list's data and load it
    _searchListViewController.stockSearchResultsData = _searchResults;
    _searchListViewController.delegate = self;
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
    [self addAutoLayoutConstraintsForStockSearchListSubView];
    [self animateStockSearchListSubView];
}

-(void)addAutoLayoutConstraintsForStockSearchListSubView{
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
                                                                                   constant:50];
    
    [self.view addConstraint:trailingVerticalConstraint];
}

-(void) animateStockSearchListSubView{
    //Setup the animation
    [NSAnimationContext beginGrouping];
    NSAnimationContext.currentContext.duration = 1.0;
    NSAnimationContext.currentContext.completionHandler = ^{
        //NSLog(@"Animation complete");
    };
    [[_stockSearchListView animator] setAlphaValue:1];
    
    [NSAnimationContext endGrouping];
}

#pragma mark - StockDetailsViewController

//Display the selected stock details - i.e., currect price, low/high price
-(void) loadStockDetailsViewController:(NSArray*)theStockDetails{
   
    if(_stockDetailViewController == nil)
    {
        _stockDetailViewController = [[SPAStockDetailViewController alloc] initWithNibName:@"StockDetailsView" bundle:nil];
    }
    [self layoutStockDetailsView];//Call method to animate the subview
    
    _stockDetailViewController.delegate = self;
    _stockDetailViewController.viewMode = newStock;//Set the view mode
    _stockDetailViewController.stockListDetailInfo = _stockListContainingStockDetails;//Set the property with stock data
    [_stockDetailViewController initViewWithStockDetails];//Call method to layout the view with data
}


-(void) layoutStockDetailsView{
    
    //Remove the list view
    [_stockSearchListView removeFromSuperview];
    
    _stockDetailsView = _stockDetailViewController.view;
    _stockDetailsView.alphaValue = 0;
    [_stockDetailsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:_stockDetailsView];
    [self addAutoLayoutContraintsForStockDetailsSubView];
    [self animateStockDetailsSubView];
}

- (void)addAutoLayoutContraintsForStockDetailsSubView {
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
}

-(void) animateStockDetailsSubView{
    //Setup the animation
    [NSAnimationContext beginGrouping];
    NSAnimationContext.currentContext.duration = 1.0;
    NSAnimationContext.currentContext.completionHandler = ^{
        //  NSLog(@"Animation complete");
    };
    [[_stockDetailsView animator] setAlphaValue:1];
    
    [NSAnimationContext endGrouping];
}

//Saves the stock to core data
-(void) saveStockToCoreDataManager{
    
    NSArray *userEnteredValue = [self getUserEnteredValuesFromTheDetailViewController];
    
    for(id key in[_stockListContainingStockDetails allKeys])
    {
        NSArray *stockDetails = [_stockListContainingStockDetails objectForKey:key];
        if([stockDetails count] > 8)//defence - need to refactor
        {
            [[CoreDataManager sharedManager] saveStockWithDetails:stockDetails withUserEnteredValues:userEnteredValue];
        }
    }
   
    [[CoreDataManager sharedManager] stockEntityCount];
}

-(NSArray*) getUserEnteredValuesFromTheDetailViewController
{
    NSString *highPrice = _stockDetailViewController.highPriceTextView.stringValue;
    NSString *lowPrice = _stockDetailViewController.lowPriceTextView.stringValue;
    NSString *numOfShare = _stockDetailViewController.numberOfSharesTextView.stringValue;
    NSArray *userEnteredValues = [NSArray arrayWithObjects:highPrice,lowPrice,numOfShare, nil];
    return userEnteredValues;
}

#pragma mark - StockSearchListViewControllerDelegate
-(void) selectedStockFromListView:(NSString *)thisSelectedStock{
    NSLog(@"Delegate raised for selected Stock: %@",thisSelectedStock);
    [stockDownloadManager fetchStockDetailInformation:thisSelectedStock];
}

#pragma mark - StockDetailViewControllerDelegate
-(void) stockDetailsViewControllerSavedStock{
    
    [self saveStockToCoreDataManager];
    if(delegate != nil){
        stockDownloadManager = nil;
        [delegate stockEditViewControllerFinished];
    }
}


#pragma mark - SPADataDownloadManagerDelegate
//Delegate method to is called with data has been downloaded
-(void) downloadDataCompletewithData:(NSMutableData *)theData forStockDataType:(StockDownloadDataType)theStockDataType{
    
    if(theStockDataType == StockSearchData){
        _searchResults = [SPAStockWebServiceDataParser parseDownloadedDataForSearchResults:theData];
        
        if(_searchResults.count > 0){
            [self loadSearchListViewController];
        }else {
            //TODO: Display Alert - no data found

            NSLog(@"No search results");
        }
    }
    
    if(theStockDataType == AdditionalDetailsData){
        //NSString *stockDetailsData = [[NSString alloc] initWithData:theData encoding:NSASCIIStringEncoding];
        _stockListContainingStockDetails = [SPAStockWebServiceDataParser parseDownloadedDataForAdditionalData:theData];
        
        if(_stockListContainingStockDetails.count > 0){
            //NSLog(@"Selected Stock: %@",_stockDetails[0]);
            [self loadStockDetailsViewController:_stockListContainingStockDetails];
        }else{
            //TODO:Display alert - no details found
        }
        //NSLog(@"Stock Details: %@",stockDetails);
        
    }
}

@end
