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
#import "SPAConstants.h"

@protocol SPAMainContentViewControllerDelegate
-(void)mainContianerViewChanged:(MainContainerViews)toSelectedView;

@end

@interface SPAMainContentController : NSObject <SPAStockDetailsViewDelegate>
{
   
    NSView *mainContainerView;
    NSView *incommingView;
    SPAHeaderViewController *headerViewController;
    StockEditViewController *stockEditViewController;
    StockListViewController *stockListViewController;
    SettingsViewController *stockSettingsViewController;
    
}
@property (assign, nonatomic) id <SPAMainContentViewControllerDelegate> delegate;

@property (strong) NSView *mainContainerView;
@property (strong) SPAHeaderViewController *headerViewController;


-(void) loadHeaderViewController;
-(void) loadMainContainerViewWithView:(MainContainerViews)selectedView;
-(void) setupTheCoreDataController;
-(void) makeMainControlerBigger;
@end
