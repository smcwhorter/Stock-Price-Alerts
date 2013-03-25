//
//  AppDelegate.m
//  PXListView
//
//  Created by Alex Rozanski on 29/05/2010.
//  Copyright 2010 Alex Rozanski. http://perspx.com. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "BlackCell.h"
#import "SPAHeaderViewController.h"
#import "SPAAppUtilies.h"
#import "BasicBackGroundView.h"
//#import "CoreDataController.h"

@implementation AppDelegate

@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
//@synthesize coreDateController;
#pragma mark - Init/Dealloc

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
	[sideBarDefault addButtonWithTitle:@"Make Bigger" image:[NSImage imageNamed:@"icon1-white.png"] alternateImage:[NSImage imageNamed:@"icon1-gray.png"]];
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
    
    //Call method to setup the window with the custom views
    [self setupTheMainWindowWithViewParts];
   

}

-(void) setupTheMainWindowWithViewParts{
    
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
    [mainContentController loadMainContainerViewWithView:stockListView];
}

- (void)dealloc
{
	//[_listItems release], _listItems=nil;
    
	//[super dealloc];
}

#pragma mark - Sidebar 
-(void)sideBar:(EDSideBar*)tabBar didSelectButton:(NSInteger)button
{
	//NSString *str = [NSString stringWithFormat:@"Selected button"];
	NSLog(@"Button selected: %lu", button );
    
    //if(button == 3){
        // NSArray *viewContraints = [mainContainerView constraints];
        //NSLog(@"%@",viewContraints);
        //[[mainContainerView subviews[0]] removeConstraints:viewContraints];
        //NSLog(@"------------");
        //NSArray *views = [mainContainerView subviews];
        //NSArray *viewContraints = [views[0]constraints ];
        //NSLog(@"%@",[views[0] constraints]);
        //NSView *thisView = views[0];
        //[views[0] removeConstraints:viewContraints];
       // [mainContainerView removeConstraint:];
        
        //[mainContentController makeMainControlerBigger];
       // SPAMainContentController *newMain = [[SPAMainContentController alloc] init];
        //[newMain loadMainContentView:0];
        //NSRect mainContainer = mainContainerView.frame;
        //NSRect placeholderView = NSMakeRect(0, 0, mainContainer.size.width, mainContainer.size.height);
        //NSView *v = [[BasicBackGroundView alloc] initWithFrame:placeholderView];
        //[mainContainerView addSubview:v];
        
    //}
    if((button != selectedSideBarButton) && (button != 3)){
        //[self setMainView:button];
        [mainContentController loadMainContainerViewWithView:button];

        selectedSideBarButton = button;
    }
    
}

/*
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
}*/

#pragma mark - Core Data Section

// Returns the directory the application uses to store the Core Data store file. This code uses a directory named "com.cardinal.coreDataExample" in the user's Application Support directory.
- (NSURL *)applicationFilesDirectory
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *appSupportURL = [[fileManager URLsForDirectory:NSApplicationSupportDirectory inDomains:NSUserDomainMask] lastObject];
    
    return [appSupportURL URLByAppendingPathComponent:@"com.AlienHive.StockPriceAlerts"];
}

// Creates if necessary and returns the managed object model for the application.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
	NSBundle *d = [NSBundle mainBundle];
    NSLog(@"Managed Object Model: %@",d);
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SPADataModels" withExtension:@"mom"];
     
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

// Returns the persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. (The directory for the store is created, if necessary.)
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    NSManagedObjectModel *mom = [self managedObjectModel];
    if (!mom) {
        NSLog(@"%@:%@ No model to generate a store from", [self class], NSStringFromSelector(_cmd));
        return nil;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *applicationFilesDirectory = [self applicationFilesDirectory];
     
    NSError *error = nil;
    
    NSDictionary *properties = [applicationFilesDirectory resourceValuesForKeys:@[NSURLIsDirectoryKey] error:&error];
    
    if (!properties) {
        BOOL ok = NO;
        if ([error code] == NSFileReadNoSuchFileError) {
            ok = [fileManager createDirectoryAtPath:[applicationFilesDirectory path] withIntermediateDirectories:YES attributes:nil error:&error];
        }
        if (!ok) {
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    } else {
        if (![properties[NSURLIsDirectoryKey] boolValue]) {
            // Customize and localize this error.
            NSString *failureDescription = [NSString stringWithFormat:@"Expected a folder to store application data, found a file (%@).", [applicationFilesDirectory path]];
            
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            [dict setValue:failureDescription forKey:NSLocalizedDescriptionKey];
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:101 userInfo:dict];
            
            [[NSApplication sharedApplication] presentError:error];
            return nil;
        }
    }
    
    NSURL *url = [applicationFilesDirectory URLByAppendingPathComponent:@"SPADataModels.storedata"];
    NSLog(@"storedata file: %@",url);
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:mom];
    if (![coordinator addPersistentStoreWithType:NSXMLStoreType configuration:nil URL:url options:nil error:&error]) {
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _persistentStoreCoordinator = coordinator;
    
    return _persistentStoreCoordinator;
}

// Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setValue:@"Failed to initialize the store" forKey:NSLocalizedDescriptionKey];
        [dict setValue:@"There was an error building up the data file." forKey:NSLocalizedFailureReasonErrorKey];
        NSError *error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        [[NSApplication sharedApplication] presentError:error];
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

// Returns the NSUndoManager for the application. In this case, the manager returned is that of the managed object context for the application.
- (NSUndoManager *)windowWillReturnUndoManager:(NSWindow *)window
{
    return [[self managedObjectContext] undoManager];
}

// Performs the save action for the application, which is to send the save: message to the application's managed object context. Any encountered errors are presented to the user.
- (IBAction)saveAction:(id)sender
{
    NSError *error = nil;
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing before saving", [self class], NSStringFromSelector(_cmd));
    }
    
    if (![[self managedObjectContext] save:&error]) {
        [[NSApplication sharedApplication] presentError:error];
    }
}

- (NSApplicationTerminateReply)applicationShouldTerminate:(NSApplication *)sender
{
    // Save changes in the application's managed object context before the application terminates.
    
    if (!_managedObjectContext) {
        return NSTerminateNow;
    }
    
    if (![[self managedObjectContext] commitEditing]) {
        NSLog(@"%@:%@ unable to commit editing to terminate", [self class], NSStringFromSelector(_cmd));
        return NSTerminateCancel;
    }
    
    if (![[self managedObjectContext] hasChanges]) {
        return NSTerminateNow;
    }
    
    NSError *error = nil;
    if (![[self managedObjectContext] save:&error]) {
        
        // Customize this code block to include application-specific recovery steps.
        BOOL result = [sender presentError:error];
        if (result) {
            return NSTerminateCancel;
        }
        
        NSString *question = NSLocalizedString(@"Could not save changes while quitting. Quit anyway?", @"Quit without saves error question message");
        NSString *info = NSLocalizedString(@"Quitting now will lose any changes you have made since the last successful save", @"Quit without saves error question info");
        NSString *quitButton = NSLocalizedString(@"Quit anyway", @"Quit anyway button title");
        NSString *cancelButton = NSLocalizedString(@"Cancel", @"Cancel button title");
        NSAlert *alert = [[NSAlert alloc] init];
        [alert setMessageText:question];
        [alert setInformativeText:info];
        [alert addButtonWithTitle:quitButton];
        [alert addButtonWithTitle:cancelButton];
        
        NSInteger answer = [alert runModal];
        
        if (answer == NSAlertAlternateReturn) {
            return NSTerminateCancel;
        }
    }
    
    return NSTerminateNow;
}


@end
