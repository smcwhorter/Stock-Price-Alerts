//
//  AppDelegate.m
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import "AppDelegate.h"
#import "BlackCell.h"
#import "StockEditViewController.h"
#import "SettingsViewController.h"

@implementation AppDelegate

#pragma mark -
#pragma mark Init/Dealloc

-(NSImage*)buildSelectionImage
{
	// Create the selection image on the fly, instead of loading from a file resource.
	NSInteger imageWidth=12, imageHeight=22;
	NSImage* destImage = [[NSImage alloc] initWithSize:NSMakeSize(imageWidth,imageHeight)];
	[destImage lockFocus];
	
	
	
	// Constructing the path
    NSBezierPath *triangle = [NSBezierPath bezierPath];
	[triangle setLineWidth:1.0];
    [triangle moveToPoint:NSMakePoint(imageWidth+1, 0.0)];
    [triangle lineToPoint:NSMakePoint( 0, imageHeight/2.0)];
    [triangle lineToPoint:NSMakePoint( imageWidth+1, imageHeight)];
    [triangle closePath];
	[[NSColor yellowColor] setFill];
	[[NSColor darkGrayColor] setStroke];
	[triangle fill];
	[triangle stroke];
	[destImage unlockFocus];
	return destImage;
}

- (void)awakeFromNib
{
	    
    // Setup sidebar with default cell (EDSideBarCell)
	// Buttons top-aligned. Selection animated
	[sideBarDefault setLayoutMode:ECSideBarLayoutTop];
	sideBarDefault.animateSelection =YES;
	sideBarDefault.sidebarDelegate=self;
    //NSImage *selImage =[self buildSelectionImage];
	//[sideBarDefault setSelectionImage:selImage];
	//[selImage release];
	[sideBarDefault addButtonWithTitle:@"Button 1" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault addButtonWithTitle:@"Button 2" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault addButtonWithTitle:@"Button 3" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault selectButtonAtRow:0];
	// Add a bit of noise texture
    sideBarDefault.noiseAlpha=0.04;
    
    [sideBarDefault setTarget:self withSelector:@selector(logThis:) atIndex:0];
    
   
    if(stockSettingsViewController == nil)
    {
        stockSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    }
    NSRect sideBarFrame = sideBarDefault.bounds;
    NSRect footerFrame = footerView.bounds;
    NSRect mainContainerFrame = [mainContainerView frame];
    
    NSRect newRect = NSMakeRect(0, footerFrame.origin.y, mainContainerFrame.size.width, mainContainerFrame.size.height -3);

    NSInteger frameInOutStatus = 1;
    incommingView = [stockSettingsViewController view];
    [incommingView setFrame:newRect];
    //Add the incomming view as the main container's subview
    [mainContainerView addSubview:incommingView];
    incommingView = nil;
}

- (void)dealloc
{
	//[_listItems release], _listItems=nil;
    
	[super dealloc];
}

-(void)sideBar:(EDSideBar*)tabBar didSelectButton:(NSInteger)button
{
	//NSString *str = [NSString stringWithFormat:@"Selected button"];
	NSLog(@"Button selected: %lu", button );
    if(button != selectedSideBarButton){
        [self setMainView:button];
        selectedSideBarButton = button;
    }
    
}


-(void) setMainView:(NSInteger)selectedView {
    
    //Get the frame for each view on the window
    NSRect windowFrame = window.frame;
    
    NSRect footerFrame = footerView.bounds;
    NSRect mainContainerFrame = [mainContainerView frame];
    NSRect outGoingViewRect;
    NSRect initIncommingViewRect;
  
    
    initIncommingViewRect = NSMakeRect(-windowFrame.size.width, 0, mainContainerFrame.size.width, mainContainerFrame.size.height);
    NSRect inViewRect = NSMakeRect(0, 0, mainContainerFrame.size.width, mainContainerFrame.size.height);
    outGoingViewRect= NSMakeRect(windowFrame.size.width,0, mainContainerFrame.size.width, mainContainerFrame.size.height);

  
    if(selectedView == 0)
    {
        
        if(stockSettingsViewController == nil)
        {
            stockSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        }
        
        incommingView = [stockSettingsViewController view];
            
    }
    if(selectedView ==1 )
    {
        if(stockEditViewController == nil)
        {
            stockEditViewController = [[StockEditViewController alloc] initWithNibName:@"StockEditViewController" bundle:nil];
        }
        
        incommingView = [stockEditViewController view];
                
    }
    if(selectedView == 2)
    {
        if(stockListViewController == nil)
        {
            stockListViewController = [[StockListViewController alloc] initWithNibName:@"StockListViewController" bundle:nil];
        }
        
        incommingView = [stockListViewController view];
        
    }
    
    //**This works
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
            [[NSAnimationContext currentContext] setDuration:.3];
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
        
    }
        
    
    //if([mainContainerView.subviews count] > 0){
    //    NSView *viewToRemove = mainContainerView.subviews[0];
    //    [viewToRemove removeFromSuperview];
    //}
    
    //[incommingView setFrame:initIncommingViewRect];
    //[mainContainerView addSubview:incommingView];
    //NSRect rectWithTwoViews = NSMakeRect(windowFrame.origin.x, windowFrame.origin.y, 1000, 600);
    //[mainContainerView setFrame:rectWithTwoViews];
    
    //[NSAnimationContext beginGrouping];
   // [[NSAnimationContext currentContext] setDuration:1.0];
   //
   // [[incommingView animator] setFrame:inViewRect];
   // [incommingView setNeedsDisplay:YES];
    
    //[NSAnimationContext endGrouping];
    
}

@end
