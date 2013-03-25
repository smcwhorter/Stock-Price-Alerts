//
//  StockDetailViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/9/13.
//
//

#import "Stock.h"
#import "CoreDataManager.h"
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
    [self setupStockDetails];
}

-(void) setupStockDetails{
    
    if(_viewMode)
    
    if([_stockDetailInfo count] == 10){
        currentPriceTextview.stringValue = [NSString stringWithFormat:@"Current Price: $%@ - Target Price: $%@",[_stockDetailInfo objectAtIndex:4],[_stockDetailInfo objectAtIndex:9]];
        
    }else{
       
        currentPriceTextview.stringValue = [NSString stringWithFormat:@"Current Price: $%@ - Target Price: $%@",[_stockDetailInfo objectAtIndex:3],[_stockDetailInfo objectAtIndex:8]];
    }
}
- (IBAction)saveStockClick:(id)sender {
    [self saveStockToCoreDataManager];
}

-(void) saveStockToCoreDataManager{
    
    if(_stockEnity == nil){
        Stock *newStock = [[CoreDataManager sharedManager] getStockObjectWithEmptyData];
        
        newStock.symbol = (NSString *)[_stockDetailInfo objectAtIndex:0];
        newStock.companyName = (NSString *)[_stockDetailInfo objectAtIndex:1];
        
        if([highPriceTextView.stringValue isEqualToString:@""]){
            newStock.highPriceAlert = [NSDecimalNumber decimalNumberWithString:@"0.0"];
        }else{
            newStock.highPriceAlert = [NSDecimalNumber decimalNumberWithString:[highPriceTextView.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
        
        if([lowPriceTextView.stringValue isEqualToString:@""]){
            newStock.lowPriceAlert = [NSDecimalNumber decimalNumberWithString:@"0.0"];
        }else{
            newStock.lowPriceAlert = [NSDecimalNumber decimalNumberWithString:[lowPriceTextView.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
        
        if([numberOfSharesTextView.stringValue isEqualToString:@" "]){
            newStock.numberOfOwnedShares = 0;
        }else{
            NSString *numberOfShares = [numberOfSharesTextView.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            newStock.numberOfOwnedShares = [numberOfShares integerValue];
        }
        
        
        if([_stockDetailInfo count] >= 10){
            
            newStock.currentPrice = [NSDecimalNumber decimalNumberWithString:[_stockDetailInfo objectAtIndex:4]];
            newStock.priceRange = (NSString *)[_stockDetailInfo objectAtIndex:7];
            //Trim extra data from precent change
            NSString *percentChange = (NSString *)[_stockDetailInfo objectAtIndex:8];
            newStock.percentChange = [percentChange substringFromIndex:3];
            newStock.targetPrice = (NSString *)[_stockDetailInfo objectAtIndex:9];
            
        }else{
            newStock.currentPrice = [NSDecimalNumber decimalNumberWithString:[_stockDetailInfo objectAtIndex:3]];
            newStock.priceRange = (NSString *)[_stockDetailInfo objectAtIndex:6];
            NSString *percentChange = (NSString *)[_stockDetailInfo objectAtIndex:8];
            //Trim extra data from precent change
            newStock.percentChange = [percentChange substringFromIndex:3];
            newStock.targetPrice = (NSString *)[_stockDetailInfo objectAtIndex:8];
        }
    }
    
    
    [[CoreDataManager sharedManager] stockEntityCount];

}

@end
