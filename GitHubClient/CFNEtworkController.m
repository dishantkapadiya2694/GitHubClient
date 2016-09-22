//
//  CFNEtworkController.m
//  GitHubClient
//
//  Created by Dishant Kapadiya on 9/21/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "CFNEtworkController.h"

@implementation CFNEtworkController
-(NSMutableArray *)getRepoForRequest:(NSString *)searchString
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.github.com/search/repositories?q=%@", searchString]];
    NSData *searchDataFromGit = [NSData dataWithContentsOfURL:url];
    NSError *error;
    NSMutableDictionary *dictOfJSONDataFromGit = [NSJSONSerialization JSONObjectWithData:searchDataFromGit
                                                                                 options:NSJSONReadingMutableContainers
                                                                                   error:&error];
    
    if(error){
        NSLog(@"Error in deserialising JSON");
    } else {
        return [dictOfJSONDataFromGit valueForKey:@"items"];
    }
    
    return [NSMutableArray arrayWithObject:error];
}
@end

