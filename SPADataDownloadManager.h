//
//  SPANetworkManager.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/19/13.
//
//

#import <Foundation/Foundation.h>

//Define a delegte for this class
@protocol SAPDataDownloadCompleteDelegate
-(void) downloadDataComplete;
@end

@interface SPADataDownloadManager : NSObject
{
    NSMutableData *rawData;
    NSURLConnection *connection;
    id <SAPDataDownloadCompleteDelegate> delegate;
    
}

//Properties
@property (nonatomic, strong, readwrite) NSURLConnection *connection;
@property (nonatomic, strong) NSMutableData *rawData;
@property (retain, nonatomic) id <SAPDataDownloadCompleteDelegate> delegate;
//Instance methods
-(void) searchForStockWithCriteria:(NSString*) companyOrSymbol;
-(void) signalDownloadComplete;
@end
