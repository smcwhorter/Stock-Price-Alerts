//
//  SPANetworkManager.h
//  StockPriceAlerts
//
//  Created by Steven McWhorter on 2/19/13.
//
//
#import "SPAConstants.h"
#import <Foundation/Foundation.h>

//Define a delegte for this class
@protocol SPADataDownloadCompleteDelegate
-(void) downloadDataCompletewithData:(NSMutableData*)theData forStockDataType:(StockDownloadDataType) theStockDataType;
@end

@interface SPADataDownloadManager : NSObject

@property (assign, nonatomic) id <SPADataDownloadCompleteDelegate> delegate;
//Public methods
-(void) searchForStockWithCriteria:(NSString*) companyOrSymbol;
-(void) fetchStockDetailInformation:(NSString*) companyOrSymbol;
@end
