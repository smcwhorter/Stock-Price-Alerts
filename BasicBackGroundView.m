//
//  BasicBackGroundView.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/3/13.
//
//

#import "BasicBackGroundView.h"

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
    
    
    //[[NSColor controlBackgroundColor] set];
    // NSLog(@"drawBackground");
    float red = 0.1f;
    float green = 0.3f;
    float blue = 0.6f;
    float alpha = 1.0f;
    // Initialization code here.
    float x = self.bounds.origin.x;
    float y = self.bounds.origin.y;
    float w = self.bounds.size.width;
    float h =self.bounds.size.height;
    NSLog(@"main drawBackground - Width: %f Heigth: %f",w,h);
    
    // NSLog(@"drawBackground - Width: %f Heigth: %f",w,h);
    NSColor *rgb = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    [rgb set];
    NSRectFill(NSMakeRect(x, y, w, h));
    
}

@end
