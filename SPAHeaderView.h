//
//  MyView.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/1/13.
//
//

#import <Cocoa/Cocoa.h>

@interface SPAHeaderView : NSView
{
    float frameWidth;
    float frameHeigth;
}
@property (assign) float frameWidth;
@property (assign) float frameHeigth;

- (void)drawBackground;
@end
