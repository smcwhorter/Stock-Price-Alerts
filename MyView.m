//
//  MyView.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/1/13.
//
//

#import "MyView.h"

@implementation MyView

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
        
        //[self setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        //[contentView addSubview:customView];
        
        //[[self class] addEdgeConstraint:NSLayoutAttributeLeft superview:contentView subview:customView];
        //[[self class] addEdgeConstraint:NSLayoutAttributeRight superview:contentView subview:customView];
        //[[self class] addEdgeConstraint:NSLayoutAttributeTop superview:contentView subview:customView];
        //[[self class] addEdgeConstraint:NSLayoutAttributeBottom superview:contentView subview:customView];
        
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
    
    
    //[[NSColor controlBackgroundColor] set];
    //NSLog(@"drawBackground");
    float red = 0.8f;
    float green = 0.3f;
    float blue = 0.4f;
    float alpha = 0.8f;
    // Initialization code here.
    float w = self.bounds.size.width;
    float h =self.bounds.size.height;
    
    //NSLog(@"header drawBackground - Width: %f Heigth: %f",w,h);
    NSColor *rgb = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
     [rgb set];
    NSRectFill(NSMakeRect(0.0f, 0.0f, self.bounds.size.width, self.bounds.size.width));
    //[[NSColor controlBackgroundColor] set];
    //NSRectFill(NSMakeRect(0.0f, self.bounds.size.height - 1.0f, self.bounds.size.width, 1.0f));
}

@end
