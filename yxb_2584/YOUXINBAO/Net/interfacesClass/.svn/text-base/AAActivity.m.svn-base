#import <objc/runtime.h>
#import "AAActivity.h"
#import "ActivityMember.h"
#import "ActivityComplaint.h"



@implementation AAActivity
@dynamic errCode;

-(void)dealloc
{
//  [super dealloc];
}

- (void)decodeWithDic:(NSDictionary *)dic {
    [super decodeWithDic:dic];


//#warning ///

//    self.status = 3;
//    NSInteger age = arc4random()%(30-5+1);
//    self.topic = [NSString stringWithFormat:@"小刘%ld岁生日",age];
//    self.destName = @"北京朝阳广顺南大街";
    
//    self.myMemberStatus = 1;
    NSMutableArray *memberArray = [NSMutableArray new];
    for (NSDictionary *dic in self.participants) {
        ActivityMember *member = [[ActivityMember alloc] init];
        [member decodeWithDic:dic];
        [memberArray addObject:member];
    }
    self.participants = memberArray;
    
    NSMutableArray *complaintsArr = [NSMutableArray new];
    for (NSDictionary *dic in self.complaints) {
        ActivityComplaint *complaint = [[ActivityComplaint alloc] init];
        [complaint decodeWithDic:dic];
        [complaintsArr addObject:complaint];
    }
    self.complaints = complaintsArr;
}

-(void) decodeWithSubArray:(NSArray*) arr withPropertyName:(NSString*) name {
    if ([name isEqualToString:@"participants"]) {
        self.participants = (NSMutableArray *)[NSArray arrayWithArray:arr];
//        NSLog(@"installmentList = %@", self.installmentList);
    }else if ([name isEqualToString:@"complaints"]) {
        self.complaints = (NSMutableArray *)[NSArray arrayWithArray:arr];
        //        NSLog(@"installmentList = %@", self.installmentList);
    }
}

//获取星期
-(NSString *)getActivityWeekDay
{

    NSString *weekDay = @"";
    NSArray *weekdays = [NSArray arrayWithObjects:@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六",@"星期日", nil];
    if (_weekday < [weekdays count]) {
        weekDay = weekdays[_weekday-1];
    }
    
    return weekDay;
}


@end
