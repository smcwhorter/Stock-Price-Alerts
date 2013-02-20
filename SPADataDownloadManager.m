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

@synthesize fetchConnection;
@synthesize rawData;
@synthesize delegate;

#pragma mark - Stock Data Request
-(void) searchForStockWithCriteria:(NSString*) companyOrSymbol {
    //Create the url
    NSURL *url = [NSURL URLWithString:[kMainSearchURL stringByAppendingString:companyOrSymbol]];
    NSURLRequest *stockSearchRequest = [[NSURLRequest alloc] initWithURL:url];
    //Create a new connection object and search for the 
    fetchConnection = [[NSURLConnection alloc] initWithRequest:stockSearchRequest delegate:self];

    //Start loading data
    [fetchConnection start];
}

-(void)signalDownloadComplete {
    fetchConnection = nil;
    [delegate downloadDataCompletewithData:self.rawData];
}

#pragma mark - NSURLConnection delegates
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finished Loading");
    
    //Call method to clean up connection and signal to others that the data is ready
    [self signalDownloadComplete];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(connection){
        NSLog(@"Received Data - size: %d",(int)[data length]);
        [rawData appendData:data];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    //Create and return an empty data object
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
    assert(theConnection == self.fetchConnection);
    
    //[self stopReceiveWithStatus:@"Connection failed"];
}
@end
