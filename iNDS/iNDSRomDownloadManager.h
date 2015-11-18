//
//  iNDSRomDownloadManager.h
//  iNDS
//
//  Created by Will Cobb on 11/17/15.
//  Copyright © 2015 iNDS. All rights reserved.
//

#import <Foundation/Foundation.h>
@class iNDSRomDownload;

@interface iNDSRomDownloadManager : NSObject

@property (strong, readonly) NSMutableArray * activeDownloads;

+ (id)sharedManager;
- (void)addRequest:(NSURLRequest *)request;
- (void)removeDownload:(iNDSRomDownload *)download;
@end

@interface iNDSRomDownload : NSObject {
    NSURLConnection * _connection;
    
    long long expectedBytes;
    float progress;
    NSMutableData * fileData;
    
    iNDSRomDownloadManager *_delegate;
    
}

@property (weak, nonatomic)UILabel * progressLabel;
@property (weak, nonatomic)CALayer * progressLayer;

- (id)initWithRequest:(NSURLRequest *)request delegate:(iNDSRomDownloadManager *)delegate;
- (float)progress;
- (NSString *)name;

@end