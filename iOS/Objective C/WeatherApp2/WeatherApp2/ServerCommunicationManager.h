//
//  ServerCommunicationManager.h
//  WeatherApp2
//
//  Created by slaviyana chervenkondeva on 16.07.18.
//  Copyright © 2018 slaviyana chervenkondeva. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ServerCommunicationDelegate <NSObject>

@required
-(void)didReceiveMyResponse: (id)dataInfo;
@end

@interface ServerCommunicationManager : NSObject <NSURLConnectionDelegate>{
    NSMutableData *receivedData;
}

@property(nonatomic) id delegate;

+ (ServerCommunicationManager*) sharedInstance;

-(void) sendRequest: (NSString *)url delegate: (id)dele;

@end
