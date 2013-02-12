//
//  AppDelegate.m
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import "AppDelegate.h"
#import "BlackCell.h"
#import "SPAHeaderViewController.h"
#import "SPAAppUtilies.h"

@implementation AppDelegate


#pragma mark -
#pragma mark Init/Dealloc



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
	[sideBarDefault addButtonWithTitle:@"Stock List" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault addButtonWithTitle:@"Add Stock" image:[NSImage imageNamed:@"ic_addstock.png"] alternateImage:[NSImage imageNamed:@"ic_addstock.png"]];
	[sideBarDefault addButtonWithTitle:@"Settings" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
	[sideBarDefault selectButtonAtRow:0];
	// Add a bit of noise texture
    sideBarDefault.noiseAlpha=0.04;
    [sideBarDefault setTarget:self withSelector:@selector(logThis:) atIndex:0];
}

#pragma mark - App Delegate methods
/*
* Sent by the default notification center after the application has been
* launched and initialized but before it has received its first event
*/
-(void)applicationDidFinishLaunching:(NSNotification *)notification{
    NSLog(@"applicationDidFinishLaunching");
    
   
    if(headerViewController == nil)
    {
        headerViewController = [[SPAHeaderViewController alloc] initWithNibName:@"SPAHeaderView" bundle:nil];
    }
    
    
    NSView *d = [headerViewController view];
    float w = window.frame.size.width;
    NSRect frame = NSMakeRect(0.0, 0.0, w-65, 40.0);
    [d setFrame:frame];
    [d setAutoresizingMask:(NSViewWidthSizable)];
    
    [headerView addSubview:d];
    //[headerViewController.headerTitle setStringValue:[NSString stringWithFormat:@"Temp Title"]];
    
    if(mainContentController == nil)
    {
        mainContentController = [[SPAMainContentController alloc] init];
    }
    mainContentController.mainContainerView = mainContainerView;
    mainContentController.headerViewController = headerViewController;
    [mainContentController loadHeaderViewController];
    //Set the main content view to be the first view
    [mainContentController loadMainContentView:0];

}

- (void)dealloc
{
	//[_listItems release], _listItems=nil;
    
	[super dealloc];
}

#pragma mark - Sidebar 
-(void)sideBar:(EDSideBar*)tabBar didSelectButton:(NSInteger)button
{
	//NSString *str = [NSString stringWithFormat:@"Selected button"];
	NSLog(@"Button selected: %lu", button );
    if(button != selectedSideBarButton){
        //[self setMainView:button];
        [mainContentController loadMainContentView:button];

        selectedSideBarButton = button;
    }
    
}

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


#pragma mark - HeaderViewController
-(void)setHeaderTitle:(NSString*)titleText{
     [headerViewController.headerTitle setStringValue:titleText];
}

@end
