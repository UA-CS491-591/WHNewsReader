//
//  WHDataRetrieval.m
//  WHNewsReader
//
//  Created by Mason Saucier on 5/13/14.
//
//

#import "WHDataRetrieval.h"

@implementation WHDataRetrieval

NSOperationQueue *opQueue;

+(NSOperationQueue *)_operationQueue
{
    if (opQueue == nil) {
        opQueue = [[NSOperationQueue alloc] init];
    }
    return opQueue;
}

+ (void)getStoryById:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *urlString = @"https://mobileweb.caps.ua.edu/cs491/api/Story/byId";
    NSString *urlQueryString = [NSString stringWithFormat:@"?token=%@&storyId=%@", token, Id];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@", urlString, urlQueryString];
    
    //Create url
    NSURL *url = [NSURL URLWithString:completeUrlString];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:block];
}

+ (void)getStoryRecent:(NSString *)userToken completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *urlString = @"https://mobileweb.caps.ua.edu/cs491/api/Story/recent";
    NSString *urlQueryString = [NSString stringWithFormat:@"?token=%@", userToken];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@", urlString, urlQueryString];
    
    //Create url
    NSURL *url = [NSURL URLWithString:completeUrlString];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:block];
}

+ (void)getStoryByCategory:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *urlString = @"https://mobileweb.caps.ua.edu/cs491/api/Story/byCategory";
    NSString *urlQueryString = [NSString stringWithFormat:@"?token=%@&categoryId=%@", token, Id];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@", urlString, urlQueryString];
    
    //Create url
    NSURL *url = [NSURL URLWithString:completeUrlString];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:block];
}

+ (void)getStoryByAuthor:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *urlString = @"https://mobileweb.caps.ua.edu/cs491/api/Story/byAuthor";
    NSString *urlQueryString = [NSString stringWithFormat:@"?token=%@&authorId=%@", token, Id];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@", urlString, urlQueryString];
    
    //Create url
    NSURL *url = [NSURL URLWithString:completeUrlString];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:block];
}

+ (void)getStorySearch:(NSString *)userToken searchString:(NSString *)search completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *urlString = @"https://mobileweb.caps.ua.edu/cs491/api/Story/search";
    NSString *urlQueryString = [NSString stringWithFormat:@"?token=%@&searchString=%@", userToken, search];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@", urlString, urlQueryString];
    
    //Create url
    NSURL *url = [NSURL URLWithString:completeUrlString];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:block];
}

+ (void)getCategories:(NSString *)userToken completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *urlString = @"https://mobileweb.caps.ua.edu/cs491/api/Category/categories";
    NSString *urlQueryString = [NSString stringWithFormat:@"?token=%@", userToken];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@", urlString, urlQueryString];
    
    //Create url
    NSURL *url = [NSURL URLWithString:completeUrlString];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:block];
}

+ (void)getAuthorById:(NSString *)Id userToken:(NSString *)token completetionHandler:(void (^__weak)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *urlString = @"https://mobileweb.caps.ua.edu/cs491/api/Author/byId";
    NSString *urlQueryString = [NSString stringWithFormat:@"?token=%@&authorId=%@", token, Id];
    NSString *completeUrlString = [NSString stringWithFormat:@"%@%@", urlString, urlQueryString];
    
    //Create url
    NSURL *url = [NSURL URLWithString:completeUrlString];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    
    //Make request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:block];
}

+(void)login:(NSString *)username password:(NSString *)password{
    //Create url
    NSURL *url = [NSURL URLWithString:@"https://mobileweb.caps.ua.edu/cs491/api/Account/login"];
    
    //Create request object
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5.0];
    //Let the server know that we want to interact in JSON
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //Set http method
    [request setHTTPMethod:@"POST"];
    
    //Specify the string to get sent to the server
    NSString *loginString = [NSString stringWithFormat:@"{\"username\": \"%@\",\"password\": \"%@\"}", username, password];
    //Make that string into raw data
    NSData *loginData = [loginString dataUsingEncoding:NSUTF8StringEncoding];
    //Set that raw data as the HTTP Body for the request
    [request setHTTPBody:loginData];
    
    //Send asynchronous request
    [NSURLConnection sendAsynchronousRequest:request queue:[WHDataRetrieval _operationQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //Decode to string
        NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        //Log out response
        NSLog(@"%@", responseString);
    }];
}

static NSString* token = nil;

+(NSString *) userToken
{
    return token;
}

+(void) setUserToken:(NSString*) userToken
{
    token = userToken;
}


@end
