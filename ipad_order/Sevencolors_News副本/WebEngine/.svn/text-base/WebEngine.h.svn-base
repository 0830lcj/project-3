
#import "MKNetworkKit/MKNetworkEngine.h"

@interface WebEngine : MKNetworkEngine

typedef void (^StringResponseBlock)(NSString* responseString);

- (void)sendHttpRequest:(NSString*)url data:(NSMutableDictionary*)data method:(NSString*)method completionHandler:(StringResponseBlock)responseBlock;
- (BOOL) checkUserAuth : (NSString*)responseString;

@end
