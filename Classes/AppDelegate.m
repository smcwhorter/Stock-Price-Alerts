//
//  AppDelegate.m
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import "AppDelegate.h"
#import "BlackCell.h"
#import "MyListViewCell.h"
#import "StockEditViewController.h"


#pragma mark Constants

#define LISTVIEW_CELL_IDENTIFIER		@"MyListViewCell"
#define NUM_EXAMPLE_ITEMS				50


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
	[listView setCellSpacing:2.0f];
	[listView setAllowsEmptySelection:YES];
	[listView setAllowsMultipleSelection:YES];
	[listView registerForDraggedTypes:[NSArray arrayWithObjects: NSStringPboardType, nil]];
	
	_listItems = [[NSMutableArray alloc] init];

	//Create a bunch of rows as a test
	for( NSInteger i = 0; i < NUM_EXAMPLE_ITEMS; i++ )
	{
		NSString *title = [[NSString alloc] initWithFormat: @"Item %d", i +1];
		[_listItems addObject:title];
		[title release];
	}
	
	[listView reloadData];
    
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
	[sideBarDefault selectButtonAtRow:2];
	// Add a bit of noise texture
    sideBarDefault.noiseAlpha=0.04;
    
    [sideBarDefault setTarget:self withSelector:@selector(logThis:) atIndex:0];
}

- (void)dealloc
{
	[_listItems release], _listItems=nil;
    
	[super dealloc];
}


#pragma mark List View Delegate Methods

- (NSUInteger)numberOfRowsInListView: (PXListView*)aListView
{
#pragma unused(aListView)
	return [_listItems count];
}

- (PXListViewCell*)listView:(PXListView*)aListView cellForRow:(NSUInteger)row
{
	MyListViewCell *cell = (MyListViewCell*)[aListView dequeueCellWithReusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
	
	if(!cell) {
		cell = [MyListViewCell cellLoadedFromNibNamed:@"MyListViewCell" reusableIdentifier:LISTVIEW_CELL_IDENTIFIER];
	}
	
	// Set up the new cell:
	[[cell titleLabel] setStringValue:[_listItems objectAtIndex:row]];
	
	return cell;
}

- (CGFloat)listView:(PXListView*)aListView heightOfRow:(NSUInteger)row
{
	return 50;
}

- (void)listViewSelectionDidChange:(NSNotification*)aNotification
{
    NSLog(@"Selection changed");
}


// The following are only needed for drag'n drop:
- (BOOL)listView:(PXListView*)aListView writeRowsWithIndexes:(NSIndexSet*)rowIndexes toPasteboard:(NSPasteboard*)dragPasteboard
{
	// +++ Actually drag the items, not just dummy data.
	[dragPasteboard declareTypes: [NSArray arrayWithObjects: NSStringPboardType, nil] owner: self];
	[dragPasteboard setString: @"Just Testing" forType: NSStringPboardType];
	
	return YES;
}

- (NSDragOperation)listView:(PXListView*)aListView validateDrop:(id <NSDraggingInfo>)info proposedRow:(NSUInteger)row
							proposedDropHighlight:(PXListViewDropHighlight)dropHighlight;
{
	return NSDragOperationCopy;
}


- (IBAction) reloadTable:(id)sender
{
	[listView reloadData];
}


-(void)sideBar:(EDSideBar*)tabBar didSelectButton:(NSInteger)button
{
	//NSString *str = [NSString stringWithFormat:@"Selected button"];
	NSLog(@"Button selected: %lu", button );
    if(button ==1 )
    {
        if(stockEditViewController == nil)
        {
            stockEditViewController = [[StockEditViewController alloc] initWithNibName:@"StockEditViewController" bundle:nil];
            NSView *view = [stockEditViewController view];
            
            
            [listView addSubview:view];
        }
       
        

    }
}

@end
