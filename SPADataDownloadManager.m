//
//  SPANetworkManager.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/19/13.
//
//

#import "SPADataDownloadManager.h"

//Constant strings
static NSString *const kMainURL = @"http://download.finance.yahoo.com/d/quotes.csv?s=";
static NSString *const KmMilURLTail = @"&f=snd1l1yrww1t8";
static NSString *const kMainSearchURL = @"http://d.yimg.com/autoc.finance.yahoo.com/autoc?query=";
static NSString *const kSearchURLTrail = @"&callback=YAHOO.Finance.SymbolSuggest.ssCallback";

@implementation SPADataDownloadManager

@synthesize connection;
@synthesize rawData;

#pragma mark - Stock Data Request
-(void) searchForStockWithCriteria:(NSString*) companyOrSymbol {
    //Create the url
    NSURL *url = [NSURL URLWithString:[kMainSearchURL stringByAppendingString:companyOrSymbol]];
    NSURLRequest *stockSearchRequest = [[NSURLRequest alloc] initWithURL:url];
    //Create a new connection object and search for the 
    connection = [[NSURLConnection alloc] initWithRequest:stockSearchRequest delegate:self];

    //Start loading data
    [connection start];
}

-(void)signalDownloadComplete {
    connection = nil;
    [delegate downloadDataComplete];
}

#pragma mark - NSURLConnection delegates
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finished Loading");
    
    //Call method to clean up connection and signal to others that the data is ready
    [self signalDownloadComplete];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(connection != nil){
        NSLog(@"Received Data - size: %d",(int)[data length]);
        [rawData appendData:data];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    self.rawData = [NSMutableData data];
    [rawData setLength:0];

}

// A delegate method called by the NSURLConnection if the connection fails.
// We shut down the connection and display the failure.  Production quality code
// would either display or log the actual error.
- (void)connection:(NSURLConnection *)theConnection didFailWithError:(NSError *)error
{
#pragma unused(theConnection)
#pragma unused(error)
    assert(theConnection == self.connection);
    
    //[self stopReceiveWithStatus:@"Connection failed"];
}
@end
