//
//  tableViewImageDownload.h
//  WMBT
//
//  Created by link on 2011/7/12.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DownloadImg;
@protocol tableViewImgDownloaderDelegate;

@interface tableViewImageDownload : NSObject {
    DownloadImg *downloadImg;
    NSIndexPath *indexPathInTableView;
    id <tableViewImgDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
    BOOL bLoaded;
}
@property (nonatomic, retain) DownloadImg *downloadImg;
@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (nonatomic, assign) id <tableViewImgDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;
@property (nonatomic) BOOL bLoaded;
- (void)startDownload;
- (void)cancelDownload;
@end
@protocol tableViewImgDownloaderDelegate 
- (void)imageDidLoad:(NSIndexPath *)indexPath;
@end
