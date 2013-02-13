//
//  PXListViewAppDelegate.h
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <CoreData/CoreData.h>

#import "EDSideBar.h"
#import "SPAHeaderViewController.h"
#import "SPAMainContentController.h"
//#import "CoreDataController.h"

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
    
    //CoreDataController *coreDataController;
    
    NSInteger selectedSideBarButton;
}

//Property definitions
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//@property (retain) CoreDataController *coreDateController;

//Method definitions
- (IBAction)saveAction:(id)sender;
-(void)setupTheMainWindowWithViewParts;
//-(void)setupTheCoreDataController;

@end
