//
//  SPAAppUtilies.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/10/13.
//
//

#import "SPAAppUtilies.h"

@implementation SPAAppUtilies

+(NSArray*) parseDownloadedDataForSearchResults:(NSData *)theData{
    //Create a string that is readable from the data
    NSString *readableData = [[NSString alloc] initWithBytes:[theData bytes] length:[theData length] encoding: NSASCIIStringEncoding];
    
    
    NSRange partToFind = [readableData rangeOfString:@"["];
    NSString *stringPart = [readableData substringFromIndex:partToFind.location];
    //NSLog(@"StockEditViewController - Delegate method called - Data: %@", stringPart);
    
    NSRange partToFind1 = [stringPart rangeOfString:@"]"];
    
    NSString *jsonStringObject = [stringPart substringToIndex:partToFind1.location + 1];
    //NSLog(@"StockEditViewController - Delegate method called - Data: %@", jsonStringObject);
    
    NSData *stringByToData = [jsonStringObject dataUsingEncoding:NSASCIIStringEncoding];
    
    
    //parse out the json data
    NSError* error;
    NSArray *jsonSearchResults = [NSJSONSerialization JSONObjectWithData:stringByToData options:kNilOptions error:&error];
    
    return jsonSearchResults;
}

+(NSColor*)  stockEditDarkGrayStart{
    
    //Dark gray
    float red1 = 216.0/255.0;
    float green1 = 216.0/255.0;
    float blue1 = 216.0/255.0;
    float alpha1 = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red1 green: green1 blue: blue1 alpha: alpha1];
    
    return rgb1;
}

+(NSColor*) stockEditDarkGrayEnd{
    
    //Dark gray
    float red1 = 204.0/255.0;
    float green1 = 204.0/255.0;
    float blue1 = 204.0/255.0;
    float alpha1 = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red1 green: green1 blue: blue1 alpha: alpha1];
    
    return rgb1;
}

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

+(NSColor*) borderWhite{
    //Dark gray
    float red = 255.0/255.0;
    float green = 255.0/255.0;
    float blue = 255.0/255.0;
    float alpha = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    
    return rgb1;
}

+(NSColor*) borderMedium{
    //Dark gray
    float red = 183.0/255.0;
    float green = 183.0/255.0;
    float blue = 183.0/255.0;
    float alpha = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    
    return rgb1;
}

+(NSColor*) stockEditGradientStart{
    //Dark gray
    float red = 245.0/255.0;
    float green = 245.0/255.0;
    float blue = 245.0/255.0;
    float alpha = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    
    return rgb1;
}
+(NSColor*) stockEditGradientEnd{
    //Dark gray
    float red = 228.0/255.0;
    float green = 228.0/255.0;
    float blue = 228.0/255.0;
    float alpha = 1.0f;
    NSColor *rgb1 = [NSColor colorWithDeviceRed: red green: green blue: blue alpha: alpha];
    
    return rgb1;
}

@end
