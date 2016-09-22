//
//  CFNEtworkController.h
//  GitHubClient
//
//  Created by Dishant Kapadiya on 9/21/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CFNEtworkController : NSObject

-(NSMutableArray *)getRepoForRequest:(NSString *)searchString;
@end
