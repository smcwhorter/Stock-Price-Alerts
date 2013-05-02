//
//  StockDetailViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/9/13.
//
//

#import "SPAStockDetailViewController.h"

@interface SPAStockDetailViewController ()

@end

@implementation SPAStockDetailViewController
@synthesize deleteStockClick;
@synthesize currentPriceTextview;
@synthesize lowPriceTextView;
@synthesize highPriceTextView;
@synthesize numberOfSharesTextView;
@synthesize deleteStockButton;
@synthesize saveStockButton;
@synthesize delegate;

#pragma mark - ViewController Callbacks
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    
    return self;
}

-(void) loadView{
    [super loadView];
}

#pragma mark - Stock Detail Methods
//Sets the view with data from a selected or new stock
-(void) initViewWithStockDetails{
    
    if(_viewMode == newStock){
        [self setupStockDetailsControler];
    }else{
        //TODO: Fill view with current stock data to edit
    }
    
    NSLog(@"Details text view: %@",currentPriceTextview.stringValue);
}

-(void) setupStockDetailsControler{
    [self resetTextControler];
    for(id key in[_stockListDetailInfo allKeys])
    {
        NSArray *stockInfoForKey = [_stockListDetailInfo objectForKey:key];
        [self setTextValuesBasedOnCountStockDetails:stockInfoForKey];
    }
}

-(void) resetTextControler{
    lowPriceTextView.stringValue = @"";
    highPriceTextView.stringValue = @"";
}

-(void) setTextValuesBasedOnCountStockDetails:(NSArray*)theDetails{
    if([theDetails count] == 10){
        currentPriceTextview.stringValue = [NSString stringWithFormat:@"Current Price: $%@ - Target Price: $%@",[theDetails objectAtIndex:4],[theDetails objectAtIndex:9]];
        
    }else{
        
        currentPriceTextview.stringValue = [NSString stringWithFormat:@"Current Price: $%@ - Target Price: $%@",[theDetails objectAtIndex:3],[theDetails objectAtIndex:8]];
    }
}

//Save button click event
- (IBAction)saveStockClick:(id)sender {
    if(sender != nil){
      
        if(delegate != nil){
            [delegate stockDetailsViewControllerSavedStock];
        }
    }
}
@end
