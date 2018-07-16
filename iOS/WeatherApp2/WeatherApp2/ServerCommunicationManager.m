//
//  ServerCommunicationManager.m
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 16.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import "ServerCommunicationManager.h"

static ServerCommunicationManager *shared = nil;

@implementation ServerCommunicationManager 

- (id)init
{
    if ( self = [super init] ) {
        receivedData = [NSMutableData new];
    }
    
    return self;
}

+(ServerCommunicationManager*) sharedInstance
{
    if (!shared || shared == nil) {
        // allocate the shared instance, because it hasn't been done yet
        shared = [[ServerCommunicationManager alloc] init];
    }
    
    return shared;
}

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    receivedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [receivedData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                 willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    NSError *error = nil;
    NSDictionary *response = [NSJSONSerialization JSONObjectWithData:receivedData
                                                             options:NSJSONReadingMutableContainers error:&error];
    
    if ( error == nil ) {
       //NSLog(@"%@", response);
        [self.delegate didReceiveMyResponse: response];
    }
    
    receivedData = nil;
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

#pragma mark - Request Handler
-(void) sendRequest: (NSString *)url delegate: (id)dele
{
    // Create the request.
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString: url]];
    
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    self.delegate = dele;
}






@end
