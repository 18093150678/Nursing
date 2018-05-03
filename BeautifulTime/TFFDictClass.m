//
//  TFFDictClass.m
//  BeautifulTime
//
//  Created by MyBockPro on 16/12/7.
//  Copyright © 2016年 MyBockPro. All rights reserved.
//

#import "TFFDictClass.h"

@implementation TFFDictClass
@synthesize dict;

-(id)init{

    self = [super init];
    if (self !=nil) {
        NSLog(@"---x--");
        
        dict = [[NSMutableDictionary alloc]init];
        
        [dict setValue:@"\U0000e600" forKey:@"e600"];
        [dict setValue:@"\U0000e601" forKey:@"e601"];
        [dict setValue:@"\U0000e602" forKey:@"e602"];
        [dict setValue:@"\U0000e61d" forKey:@"e61d"];
        [dict setValue:@"\U0000e610" forKey:@"e610"];
        [dict setValue:@"\U0000e611" forKey:@"e611"];
        [dict setValue:@"\U0000e628" forKey:@"e628"];
        [dict setValue:@"\U0000e612" forKey:@"e612"];
        [dict setValue:@"\U0000e603" forKey:@"e603"];
        [dict setValue:@"\U0000e605" forKey:@"e605"];
        [dict setValue:@"\U0000e604" forKey:@"e604"];
        [dict setValue:@"\U0000e606" forKey:@"e606"];
        [dict setValue:@"\U0000e613" forKey:@"e613"];
        [dict setValue:@"\U0000e69c" forKey:@"e69c"];
        [dict setValue:@"\U0000e607" forKey:@"e607"];
        [dict setValue:@"\U0000e679" forKey:@"e679"];
        [dict setValue:@"\U0000e60f" forKey:@"e60f"];
        [dict setValue:@"\U0000e608" forKey:@"e608"];
        [dict setValue:@"\U0000e741" forKey:@"e741"];
        [dict setValue:@"\U0000e609" forKey:@"e609"];
        [dict setValue:@"\U0000e614" forKey:@"e614"];
        [dict setValue:@"\U0000e60a" forKey:@"e60a"];
        [dict setValue:@"\U0000e60b" forKey:@"e60b"];
        [dict setValue:@"\U0000e60c" forKey:@"e60c"];
        [dict setValue:@"\U0000e60d" forKey:@"e60d"];
        [dict setValue:@"\U0000e615" forKey:@"e615"];
        [dict setValue:@"\U0000e629" forKey:@"e629"];
        [dict setValue:@"\U0000e617" forKey:@"e617"];
        [dict setValue:@"\U0000e60e" forKey:@"e60e"];
        
    }

    return self;
}

-(NSString *)getDictFont:(NSString *)fontUdc{

   
    NSLog(@"fontUdc--%@",fontUdc);


    
     NSLog(@"fontUdc--%@",[dict objectForKey:@"e600"]);
    NSLog(@"%@",[self.dict objectForKey:fontUdc]);
    return [self.dict objectForKey:fontUdc];


}

@end
