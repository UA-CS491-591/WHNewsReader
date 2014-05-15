//
//  WHDataRetrieval.h
//  WHNewsReader
//
//  Created by Mason Saucier on 5/13/14.
//
//

#import <Foundation/Foundation.h>

@interface WHDataRetrieval : NSObject

+ (void)getStoryById:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block;

+ (void)getStoryRecent:(NSString *)userToken completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block;

+ (void)getStoryByCategory:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block;

+ (void)getStoryByAuthor:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block;

+ (void)getStorySearch:(NSString *)userToken searchString:(NSString *)search completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block;

+ (void)getCategories:(NSString *)userToken completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block;

+ (void)getAuthorById:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block;

+(void)login:(NSString *)username password:(NSString *)password;

+(NSString *) setUserToken:(NSString *)userToken;

+(NSString *) userToken;


@end
