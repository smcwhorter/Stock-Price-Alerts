//
//  StockListViewController.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 1/30/13.
//
//

#import "StockListViewController.h"
#import "MyListViewCell.h"

#pragma mark Constants

#define LISTVIEW_CELL_IDENTIFIER		@"MyListViewCell"
#define NUM_EXAMPLE_ITEMS				50

@interface StockListViewController ()

@end

@implementation StockListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code here.
    }
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

    return self;
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

@end
