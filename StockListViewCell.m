//
//  SPAListViewCellBackground.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 3/24/13.
//
//

#import "StockListViewCell.h"

//Private interface
@interface StockListViewCell ()
- (void)drawBackground;
@property (nonatomic, readonly) NSGradient *gradient;
@end


@implementation StockListViewCell
@synthesize selected;
@synthesize gradient;
@synthesize tickerTextView;
@synthesize companyNameTextView;
@synthesize currentPriceTextView;
@synthesize priceChangeTextView;
@synthesize lowPriceTextView;
@synthesize highPriceTextView;
@synthesize yearRangeTextView;
@synthesize targetPriceTextView;
@synthesize priceDirectionImageView;
@synthesize lowPriceImageView;
@synthesize highPriceImageView;

//Gradient getter override
- (NSGradient *)gradient {
    if(gradient == nil) {
        gradient = [[NSGradient alloc] initWithStartingColor:[NSColor colorWithDeviceWhite:0.8f alpha:1.0f] endingColor:[NSColor colorWithDeviceWhite:0.85f alpha:1.0f]];
    }
    
    return gradient;
}

+ (StockListViewCell *)stockListViewCell {
    static NSNib *nib = nil;
    if(nib == nil) {
        nib = [[NSNib alloc] initWithNibNamed:NSStringFromClass(self) bundle:nil];
    }
    
    NSArray *objects = nil;
    //[nib instantiateNibWithOwner:nil topLevelObjects:&objects];
    [nib instantiateWithOwner:nil topLevelObjects:&objects];
    for(id object in objects) {
        if([object isKindOfClass:self]) {
            return object;
        }
    }
    
    NSAssert1(NO, @"No view of class %@ found.", NSStringFromClass(self));
    return nil;
}

#pragma mark - View Overrides
- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect{
    [super drawRect:dirtyRect];
    [self drawBackground];
    // Drawing code here.
}


#pragma mark - Draw Background

- (void)drawBackground {
    [self.gradient drawInRect:self.bounds angle:self.selected ? 270.0f : 90.0f];
    
    [[NSColor colorWithDeviceWhite:0.5f alpha:1.0f] set];
    NSRectFill(NSMakeRect(0.0f, 0.0f, self.bounds.size.width, 1.0f));
    
    [[NSColor colorWithDeviceWhite:0.93f alpha:1.0f] set];
    NSRectFill(NSMakeRect(0.0f, self.bounds.size.height - 1.0f, self.bounds.size.width, 1.0f));
}


#pragma mark - View Methdos
- (void)setSelected:(BOOL)isSelected {
    selected = isSelected;
    
    [self setNeedsDisplay:YES];
}

@end
