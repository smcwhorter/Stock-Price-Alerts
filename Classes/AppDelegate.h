//
//  PXListViewAppDelegate.h
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "PXListView.h"
#import "EDSideBar.h"
#import "StockEditViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, PXListViewDelegate, PXListViewDelegate>
{
    IBOutlet NSView *mainContainerView;
    IBOutlet NSWindow *window;
	IBOutlet PXListView	*listView;
	IBOutlet EDSideBar *sideBarDefault;
	NSMutableArray *_listItems;
    StockEditViewController *stockEditViewController;
}

- (IBAction)reloadTable:(id)sender;

@end
