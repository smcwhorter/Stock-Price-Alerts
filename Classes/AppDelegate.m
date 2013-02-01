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
    NSImage *selImage =[self buildSelectionImage];
	[sideBarDefault setSelectionImage:selImage];
	[selImage release];
	[sideBarDefault addButtonWithTitle:@"Button 1" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault addButtonWithTitle:@"Button 2" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault addButtonWithTitle:@"Button 3" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault selectButtonAtRow:0];
	// Add a bit of noise texture
    sideBarDefault.noiseAlpha=0.04;
    
    [sideBarDefault setTarget:self withSelector:@selector(logThis:) atIndex:0];
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
    
    if(stockEditViewController != nil){
        [[stockEditViewController view] removeFromSuperview];
    }
    if(stockSettingsViewController != nil){
        [[stockSettingsViewController view] removeFromSuperview];
    }
    if(stockListViewController != nil){
        [[stockListViewController view] removeFromSuperview];
    }
    
    if(button == 0)
    {
        
        if(stockSettingsViewController == nil)
        {
            stockSettingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        }
        
        NSView *view = [stockSettingsViewController view];
        [mainContainerView addSubview:view];
    }
    if(button ==1 )
    {
        if(stockEditViewController == nil)
        {
            stockEditViewController = [[StockEditViewController alloc] initWithNibName:@"StockEditViewController" bundle:nil];
        }
        
        NSView *view = [stockEditViewController view];
        [mainContainerView addSubview:view];
    }
    if(button == 2)
    {
        if(stockListViewController == nil)
        {
            stockListViewController = [[StockListViewController alloc] initWithNibName:@"StockListViewController" bundle:nil];
        }
        
        NSView *view = [stockListViewController view];
        [mainContainerView addSubview:view];
    }
}

@end
