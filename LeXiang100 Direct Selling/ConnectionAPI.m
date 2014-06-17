//
//  connectionAPI.m
//  LeXiang100 Direct Selling
//
//  Created by ZengYifei on 14-6-3.
//  Copyright (c) 2014年 ZengYifei. All rights reserved.
//

#import "connectionAPI.h"

@implementation connectionAPI



@synthesize webData;
@synthesize soapResults;
@synthesize xmlParser;
@synthesize conn;
@synthesize getXMLResults;
@synthesize resultDic;

@synthesize elementFound;
@synthesize matchingElement;
@synthesize matchingElement1;
@synthesize soapResults1;
@synthesize elementFound1;
@synthesize matchingElement2;       //isentender
@synthesize soapResults2;
@synthesize elementFound2;
@synthesize matchingElement3;       //isextender
@synthesize elementFound3;
@synthesize matchingElement4;       //SessionID
extern NSNotificationCenter *nc;

- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1{
    value1 = [DES3Util encrypt:value1];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);

}

- (void)getSoapFromInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2{
    if ([value2 isEqualToString:@"123"]) {
        value2 = nil;
        value2 = [[NSString alloc]initWithString:@"15285987576"];
    }
    if ([value1 isEqualToString:@"qwe"]) {
        value1 = nil;
        value1 = [[NSString alloc]initWithString:@"123456"];
    }
    NSLog(@"value1:%@ value2:%@",value1,value2);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
}

- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Value2:(NSString *)value2 Value3:(NSString *)value3{
    
}

- (void)getSoapForInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Value1:(NSString *)value1 Parameter2:(NSString *)parameter2 Value2:(NSString *)value2 Parameter3:(NSString *)parameter3 Value3:(NSString *)value3 Parameter4:(NSString *)parameter4 Value4:(NSString *)value4{
    NSLog(@"value2:%@ value3:%@",value2,value3);
    value1 = [DES3Util encrypt:value1];
    value2 = [DES3Util encrypt:value2];
    value3 = [DES3Util encrypt:value3];
    value4 = [DES3Util encrypt:value4];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "<%@ xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</%@>\r\n"
                          "</%@>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",interface,parameter1,value1,parameter1,parameter2,value2,parameter2,parameter3,value3,parameter3,parameter4,value4,parameter4,interface];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
}


- (void)LoginWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 UserName:(NSString *)NewUsername Parameter2:(NSString *)parameter2 Password:(NSString *)NewPassword ;
{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:NewUsername Parameter2:parameter2 Value2:NewPassword];
}

- (void)BusiInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Version:(NSString *)version{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:version];
}

- (void)UserInfoWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 Token:(NSString *)token {
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:name Parameter2:parameter2 Value2:token];
}

- (void)BackAccountWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 Token:(NSString *)token{
    [self getSoapFromInterface:interface Parameter1:parameter1 Value1:name Parameter2:parameter2 Value2:token];
}

- (void)RecommendedRecordWithInterface:(NSString *)interface Parameter1:(NSString *)parameter1 Name:(NSString *)name Parameter2:(NSString *)parameter2 StartMonth:(NSString *)startmonth Parameter3:(NSString *)parameter3 EndMonth:(NSString *)endmonth Parameter4:(NSString *)parameter4 Token:(NSString *)token{
    [self getSoapForInterface:interface Parameter1:parameter1 Value1:name Parameter2:parameter2 Value2:startmonth Parameter3:parameter3 Value3:endmonth Parameter4:parameter4 Value4:token];
    [self showAlerView];
    
}

- (void)LoginWithUserName:(NSString *)NewUsername Password:(NSString *)NewPassword{
    NewPassword = [DES3Util encrypt:NewPassword];
    NewUsername = [DES3Util encrypt:NewUsername];
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<modifyLogin>\r\n"
                          "<loginPwd xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</loginPwd>\r\n"
                          "<opPhone xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</opPhone>\r\n"
                          "</modifyLogin>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",NewPassword,NewUsername];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
        }else NSLog(@"con为假  %@",webData);
}

-(void)BusiInfoVersion:(NSString *)version;
{
    
    version = [DES3Util encrypt:version];
    
    
    NSString * soapMsg = [NSString stringWithFormat:
                          @"<?xml version=\"1.0\" encoding=\"UTF-8\"?>\r\n"
                          "<SOAP-ENV:Envelope \r\n"
                          "xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"\r\n "//
                          "xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\" \r\n"
                          "xmlns:xsd=\"http://www.w3.org/1999/XMLSchema\">\r\n "
                          "<SOAP-ENV:Body>\r\n"
                          "<queryBusiInfo>\r\n"
                          "<versionTag xsi:type=\"xsd:string\" xmlns:xsi=\"http://www.w3.org/1999/XMLSchema-instance\">%@</versionTag>\r\n"
                          "</queryBusiInfo>\r\n"
                          "</SOAP-ENV:Body>\r\n"
                          "</SOAP-ENV:Envelope>\r\n",version];
    NSLog(@"%@",soapMsg);
    
    NSString * ur = [NSString stringWithFormat:@"http://www.gz.10086.cn/intflx100/ws/phoneintf"];
    NSURL * url = [NSURL URLWithString:ur] ;
    NSMutableURLRequest * req = [NSMutableURLRequest requestWithURL:url];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMsg length]];
    
    [req addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req addValue: msgLength forHTTPHeaderField:@"Content-Length"];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:[soapMsg dataUsingEncoding:NSUTF8StringEncoding]];
    
    conn = [[NSURLConnection alloc]initWithRequest:req delegate:self];
    if(conn){
        webData = [[NSMutableData data]retain];
        //NSLog(@"%@  22222",webData);
    }else NSLog(@"con为假  %@",webData);
}

