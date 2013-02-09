//
//  FooterView.m
//  EDSidebar
//
//  Created by Steven McWhorter on 2/2/13.
//
//

#import "FooterView.h"

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

- (void)drawBackground {
    
    
    //[[NSColor controlBackgroundColor] set];
   // NSLog(@"drawBackground");
    float red = 0.2f;
    float green = 0.5f;
    float blue = 0.7f;
    float alpha = 1.0f;
    
    float red1 = 0.2f;
    float green1 = 0.4f;
    float blue1 = 0.6f;
    float alpha1 = 0.5f;
    // Initialization code here.
    float w = self.bounds.size.width;
    float h =self.bounds.size.height;
   // NSLog(@"Footer drawBackground - Width: %f Heigth: %f",w,h);

    // NSLog(@"drawBackground - Width: %f Heigth: %f",w,h);
    NSColor *rgb = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red1 green: green1 blue: blue1 alpha: alpha1];
    //[rgb set];
    NSRect rec = NSMakeRect(0.0f, 0.0f, w, h);
   // NSRectFill(rec);
   
    // upper shadow
    NSGradient *gradient = [[NSGradient alloc] initWithStartingColor:rgb endingColor:rgb1];
    //NSRect rectGradient = NSMakeRect(0, NSMinY(rec)-1-0.5, NSWidth(rec)-1, 4.0);
    NSBezierPath *path = [NSBezierPath bezierPathWithRect:rec];
    [gradient drawInBezierPath:path angle:90];
#if !__has_feature(objc_arc)
    [gradient release];
#endif		

}

@end
