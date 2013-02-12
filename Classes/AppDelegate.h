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
#import "SPAMainContentController.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSView *headerView;
    IBOutlet NSView *mainContainerView;
    IBOutlet NSWindow *window;
	IBOutlet EDSideBar *sideBarDefault;
    IBOutlet NSView *footerView;
    //NSView *incommingView;
    
    SPAHeaderViewController *headerViewController;
    SPAMainContentController *mainContentController;
    
    NSInteger selectedSideBarButton;
}

-(void)setHeaderTitle:(NSString*)titleText;

@end
