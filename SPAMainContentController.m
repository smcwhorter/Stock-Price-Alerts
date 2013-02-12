//
//  SPAMainContentViewController.m
//  StockPriceAlerts
//
//  Created by Steve McWhorter on 2/11/13.
//
//

#import "SPAMainContentController.h"

@interface SPAMainContentController ()

@end

@implementation SPAMainContentController
@synthesize mainContainerView;
@synthesize headerViewController;

-(void) loadHeaderViewController{

    if(headerViewController == nil)
    {
        headerViewController = [[SPAHeaderViewController alloc] initWithNibName:@"SPAHeaderView" bundle:nil];
        NSView *headerView = [headerViewController view];
        //[headerView setFrame:inViewRect];
        [headerView setAutoresizesSubviews:NSViewWidthSizable];
    }
}

/*
 *This method will load the main content view base on the selected view controller
 */
-(void) loadMainContentView:(NSInteger)selectedView {

    NSRect mainContainerFrame = [mainContainerView frame];
    NSRect outGoingViewRect;
    NSRect initIncommingViewRect;

    NSWindow *window= [mainContainerView window];
    initIncommingViewRect = NSMakeRect(-window.frame.size.width, 0, mainContainerFrame.size.width, mainContainerFrame.size.height);
    NSRect inViewRect = NSMakeRect(0, 0, mainContainerFrame.size.width, mainContainerFrame.size.height);
    outGoingViewRect= NSMakeRect(window.frame.size.width,0, mainContainerFrame.size.width, mainContainerFrame.size.height);
  
    
    
    if(selectedView == 0)
    {
        
        if(stockListViewController == nil)
        {
            stockListViewController = [[StockListViewController alloc] initWithNibName:@"StockListViewController" bundle:nil];
        }
        
        incommingView = [stockListViewController view];
        [headerViewController.headerTitle setStringValue:@"Stock List"];
        
    }
    if(selectedView ==1 )
    {
        if(stockEditViewController == nil)
        {
            stockEditViewController = [[StockEditViewController alloc] initWithNibName:@"StockEditViewController" bundle:nil];
        }
        
        incommingView = [stockEditViewController view];
        [headerViewController.headerTitle setStringValue:@"Edit Stock"];
        
    }
    if(selectedView == 2)
    {
        if(stockSettingsViewController == nil)
        {
            stockSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        }
        
        incommingView = [stockSettingsViewController view];
        [headerViewController.headerTitle setStringValue:@"Stock Settings"];
    }
    
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
    }
}


@end
