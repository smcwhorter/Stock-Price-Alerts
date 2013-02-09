//
//  FooterView.h
//  EDSidebar
//
//  Created by Steven McWhorter on 2/2/13.
//
//

#import <Cocoa/Cocoa.h>

@interface FooterView : NSView
{
    float frameWidth;
    float frameHeigth;
}
@property (assign) float frameWidth;
@property (assign) float frameHeigth;
- (void)drawBackground;
@end
