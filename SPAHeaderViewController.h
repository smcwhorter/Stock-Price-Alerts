//
//  SPAHeaderViewController.h
//  EDSidebar
//
//  Created by Steven McWhorter on 2/2/13.
//
//

#import <Cocoa/Cocoa.h>

@interface SPAHeaderViewController : NSViewController {
    NSTextField *headerTitle;
}

@property (assign) __unsafe_unretained IBOutlet NSTextField *headerTitle;

@end
