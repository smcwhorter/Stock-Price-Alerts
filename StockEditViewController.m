//
//  StockEditViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import "StockEditViewController.h"
#import "CoreDataManager.h"
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
@property (nonatomic, strong) StockDetailsView *stockDetailsView;
@property (nonatomic, strong) NSArray *stockDetails;

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

-(void)setStockDetails:(NSArray*)theStockDetails{
    if(_stockDetails == nil){
        _stockDetails = [[NSArray alloc] initWithArray:theStockDetails];
    }
    
    _stockDetails = theStockDetails;
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
    _searchListViewController.stockDownloadManager = stockDownloadManager;
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
    _stockDetailViewController.delegate = self;
    _stockDetailViewController.viewMode = newStock;//Set the view mode
    _stockDetailViewController.stockDetailInfo = theStockDetails;//Set the property with stock data
    [_stockDetailViewController initViewWithStockDetails];//Call method to layout the view with data
    [self layoutStockDetailsView];//Call method to animate the subview
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
    
    if(_viewMode == newStock){
        if(_stockDetails != nil){
            Stock *newStock = [[CoreDataManager sharedManager] getStockObjectWithEmptyData];
            
            newStock.symbol = (NSString *)[_stockDetails objectAtIndex:0];
            newStock.companyName = (NSString *)[_stockDetails objectAtIndex:1];
            newStock.highPriceAlert = [self convertStringToDecimal:_stockDetailViewController.highPriceTextView.stringValue];
            newStock.lowPriceAlert = [self convertStringToDecimal:_stockDetailViewController.lowPriceTextView.stringValue];  
            newStock.numberOfOwnedShares = [self convertStringToNumber:_stockDetailViewController.numberOfSharesTextView.stringValue];
            
            if([_stockDetails count] >= 10){
                
                newStock.currentPrice = [NSDecimalNumber decimalNumberWithString:[_stockDetails objectAtIndex:4]];
                newStock.priceRange = (NSString *)[_stockDetails objectAtIndex:7];
                //Trim extra data from precent change
                NSString *percentChange = (NSString *)[_stockDetails objectAtIndex:8];
                newStock.percentChange = [percentChange substringFromIndex:3];
                newStock.targetPrice = (NSString *)[_stockDetails objectAtIndex:9];
                
            }else{
                newStock.currentPrice = [NSDecimalNumber decimalNumberWithString:[_stockDetails objectAtIndex:3]];
                newStock.priceRange = (NSString *)[_stockDetails objectAtIndex:6];
                NSString *percentChange = (NSString *)[_stockDetails objectAtIndex:8];
                //Trim extra data from precent change
                newStock.percentChange = [percentChange substringFromIndex:3];
                newStock.targetPrice = (NSString *)[_stockDetails objectAtIndex:8];
            }
        }
    }else{
    }
    
    
    [[CoreDataManager sharedManager] stockEntityCount];
    
}

-(NSDecimalNumber*)convertStringToDecimal:(NSString*)thisStringValue{
    NSDecimalNumber *returnvalue = [NSDecimalNumber decimalNumberWithString:@"0.0"];
    if(![thisStringValue isEqualToString:@""]){
        
        returnvalue = [NSDecimalNumber decimalNumberWithString:[thisStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    
    return returnvalue;
}

-(NSInteger*) convertStringToNumber:(NSString*)thisStringValue{
    
    NSInteger *returnValue = 0;
    thisStringValue = [thisStringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];

    if(![thisStringValue isEqualToString:@""]){
        returnValue = [thisStringValue integerValue];
    }
    
    return returnValue;
}

#pragma mark - StockSearchListViewControllerDelegate
-(void) selectedStockFromListView:(NSString *)thisSelectedStock{
    NSLog(@"Delegate raised for selected Stock: %@",thisSelectedStock);
}

#pragma mark - StockDetailViewControllerDelegate
-(void) stockDetailsViewControllerSavedStock{
    
    [self saveStockToCoreDataManager];
    if(delegate != nil){
        [delegate stockEditViewControllerFinished];
    }
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
        _stockDetails = [SPAAppUtilies parseDownloadedDataForAdditionalData:theData];
        
        if(_stockDetails.count > 0){
            NSLog(@"Selected Stock: %@",_stockDetails);
            [self loadStockDetailsViewController:_stockDetails];
        }else{
            //TODO:Display alert - no details found
        }
        //NSLog(@"Stock Details: %@",stockDetails);
        
    }
}

@end
