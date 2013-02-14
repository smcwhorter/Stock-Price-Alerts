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

@interface StockEditViewController ()

@end

@implementation StockEditViewController

//Properties
@synthesize coreDataController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
         //[StockSearchField setValue:@"Enter a stock"];
       
    }
   
    return self;
}

-(void)customizeView{
    NSView *currentView = [self view];
    
    NSRect rec = NSMakeRect(currentView.frame.origin.x + 5, currentView.frame.origin.y+5, currentView.frame.size.width, currentView.frame.size.height);
    NSColor *mycolor = [SPAAppUtilies darkGray];
    [mycolor setFill];
    NSRectFill(rec);
    
}

- (IBAction)SaveStock:(id)sender {
    NSString *val = [_stockSymbolName stringValue];
    NSLog(@"Stock Edit Button clicked - %@",val);
    
    //Call method to add a new stock
    if(coreDataController != nil)
    {
        [coreDataController addStockEnitiy];
        NSInteger *stockCount = [coreDataController stockEntityCount];
        NSLog(@"Number of items in the array:%d",stockCount);
    }
    
}
@end
