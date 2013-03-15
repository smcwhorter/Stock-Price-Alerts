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
    
       

    //NSLog(@"Place Holder: Frame %@ - bounds %@",NSStringFromRect(self.placeholderView.frame),NSStringFromRect(self.placeholderView.bounds));
    //NSLog(@"Details View Frame %@ - bounds %@",NSStringFromRect(stockDetailVC.view.frame),NSStringFromRect(stockDetailVC.view.bounds));
        
    //The search results are hidden by default
    
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
   
    StockSearchListViewController *searchListViewController = [[StockSearchListViewController alloc] initWithNibName:@"StockSearchListView" bundle:nil];
   
    StockSearchListView *_stockSearchListView = searchListViewController.view;
    [_stockSearchListView setTranslatesAutoresizingMaskIntoConstraints:NO];

    [self.view addSubview:_stockSearchListView];
   
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[_stockSearchListView(>=200)]-(50)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockSearchListView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(150)-[_stockSearchListView(>=200)]-(200)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockSearchListView)]];

    
}

//Display the selected stock details - i.e., currect price, low/high price
-(void) displayStockDetails:(NSArray*)theDetails{
   
    
    
    SPAStockDetailViewController *stockDetailVC = [[SPAStockDetailViewController alloc] initWithNibName:@"StockDetailsView" bundle:nil];
    StockDetailsView *_stockDetailsView = stockDetailVC.view;
    [_stockDetailsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:_stockDetailsView];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(50)-[_stockDetailsView(>=200)]-(50)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockDetailsView)]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(150)-[_stockDetailsView(>=200)]-(200)-|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:NSDictionaryOfVariableBindings(_stockDetailsView)]];
    
    NSArray *constraints = [self.view constraints];
    //NSLog(@"%@",constraints);
    /*
 
    if(theDetails.count >= 10){
        
         [self.currentPriceLabel setStringValue:[NSString stringWithFormat:@"%@ - Price: $%@",[theDetails objectAtIndex:1],[theDetails objectAtIndex:4]]];
    }
    else{
       [self.currentPriceLabel setStringValue:[NSString stringWithFormat:@"%@ - Price: $%@",[theDetails objectAtIndex:1],[theDetails objectAtIndex:3]]];
    }*/
}

//This will animate the tableview visable by changing its alpha and auto layout contraint
- (void) toggleSearchResultsViewVisable:(BOOL)isVisible{
    /*
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
    [NSAnimationContext endGrouping];*/
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

@end
