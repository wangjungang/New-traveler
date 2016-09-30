//
//  APIClient.m
//  newtravel
//
//  Created by 王俊钢 on 16/9/30.
//  Copyright © 2016年 wangjungang. All rights reserved.
//

#import "APIClient.h"

@implementation APIClient
+(instancetype)sharedClient{
    static APIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    NSString *urlc=[NSString stringWithFormat:@"http://%@",serviseId];
    dispatch_once(&onceToken, ^{
        _sharedClient = [[APIClient alloc] initWithBaseURL:
                         [NSURL URLWithString:urlc]];
        
        
        
        //[NSURL URLWithString:@"http://192.168.0.14"]];
        
        
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
        [_sharedClient.requestSerializer setValue:@"2" forHTTPHeaderField:@"Accept"];
        
    });
    return _sharedClient;
    
}

@end
