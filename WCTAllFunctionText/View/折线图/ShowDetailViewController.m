//
//  ShowDetailViewController.m
//  WCTAllFunctionText
//
//  Created by four on 16/3/18.
//  Copyright © 2016年 王春涛. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "BooldDetailShowFormView.h"

@interface ShowDetailViewController ()

@end

@implementation ShowDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self.titleStr isEqualToString:@"血压记录"]) {
        [self initBooldPressure];
    }
    else if ([self.titleStr isEqualToString:@"血糖记录"])
    {
        [self initBooldSuger];
    }else
    {
        [self initBooldOxygen];
    }

}
-(void)initBooldPressure{
    
    NSDictionary *dict = @{@"title":@"+80",@"point":@"80",@"time":@"2016-03-01 21:20",@"mmHg":@"180/80mmHg"};
    NSDictionary *dict2 = @{@"title":@"+90",@"point":@"90",@"time":@"2016-02-02 21:20",@"mmHg":@"120/80mmHg"};
    NSDictionary *dict3 = @{@"title":@"+100",@"point":@"100",@"time":@"2016-04-04 21:20",@"mmHg":@"130/50mmHg"};
    NSDictionary *dict4 = @{@"title":@"+90",@"point":@"90",@"time":@"2016-05-05 21:20",@"mmHg":@"140/60mmHg"};
    NSDictionary *dict5 = @{@"title":@"+90",@"point":@"90",@"time":@"2016-02-02 21:20",@"mmHg":@"120/80mmHg"};
    NSDictionary *dict6 = @{@"title":@"+100",@"point":@"100",@"time":@"2016-04-04 21:20",@"mmHg":@"130/50mmHg"};
    NSDictionary *dict7 = @{@"title":@"+90",@"point":@"90",@"time":@"2016-05-05 21:20",@"mmHg":@"140/60mmHg"};
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:dict];
    [array addObject:dict2];
    [array addObject:dict3];
    [array addObject:dict4];
    [array addObject:dict5];
    [array addObject:dict6];
    [array addObject:dict7];
    
    NSArray *number = @[@"mmHg",@"120",@"105",@"90",@"75",@"60",@"45",@"30",@"15",@"0",];
    BooldDetailShowFormView *view = [[BooldDetailShowFormView alloc]initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight - 64) andTitle:@"血压" andData:array andYLable:number andXLabel:nil andMaxY:135 andAverage:15  andPointNum:4];
    [self.view addSubview:view];
    
}

-(void)initBooldSuger{
    NSDictionary *dict = @{@"title":@"+5.5",@"point":@"5.5",@"time":@"2016-03-01 21:20",@"mmHg":@"5.5mmol/L"};
    NSDictionary *dict2 = @{@"title":@"+3.3",@"point":@"3.3",@"time":@"2016-02-02 21:20",@"mmHg":@"3.3mmol/L"};
    NSDictionary *dict3 = @{@"title":@"+4.4",@"point":@"4.4",@"time":@"2016-04-04 21:20",@"mmHg":@"4.4mmol/L"};
    NSDictionary *dict4 = @{@"title":@"+6.6",@"point":@"6.6",@"time":@"2016-05-05 21:20",@"mmHg":@"6.6mmol/L"};
    NSDictionary *dict5 = @{@"title":@"+3.3",@"point":@"3.3",@"time":@"2016-02-02 21:20",@"mmHg":@"3.3mmol/L"};
    NSDictionary *dict6 = @{@"title":@"+4.4",@"point":@"4.4",@"time":@"2016-04-04 21:20",@"mmHg":@"4.4mmol/L"};
    NSDictionary *dict7 = @{@"title":@"+6.6",@"point":@"6.6",@"time":@"2016-05-05 21:20",@"mmHg":@"6.6mmol/L"};
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:dict];
    [array addObject:dict2];
    [array addObject:dict3];
    [array addObject:dict4];
    [array addObject:dict5];
    [array addObject:dict6];
    [array addObject:dict7];
    
    NSArray *number = @[@"mmol/L",@"8.0",@"7.0",@"6.0",@"5.0",@"4.0",@"3.0",@"2.0",@"1.0",@"0",];
    BooldDetailShowFormView *view = [[BooldDetailShowFormView alloc]initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight - 64) andTitle:@"血糖" andData:array andYLable:number andXLabel:nil andMaxY:8+1 andAverage:1  andPointNum:5];
    [self.view addSubview:view];
}

-(void)initBooldOxygen
{
    NSDictionary *dict = @{@"title":@"+55",@"point":@"55",@"time":@"2016-03-01 21:20",@"mmHg":@"55mmol/L"};
    NSDictionary *dict2 = @{@"title":@"+33",@"point":@"33",@"time":@"2016-02-02 21:20",@"mmHg":@"33mmol/L"};
    NSDictionary *dict3 = @{@"title":@"+44",@"point":@"44",@"time":@"2016-01-12 21:20",@"mmHg":@"44mmol/L"};
    NSDictionary *dict4 = @{@"title":@"+66",@"point":@"66",@"time":@"2016-11-06 21:20",@"mmHg":@"66mmol/L"};
    NSDictionary *dict5 = @{@"title":@"+44",@"point":@"44",@"time":@"2016-04-04 21:20",@"mmHg":@"44mmol/L"};
    NSDictionary *dict6 = @{@"title":@"+66",@"point":@"66",@"time":@"2016-05-05 21:20",@"mmHg":@"66mmol/L"};
    NSDictionary *dict7 = @{@"title":@"+33",@"point":@"33",@"time":@"2016-04-02 21:20",@"mmHg":@"33mmol/L"};
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    [array addObject:dict];
    [array addObject:dict2];
    [array addObject:dict3];
    [array addObject:dict4];
    [array addObject:dict5];
    [array addObject:dict6];
    [array addObject:dict7];
    
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    NSDictionary *dict8 = @{@"date":@"03/14 14:24"};
    for (int i=0; i<7; i++) {
        [array1 addObject:dict8];
    }
    
    NSArray *number = @[@"%",@"80",@"70",@"60",@"50",@"40",@"30",@"20",@"10",@"0",];
    BooldDetailShowFormView *view = [[BooldDetailShowFormView alloc]initWithFrame:CGRectMake(0, 64, MainScreenWidth, MainScreenHeight - 64) andTitle:@"血氧" andData:array andYLable:number andXLabel:array1 andMaxY:80 + 10 andAverage:10  andPointNum:3];
    [self.view addSubview:view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
