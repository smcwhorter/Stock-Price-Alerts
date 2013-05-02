//
//  SPAStockWebServiceDataParser.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 4/27/13.
//
//

#import "SPAStockWebServiceDataParser.h"

@implementation SPAStockWebServiceDataParser


+(NSArray*) parseDownloadedDataForSearchResults:(NSData *)theData{
    NSString *readableData = [self convertNSDataToNSString:theData];
    NSString *jsonStringObject = [self removeBracketsFromJSONString:readableData];
    NSData *stringByToData = [jsonStringObject dataUsingEncoding:NSASCIIStringEncoding];
    //parse out the json data
    NSError* error;
    NSArray *jsonSearchResults = [NSJSONSerialization JSONObjectWithData:stringByToData options:kNilOptions error:&error];
    
    return jsonSearchResults;
}

+ (NSString *)removeBracketsFromJSONString:(NSString *)readableData {
    NSRange partToFind = [readableData rangeOfString:@"["];
    NSString *stringPart = [readableData substringFromIndex:partToFind.location];
    NSRange partToFind1 = [stringPart rangeOfString:@"]"];
    NSString *jsonStringObject = [stringPart substringToIndex:partToFind1.location + 1];
    return jsonStringObject;
}

+(NSMutableDictionary*) parseDownloadedDataForAdditionalData:(NSData *)theData {
    NSString *stockInfoString = [self convertNSDataToNSString:theData];
    NSArray *stockData = [self removeUnwantedCharsInStringForParsing:stockInfoString];
    NSDictionary *listOfStocks = [self breakApartStockDataForAllStocksInString:stockData];
    return  listOfStocks;
}

//Create a string that is readable from the data
+ (NSString *)convertNSDataToNSString:(NSData *)theData {
    NSString *readableData = [[NSString alloc] initWithBytes:[theData bytes] length:[theData length] encoding: NSASCIIStringEncoding];
    return readableData;
}

+ (NSArray *)removeUnwantedCharsInStringForParsing:(NSString *)stockInfoString {
    NSString *stockInfoStringNoQuotes = [stockInfoString stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSArray *stockData = [stockInfoStringNoQuotes componentsSeparatedByString:@"\n"];
    return stockData;
}

+ (NSMutableDictionary *)breakApartStockDataForAllStocksInString:(NSArray *)stockData {
    NSMutableDictionary *stockList = [[NSMutableDictionary alloc] init];
    
    for(int x = 0; x < (int)[stockData count]; x++)
    {
        NSArray *singleStockData = [stockData[x] componentsSeparatedByString:@","];
        [stockList setValue:singleStockData forKey:singleStockData[0]];
    }
    
    return stockList;
}

@end
