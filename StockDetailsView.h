//
//  StockDetailsView.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/14/13.
//
//

#import <Cocoa/Cocoa.h>

@interface StockDetailsView : NSView
{
    float frameWidth;
    float frameHeigth;
}
@property (assign) float frameWidth;
@property (assign) float frameHeigth;
- (void)drawBackground;
@end
