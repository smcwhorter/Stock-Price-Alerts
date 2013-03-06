//
//  SPANetworkManager.m
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/19/13.
//
//


#import "SPADataDownloadManager.h"
#import "SPAConstants.h"



//Private section
@interface SPADataDownloadManager()
//Properties
@property (nonatomic, assign) StockDownloadDataType stockDataRequetType;
@property (nonatomic, strong, readwrite) NSURLConnection *fetchConnection;
@property (nonatomic, strong) NSMutableData *rawData;
@end


@implementation SPADataDownloadManager


#pragma mark - Stock Data Request

//This method will call the web service and search for stock
-(void) searchForStockWithCriteria:(NSString*) companyOrSymbol {
    //Create the url
    NSString *urlString = [STOCK_SEARCH_MAIN_URL stringByAppendingString:companyOrSymbol];
    urlString = [urlString stringByAppendingString:STOCK_SEARCH_MAIN_URL_SUFFIX];
    self.stockDataRequetType = StockSearchData;
    
    //Create a URL object
    NSURL *url = [NSURL URLWithString:urlString];
    //Create a request object
    NSURLRequest *stockSearchRequest = [[NSURLRequest alloc] initWithURL:url];
    //Create a new connection object and search for the 
    _fetchConnection = [[NSURLConnection alloc] initWithRequest:stockSearchRequest delegate:self];

    //Start loading data
    [_fetchConnection start];
}


-(void) fetchStockDetailInformation:(NSString*) companyOrSymbol {
    NSString *urlString = [@"http://download.finance.yahoo.com/d/quotes.csv?s=" stringByAppendingString:companyOrSymbol];
    urlString = [urlString stringByAppendingString:@"&f=snd1l1yrww1t8"];
    self.stockDataRequetType = AdditionalDetailsData;
    //Create a URL object
    NSURL *url = [NSURL URLWithString:urlString];
    //Create a request object
    NSURLRequest *stockDetailsRequest = [[NSURLRequest alloc] initWithURL:url];
    //create connection
    _fetchConnection = [[NSURLConnection alloc] initWithRequest:stockDetailsRequest delegate:self];
    
    //Start the connection
    [_fetchConnection start];
}

//This method will cleanup the connection and call the delegate method
-(void)signalDownloadComplete {
    //Call the delegate
    [_delegate downloadDataCompletewithData:self.rawData forStockDataType:self.stockDataRequetType];
    
    _stockDataRequetType = noData;
}

#pragma mark - NSURLConnection delegates
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    if(connection){
        NSLog(@"Finished Loading");
    
        //Call method to clean up connection and signal to others that the data is ready
        [self signalDownloadComplete];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    if(connection){
        NSLog(@"Received Data - size: %d",(int)[data length]);
        [_rawData appendData:data];
    }
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    if((connection) && (response)){
        //Create and return an empty data object
        self.rawData = [NSMutableData data];
        [_rawData setLength:0];
    }

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
