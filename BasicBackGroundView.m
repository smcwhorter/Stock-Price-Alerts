//
//  BasicBackGroundView.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/3/13.
//
//

#import "BasicBackGroundView.h"
#import "SPAAppUtilies.h"

@implementation BasicBackGroundView

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

- (void)drawBackground {
    
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float w = self.bounds.size.width;
    float h =self.bounds.size.height;
    NSLog(@"main drawBackground - Width: %f Heigth: %f",w,h);
    
    //Very inner rect
    //NSColor *shadowStartColor = [NSColor colorWithDeviceWhite:(42.0/255.0) alpha:1.0];
    //NSColor *shadowEndColor = [NSColor colorWithDeviceWhite:(56.0/255.0) alpha:1.0];
    
    //Create the gradient
    NSGradient *gradientColor = [[NSGradient alloc] initWithStartingColor:[SPAAppUtilies stockEditGradientStart] endingColor:[SPAAppUtilies stockEditGradientEnd]];
    //Define the rectangle
    NSRect rectGradient = NSMakeRect(x+21, y+21, w-52, h-42);
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:rectGradient];
    [gradientColor drawInBezierPath:path angle:90];
    
    //Inner rect
    NSColor *rgb1 = [SPAAppUtilies borderWhite];
    [rgb1 set];
    NSFrameRect(NSMakeRect(x+20, y+20, w-50, h-40));
    
    //Outer rect
    NSColor *rgb = [SPAAppUtilies borderMedium];
    [rgb set];
    NSFrameRect(NSMakeRect(x+19, y+19, w-48, h-38));
}

@end
