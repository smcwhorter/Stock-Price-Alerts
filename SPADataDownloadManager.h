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
-(void) downloadDataCompletewithData:(NSMutableData*)theData;
@end

@interface SPADataDownloadManager : NSObject
{
    NSMutableData *rawData;
    NSURLConnection *fetchConnection;
    id <SAPDataDownloadCompleteDelegate> delegate;
    
}

//Properties
@property (nonatomic, strong, readwrite) NSURLConnection *fetchConnection;
@property (nonatomic, strong) NSMutableData *rawData;
@property (nonatomic, strong) id <SAPDataDownloadCompleteDelegate> delegate;
//Instance methods
-(void) searchForStockWithCriteria:(NSString*) companyOrSymbol;
-(void) signalDownloadComplete;
@end
