//
//  BasicBackGroundView.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/3/13.
//
//

#import "SquareBorderView.h"
#import "SPAColors.h"

@implementation SquareBorderView

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
    //NSLog(@"main drawBackground - Width: %f Heigth: %f",w,h);
    
       
    //Create the gradient
    NSGradient *gradientColor = [[NSGradient alloc] initWithStartingColor:[SPAColors stockEditDarkGrayStart] endingColor:[SPAColors stockEditDarkGrayEnd]];
    //Define the rectangle
    NSRect innerRecFrame = NSMakeRect(x+21, y+21, w-52, h-42);
    
    NSBezierPath *clipPath = [NSBezierPath bezierPathWithRect:innerRecFrame];
    //[clipPath addClip];
    //NSBezierPath *path = [NSBezierPath bezierPathWithRect:rectGradient];
    [gradientColor drawInBezierPath:clipPath angle:90];
   
    
    
    //Inner rect
    NSColor *rgb1 = [SPAColors borderWhite];
    [rgb1 set];
    //NSFrameRect(NSMakeRect(x+20, y+20, w-50, h-40));
    NSRect middleRecFrame = NSMakeRect(x+20, y+20, w-50, h-40);
    
    NSBezierPath *middleRoundedRecPath = [NSBezierPath bezierPathWithRect:middleRecFrame];
    //[innerRoundedRecPath addClip];
    //Draws a line along the receiver’s path using the current stroke color and drawing attributes.
    [middleRoundedRecPath stroke];
    
    //Outer rect
    NSColor *rgb = [SPAColors borderMedium];
    [rgb set];
    //NSFrameRect(NSMakeRect(x+19, y+19, w-48, h-38));*/
    NSRect outerRectFrame = NSMakeRect(x+19, y+19, w-48, h-38);
    
    NSBezierPath *outerRoundedRecPath = [NSBezierPath bezierPathWithRect:outerRectFrame];
    //[outerRoundedRecPath addClip];
    [outerRoundedRecPath stroke];
    [outerRoundedRecPath addClip];
    
    //[self addclip];
}

@end
