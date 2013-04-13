//
//  SPAMainContentViewController.m
//  StockPriceAlerts
//
//  Created by Steve McWhorter on 2/11/13.
//
//

#import "SPAMainContentController.h"
#import "StockListViewController.h"
#import "CoreDataManager.h"

@interface SPAMainContentController ()

@end

@implementation SPAMainContentController

//Properties
@synthesize mainContainerView;
@synthesize headerViewController;
@synthesize delegate;


#pragma mark - header View Controller

-(void) loadHeaderViewController{

    if(headerViewController == nil)
    {
        headerViewController = [[SPAHeaderViewController alloc] initWithNibName:@"SPAHeaderView" bundle:nil];
        NSView *headerView = [headerViewController view];
        //[headerView setFrame:inViewRect];
        [headerView setAutoresizesSubviews:NSViewWidthSizable];
    }
}

#pragma mark - Main View Controller
-(void) makeMainControlerBigger {
    NSWindow *window= [mainContainerView window];
    NSRect  mainContainerRec = NSMakeRect(window.frame.origin.x, window.frame.origin.y, window.frame.size.width+200, window.frame.size.height);
    [window setFrame:mainContainerRec display:YES animate:YES];
}

/*
 *This method will load the main content view base on the selected view controller
 */
-(void) loadMainContainerViewWithView:(MainContainerViews)selectedView {

    [self loadSelectedView:selectedView];
    [self animateOutGoingAndIncomingViews];
}

-(void) loadSelectedView:(MainContainerViews)selectedView{
    if(selectedView == stockListView)
    {
        [self loadstockListViewController];
    }
    if(selectedView == stockDetailsView )
    {
        [self loadStockEditViewController];
    }
    if(selectedView == stockSettingsView)
    {
        [self loadStockSettingsViewController];
    }
    if(selectedView == 3){
        [self makeMainControlerBigger];
    }
}

- (void)loadstockListViewController {
    if(stockListViewController == nil)
    {
        stockListViewController = [[StockListViewController alloc] initWithNibName:@"StockListViewController" bundle:nil];
    }
    [stockListViewController bindListViewWithStockList];
    incommingView = [stockListViewController view];
    [headerViewController.headerTitle setStringValue:@"Stock List"];
}

- (void)loadStockEditViewController {
    if(stockEditViewController == nil)
    {
        stockEditViewController = [[StockEditViewController alloc] initWithNibName:@"StockEditViewController" bundle:nil];
        stockEditViewController.delegate = self;
    }
    stockEditViewController.viewMode = newStock;
    [stockEditViewController initViewLayout];
    //get the view
    incommingView = [stockEditViewController view];
    
    //Set the header view title
    [headerViewController.headerTitle setStringValue:@"Edit Stock"];
}

- (void)loadStockSettingsViewController {
    if(stockSettingsViewController == nil)
    {
        stockSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    }
    
    incommingView = [stockSettingsViewController view];
    [headerViewController.headerTitle setStringValue:@"Stock Settings"];
}

-(void) animateOutGoingAndIncomingViews {
    NSRect mainContainerFrame = [mainContainerView frame];
    NSRect outGoingViewRect;
    NSRect initIncommingViewRect;
    
    NSWindow *window= [mainContainerView window];
    initIncommingViewRect = NSMakeRect(-window.frame.size.width, 0, mainContainerFrame.size.width, mainContainerFrame.size.height);
    NSRect inViewRect = NSMakeRect(0, 0, mainContainerFrame.size.width, mainContainerFrame.size.height);
    outGoingViewRect= NSMakeRect(window.frame.size.width,0, mainContainerFrame.size.width, mainContainerFrame.size.height);
    
    
    //This works
    if([mainContainerView.subviews count] > 0){
        NSArray *aviableSubViews = [mainContainerView subviews];
        NSLog(@"1 Number of sub views in mainContainerView: %d", (int)[aviableSubViews count]);
        NSView *viewToRemove = mainContainerView.subviews[0];
        
        [NSAnimationContext beginGrouping];
        
        [[NSAnimationContext currentContext] setCompletionHandler:^{
            NSLog(@"Remove Animation Complete");
            
            [incommingView setFrame:initIncommingViewRect];
            [mainContainerView addSubview:incommingView];
            
            [self layoutConstraintsForMainContainerView];
            [NSAnimationContext beginGrouping];
            
            [[NSAnimationContext currentContext] setCompletionHandler:^{
                NSLog(@"Add Animation Complete");
                //NSArray *aviableSubViews = [mainContainerView subviews];
                //NSLog(@"2 Number of sub views in mainContainerView: %d", (int)[aviableSubViews count]);
                //Remove the view that is not visable
                [viewToRemove removeFromSuperview];
                
                
            }];
            [[NSAnimationContext currentContext] setDuration:.2];
            //Set this view's frame into the main window's view
            [[incommingView animator] setFrame:inViewRect];
            [incommingView setNeedsDisplay:YES];
            
            [NSAnimationContext endGrouping];
            
        }];
        
        [[NSAnimationContext currentContext] setDuration:0.1];
        //Set this view's frame out of the main window's view
        [[viewToRemove animator] setFrame:outGoingViewRect];
        [viewToRemove setNeedsDisplay:YES];
        
        [NSAnimationContext endGrouping];;
        
        //[headerViewController.headerTitle setStringValue:[NSString stringWithFormat:@"View %d",selectedView]];
    }
    else{
        [incommingView setFrame:inViewRect];
        [incommingView setAutoresizingMask:(NSViewWidthSizable|NSViewHeightSizable)];
        [mainContainerView addSubview:incommingView];
        
        [self layoutConstraintsForMainContainerView];
    }
}

-(void) layoutConstraintsForMainContainerView{
    //Define the layout constraints - Set Min Width
    [mainContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[incommingView(>=400)]"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(incommingView)]];
    //Define the layout constraints - Set Max Width
    [mainContainerView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"[incommingView(<=1000)]"
                                                                              options:0
                                                                              metrics:nil
                                                                                views:NSDictionaryOfVariableBindings(incommingView)]];
}

#pragma mark - SPAStockDetailViewControllerDelegate
-(void) stockEditViewControllerFinished{
    [self loadMainContainerViewWithView:stockListView];
    
    if(delegate != nil){
        [delegate mainContianerViewChanged:stockListView];
    }
}
@end
