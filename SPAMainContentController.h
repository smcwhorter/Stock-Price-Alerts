//
//  SPAMainContentViewController.h
//  StockPriceAlerts
//
//  Created by Steve McWhorter on 2/11/13.
//
//

#import <Cocoa/Cocoa.h>
#import "SPAHeaderViewController.h"
#import "StockEditViewController.h"
#import "StockListViewController.h"
#import "SettingsViewController.h"
#import "CoreDataController.h"

@interface SPAMainContentController : NSObject
{
   
    NSView *mainContainerView;
    NSView *incommingView;
    SPAHeaderViewController *headerViewController;
    StockEditViewController *stockEditViewController;
    StockListViewController *stockListViewController;
    SettingsViewController *stockSettingsViewController;
    CoreDataController *coreDataController;
    
}
@property (strong) NSView *mainContainerView;
@property (strong) SPAHeaderViewController *headerViewController;
@property (strong) CoreDataController *coreDataController;

-(void) loadHeaderViewController;
-(void) loadMainContentView:(NSInteger)selectedView;
-(void)setupTheCoreDataController;
@end
