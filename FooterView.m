//
//  FooterView.m
//  EDSidebar
//
//  Created by Steven McWhorter on 2/2/13.
//
//

#import "FooterView.h"
#import "SPAAppUtilies.h"

@implementation FooterView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
        float w = self.bounds.size.width;
        float h =self.bounds.size.height;
        
        frameWidth = w;
        frameHeigth = h;
        
        
       // NSLog(@"Footer initWithFrame - Width: %f Heigth: %f",w,h);
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

/*
 * This method will draw the background with a blue gradient and add a dark
 * shadow at the top of the first rectangle
 */
- (void)drawBackground {
    
    
      // Initialization code here.
    float w = self.bounds.size.width;
    float h =self.bounds.size.height;
    
    //Define the rectangle
    NSRect rec = NSMakeRect(0.0f, 0.0f, w, h);
    
    //[rgb set]; //set the color
    // NSRectFill(rec); //Fill the rectangle
        
    //Create a gradient with two colors
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:[SPAAppUtilies darkGray] endingColor:[SPAAppUtilies lightGray]];
    //Create a rectangle
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:rec];
    //Fills the specified path with a linear gradient
    [gradient drawInBezierPath:path angle:90];
    
    //***upper shadow***/
    NSColor *shadowStartColor = [NSColor colorWithDeviceWhite:(42.0/255.0) alpha:0.8];
    NSColor *shadowEndColor = [NSColor colorWithDeviceWhite:(56.0/255.0) alpha:1.0];
    
    //Create the gradient 
    NSGradient *gradient1 = [[NSGradient alloc] initWithStartingColor:[SPAAppUtilies borderWhite] endingColor:shadowEndColor];
    //Define the rectangle
    NSRect rectGradient = NSMakeRect(0, NSMaxY(self.bounds)-2, NSWidth(self.bounds), 2.0);
    NSBezierPath *path1 = [NSBezierPath bezierPathWithRect:rectGradient];
    [gradient1 drawInBezierPath:path1 angle:90];
    
    NSLog(@"footer drawBackground - Width: %f Heigth: %f",w,h);
   
#if !__has_feature(objc_arc)
    [gradient release];
    [gradient1 release];
#endif		

}

@end
