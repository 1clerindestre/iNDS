//
//  iNDSDBManager.m
//  iNDS
//
//  Created by Frederick Morlock on 7/31/18.
//  Copyright © 2018 iNDS. All rights reserved.
//

#import "iNDSDBManager.h"

@implementation iNDSDBManager

+ (id)sharedInstance {
    static iNDSDBManager *shared = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        shared = [[self alloc] init];
    });
    
    return shared;
}

- (id) init {
    return [super init];
}

- (void) openDB:(NSString *)dbPath {
    if (sqlite3_open_v2([dbPath UTF8String], &_database, SQLITE_OPEN_READWRITE, NULL) == SQLITE_OK) {
        NSLog(@"Sucessfully opened games database");
    }
    else {
        sqlite3_close(_database);
        NSLog(@"Failed to open games database");
    }
}

- (void) closeDB {
    sqlite3_close(_database);
}

- (void) query:(NSString*)queryString result:(void (^)(int resultCode, sqlite3_stmt *statement))result {
    sqlite3_stmt *statement;
    int resultCode = sqlite3_prepare_v2(_database, [queryString UTF8String], -1, &statement, nil);
    
    if ((resultCode == SQLITE_OK) && result) {
        result(resultCode, statement);
    }
    
    sqlite3_finalize(statement);
}

- (void) dealloc {
    sqlite3_close(_database);
}

@end
