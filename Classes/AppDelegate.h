//
//  PXListViewAppDelegate.h
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "EDSideBar.h"
#import "StockEditViewController.h"
#import "StockListViewController.h"
#import "SettingsViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSView *mainContainerView;
    IBOutlet NSWindow *window;
	IBOutlet EDSideBar *sideBarDefault;
    StockEditViewController *stockEditViewController;
    StockListViewController *stockListViewController;
    SettingsViewController *stockSettingsViewController;
}


@end
