//
//  MyView.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/1/13.
//
//

#import "SPAHeaderView.h"
#import "SPAAppUtilies.h"

@implementation SPAHeaderView

/*
 *Properties
 */
@synthesize frameWidth;
@synthesize frameHeigth;

/*
 *Methods
 */

//Initializes and returns a newly allocated NSView object with a specified frame rectangle.
//The new view object must be inserted into the view hierarchy of a window before it can be used. This method is the designated initializer for the NSView class. Returns an initialized object.
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        float w = self.bounds.size.width;
        float h =self.bounds.size.height;
        
        frameWidth = w;
        frameHeigth = h;
        
        NSLog(@"Header initWithFrame - Width: %f Heigth: %f",w,h);
        //[self setPreferred
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [super drawRect:dirtyRect];
    [self drawBackground];
}

- (void)drawBackground {
    
    // Initialization code here.
    float w = self.bounds.size.width;
    float h =self.bounds.size.height;
    
    //Define the rectangle
    NSRect rec = NSMakeRect(0.0f, 0.0f, w, h);
    //NSColor *rgb1 = [NSColor colorWithDeviceRed: red1 green: green1 blue: blue1 alpha: alpha1];
    //[rgb1 set]; //set the color
    // NSRectFill(rec); //Fill the rectangle
  
    //Create a gradient with two colors
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[SPAAppUtilies darkGray] endingColor:[SPAAppUtilies lightGray]];
    //Create a rectangle
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:rec];
    //Fills the specified path with a linear gradient
    [gradient drawInBezierPath:path angle:270];
    
    
    NSColor *shadowStartColor = [NSColor colorWithDeviceWhite:(42.0/255.0) alpha:0.8];
    NSColor *shadowEndColor = [NSColor colorWithDeviceWhite:(56.0/255.0) alpha:1.0];
    
    //Create the gradient
    NSGradient *gradient1 = [[NSGradient alloc] initWithStartingColor:shadowStartColor endingColor:shadowEndColor];
    //Define the rectangle
    NSRect rectGradient = NSMakeRect(0, NSMinY(self.bounds), NSWidth(self.bounds), 1.0);
    NSBezierPath *path1 = [NSBezierPath bezierPathWithRect:rectGradient];
    [gradient1 drawInBezierPath:path1 angle:0];
    
     NSLog(@"header drawBackground - Width: %f Heigth: %f",w,h);
    
#if !__has_feature(objc_arc)
    [gradient release];
    [gradient1 release];
#endif

}

@end
