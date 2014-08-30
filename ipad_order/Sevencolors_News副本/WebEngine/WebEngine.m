
#import "WebEngine.h"
#import "MKNetworkKit.h"

@implementation WebEngine

- (BOOL) checkUserAuth : (NSString*)responseString
{
    if (responseString && responseString.length > 0)
    {
        @try {
            id retObj = [NSJSONSerialization JSONObjectWithData:[responseString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
            if ([retObj isKindOfClass:[NSMutableDictionary class]])
            {
                if ([[retObj allKeys] containsObject:@"success"])
                    return [[retObj objectForKey:@"success"] boolValue];
            }
        }
        @catch (NSException *exception) {
            
        }
        
    }
    return TRUE;
}

- (void)sendHttpRequest:(NSString*)url data:(NSMutableDictionary*)data method:(NSString*)method completionHandler:(StringResponseBlock)responseBlock
{
    MKNetworkOperation *op = [self operationWithURLString:url params:data httpMethod:method];
    [op addCompletionHandler:^(MKNetworkOperation *operation) {
        responseBlock([operation responseString]);
    }errorHandler:^(MKNetworkOperation *errorOp, NSError* error) {
        responseBlock(nil);
    }];
    [self enqueueOperation:op];
}

@end
