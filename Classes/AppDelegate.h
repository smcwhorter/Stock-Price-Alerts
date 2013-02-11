//
//  PXListViewAppDelegate.h
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "EDSideBar.h"
#import "SPAHeaderViewController.h"
#import "StockEditViewController.h"
#import "StockListViewController.h"
#import "SettingsViewController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSView *headerView;
    IBOutlet NSView *mainContainerView;
    IBOutlet NSWindow *window;
	IBOutlet EDSideBar *sideBarDefault;
    IBOutlet NSView *footerView;
    NSView *incommingView;
    
    SPAHeaderViewController *headerViewController;
    StockEditViewController *stockEditViewController;
    StockListViewController *stockListViewController;
    SettingsViewController *stockSettingsViewController;
    NSInteger selectedSideBarButton;
}

-(void) setMainView:(NSInteger)selectedView;

@end