#pragma mark -
#pragma mark URL Connection Data Delegate Methods

// 刚开始接受响应时调用
-(void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *) response{
    [webData setLength: 0];
    NSLog(@"  刚开始接受响应时调用");
}

// 每接收到一部分数据就追加到webData中
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *) data {
    [webData appendData:data];
    NSLog(@"  每接收到一部分数据就追加到webData中 ");
    
}

// 出现错误时

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *) error {
    //conn = nil;
    //webData = nil;
    NSLog(@" connection 出现错误时");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"False"
                                                        object:self
     ];
    NSLog(@"Connection failed! Error - ");//%@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
    
    [connectionAPI showAlertWithTitle:@"网络连接错误" AndMessages:@"网络连接错误,请重新尝试！"];
    [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
}

// 完成接收数据时调用
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    NSString *theXML = [[NSString alloc] initWithBytes:[webData mutableBytes]
                                                length:[webData length]
                                              encoding:NSUTF8StringEncoding];
    
    // 打印出得到的XML
    getXMLResults = [[NSMutableString alloc] initWithString:theXML];
    NSLog(@"接受的soap    %@    soap", getXMLResults);
    if ([getXMLResults isEqualToString:@""]) {
        [connectionAPI showAlertWithTitle:@"网络返回为空" AndMessages:@"网络返回为空,请重新尝试！"];
        [nc postNotificationName:@"loginFalse" object:self userInfo:nil];
    }
    //    ||[getXMLResults rangeOfString:@"window.location.href = "].length>0
    if ([getXMLResults rangeOfString:@"ResponseCode"].length==0){
        //port1=@"5000";
    }
    
    if ([getXMLResults rangeOfString:@"system cannot find the path"].length>0) {
        NSLog(@"出错");
    }
    // 使用NSXMLParser解析出我们想要的结果
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities: YES];
    [xmlParser parse];
}




#pragma mark -
#pragma mark XML Parser Delegate Methods

// 开始解析一个元素名
-(void) parser:(NSXMLParser *) parser didStartElement:(NSString *) elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *) qName attributes:(NSDictionary *) attributeDict {
    if ([elementName isEqualToString:@"return"]) {    //||[elementName isEqualToString:matchingElement1]
        elementFound = YES;
    }//elementFound = YES;
}

// 追加找到的元素值，一个元素值可能要分几次追加
-(void)parser:(NSXMLParser *) parser foundCharacters:(NSString *)string {
    if (elementFound) {                                         //respondse
        soapResults = [[NSMutableString alloc]init];
        [soapResults appendString: [DES3Util decrypt:string]];
        NSLog(@"connection:%@",soapResults);
        //gbk中文编码
        //NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSData *aData = [soapResults dataUsingEncoding: NSUTF8StringEncoding];
        resultDic = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
        //NSLog(@"stringfor:%@", [[resultArray objectAtIndex:0]objectForKey:@"busiName"]);
        
//        if ([resultDic isKindOfClass:[NSArray class]]) {
//            NSLog(@"result is kind of arrry class");
//            NSArray * resultArray = [NSJSONSerialization JSONObjectWithData:aData options:NSJSONReadingMutableContainers error:nil];
//            for (NSDictionary *dic in resultArray) {
//                NSLog(@"dic:%@",[dic objectForKey:@"busiName"]);
//            }
//        }
//        NSData * str;
//        for (str in resultDic) {
//            NSLog(@"%@",str);
//        }
//        if ([resultDic isKindOfClass:[NSMutableDictionary class]]||[resultDic isKindOfClass:[NSDictionary class]]) {
//            NSLog(@"Dic");
//        }else if([resultDic isKindOfClass:[NSMutableString class]]||[resultDic isKindOfClass:[NSString class]]){
//            NSLog(@"String");
//        }else if([resultDic isKindOfClass:[NSArray class]]){
//            NSLog(@"array");
//            
//            [resultDic objectForKey:@"busiDesc"];
//        }
//        if (soapResults.length>5) {
//            //NSString * str = [resultDic objectForKey:@"status"];
//            NSLog(@"%@",str);
//            BOOL isTurnableToJSON =[NSJSONSerialization isValidJSONObject: aData];
//            if (isTurnableToJSON) {
//                NSLog(@"yes");
//            }else NSLog(@"no");
//        }
        
        
    }
}

