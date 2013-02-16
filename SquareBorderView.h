//
//  BasicBackGroundView.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/3/13.
//
//

#import <Cocoa/Cocoa.h>

@interface SquareBorderView : NSView
{
    float frameWidth;
    float frameHeigth;
}
@property (assign) float frameWidth;
@property (assign) float frameHeigth;
- (void)drawBackground;
@end
