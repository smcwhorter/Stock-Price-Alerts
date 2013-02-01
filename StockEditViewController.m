//
//  StockEditViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/29/13.
//
//

#import "StockEditViewController.h"

@interface StockEditViewController ()

@end

@implementation StockEditViewController
@synthesize stockSymbolName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
         //[StockSearchField setValue:@"Enter a stock"];
       
    }
    
    return self;
}

- (IBAction)SaveStock:(id)sender {
    NSString *val = [stockSymbolName stringValue];
    NSLog(@"Stock Edit Button clicked - %@",val);
}
@end