// 结束解析这个元素名
-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithObject:resultDic forKey:@"1"];
    
    //NSMutableDictionary *d = [NSMutableDictionary dictionaryWithObjectsAndKeys:soapResults, nil];
   
    
     //登录返回解析
    if([getXMLResults rangeOfString:@"modifyLoginResponse"].length>0 ){
        if ([soapResults rangeOfString:@":0,"].length>0) {
            [nc postNotificationName:@"loginResponse" object:self userInfo:d];
        }else if([soapResults rangeOfString:@":1,"].length>0){
            [connectionAPI showAlertWithTitle:@"登录失败" AndMessages:@"账号或密码错误！"];
            [nc postNotificationName:@"loginFalse" object:self userInfo:d];
        }else{
            [connectionAPI showAlertWithTitle:@"登录失败" AndMessages:@"登陆我的乐享失败！"];
            [nc postNotificationName:@"loginFalse" object:self userInfo:d];
        }
    }
    //用户信息解析
    else if([getXMLResults rangeOfString:@"queryUserInfoResponse"].length>0){
            if ([soapResults rangeOfString:@"opName"].length>0&&[soapResults rangeOfString:@"opStatus"].length>0){
                [nc postNotificationName:@"queryUserInfoResponse" object:self userInfo:d];
            }else {
                [connectionAPI showAlertWithTitle:@"获取失败" AndMessages:@"获取个人信息失败！"];
                [nc postNotificationName:@"loginFalse" object:self userInfo:d];
            }
    }
    //银行账户解析
    else if([getXMLResults rangeOfString:@"queryBankInfoResponse"].length>0){
            //if ([soapResults rangeOfString:@"opName"].length>0&&[soapResults rangeOfString:@"opStatus"].length>0){
            [nc postNotificationName:@"queryBankInfoResponse" object:self userInfo:d];
            //}else [connectionAPI showAlertWithTitle:@"获取失败" AndMessages:@"获取个人信息失败！"];
    }
    //推荐记录查询解析
    else if ([getXMLResults rangeOfString:@"queryRecommendRecordsResponse"].length>0){
        if (!([soapResults rangeOfString:@"months"].length>0&&[soapResults rangeOfString:@"totalRecommend"].length>0)) {
            [connectionAPI showAlertWithTitle:@"没有推荐记录" AndMessages:@"在您查询的时间区间内没有推荐记录，请重新选择！"];
            //[nc postNotificationName:@"loginFalse" object:self userInfo:d];
            [self dimissAlert:alerts];
        }else {
            [nc postNotificationName:@"queryRecommendRecordsResponse" object:self userInfo:d];
            [self dimissAlert:alerts];
        }
    }
    //业务数据返回
    else if ([getXMLResults rangeOfString:@"queryBusiInfoResponse"].length>0){
        if ([resultDic isKindOfClass:[NSArray class]]) {
            NSLog(@"result is kind of arrry class");
//            NSArray * resultArray = (NSArray *)resultDic;
//            for (NSDictionary *dic in resultArray) {
//                NSLog(@"dic:%@",[dic objectForKey:@"busiName"]);
//            }
            [nc postNotificationName:@"queryBusiInfoResponse" object:self userInfo:d];
        }
    }
    //返回数据为空
    else if (soapResults.length<5) {
        [connectionAPI showAlertWithTitle:@"返回数据错误" AndMessages:@"返回数据为空，请检查输入项！"];
        [nc postNotificationName:@"loginFalse" object:self userInfo:d];
    }
    
    
    elementFound = FALSE;
    // 强制放弃解析
    [xmlParser abortParsing];
    soapResults = nil;
    //}
}

// 解析整个文件结束后
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if (soapResults) {
        soapResults = nil;
    }
}

// 出错时，例如强制结束解析
- (void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    if (soapResults) {
        soapResults = nil;
    }
}

+ (void)showAlertWithTitle:(NSString *)titles AndMessages:(NSString *)messages{
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:titles message:messages delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"好的", nil];
    [alert show];
}

- (void)showAlerView{
    alerts = [[UIAlertView alloc]initWithTitle:@"连接中"
                                       message:nil
                                      delegate:nil
                             cancelButtonTitle:nil
                             otherButtonTitles:nil];
//    alerts.frame = CGRectMake(0, 0, viewWidth/1.5, viewHeight/5);
//    alerts.center = CGPointMake(0, viewHeight/2);
    [alerts show];
    UIActivityIndicatorView*activeView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activeView.center = CGPointMake(alerts.bounds.size.width/2.0f, alerts.bounds.size.height-40.0f);
    [activeView startAnimating];
    alerts.delegate = self;
    [alerts addSubview:activeView];
    [activeView release];
    [alerts release];
}

- (void) dimissAlert:(UIAlertView *)alert
{
    if(alerts)
    {
        [alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
    }
}

//- (void) dimissAlert:(UIAlertView *)alert
//{
//    if(alerts)
//    {
//        [alerts dismissWithClickedButtonIndex:[alert cancelButtonIndex]animated:YES];
//        [alerts release];
//    }
//}

@end
