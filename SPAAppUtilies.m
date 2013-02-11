//
//  SPAAppUtilies.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/10/13.
//
//

#import "SPAAppUtilies.h"

@implementation SPAAppUtilies

+(NSColor*) darkGray{
   
    //Dark gray
    float red1 = 191.0/255.0;
    float green1 = 191.0/255.0;
    float blue1 = 191.0/255.0;
    float alpha1 = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red1 green: green1 blue: blue1 alpha: alpha1];
    
    return rgb1;
}

+(NSColor*) lightGray{
    //Dark gray
    float red = 230.0/255.0;
    float green = 230.0/255.0;
    float blue = 230.0/255.0;
    float alpha = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    
    return rgb1;
}
@end
