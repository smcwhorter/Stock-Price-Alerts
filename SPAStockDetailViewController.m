//
//  StockDetailViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/9/13.
//
//

#import "Stock.h"
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
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void) loadView{
    [super loadView];
    NSLog(@"Details: %@",_stockDetailInfo);
}

#pragma mark - Stock Detail Methods
//Sets the view with data from a selected or new stock
-(void) initViewWithStockDetails{
    
    if(_viewMode == newStock){
        lowPriceTextView.stringValue = @"";
        highPriceTextView.stringValue = @"";
        
        if([_stockDetailInfo count] == 10){
            currentPriceTextview.stringValue = [NSString stringWithFormat:@"Current Price: $%@ - Target Price: $%@",[_stockDetailInfo objectAtIndex:4],[_stockDetailInfo objectAtIndex:9]];
        
        }else{
       
            currentPriceTextview.stringValue = [NSString stringWithFormat:@"Current Price: $%@ - Target Price: $%@",[_stockDetailInfo objectAtIndex:3],[_stockDetailInfo objectAtIndex:8]];
        }
    }else{
        //TODO: Fill view with current stock data to edit
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
