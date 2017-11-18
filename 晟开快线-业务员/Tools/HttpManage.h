//
//  HttpManage.h
//  晟开快线(业务员版)
//
//  Created by 胡隆海 on 17/1/9.
//  Copyright © 2017年 胡隆海. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpManage : NSObject

+(id)shareInstance;

// 当前版本
-(void)postVersionWithParmaeters:(NSMutableDictionary*)dic              Success:(void(^)(NSMutableDictionary * dic))block;
// 注册
-(void)postRegisterwithParmaeters:(NSMutableDictionary*)dic             Success:(void(^)(NSMutableDictionary *dic))block;
// 登录
-(void)postLoginWithParmaeters:(NSMutableDictionary*)dic                Success:(void(^)(NSMutableDictionary *dic))block;
// 根据电话号码或者用户公司名查询用户信息
- (void)getUserMessageWithParmarters:(NSMutableDictionary*)dic          Success:(void(^)(NSMutableDictionary *dic))block;
// 删除联系人
- (void)getDeleteMessageWithParmarters:(NSMutableDictionary*)dic        Success:(void(^)(NSMutableDictionary *dic))block;
// 根据订单号请求订单
- (void)getOrderMessageWithParmarters:(NSMutableDictionary*)dic         Success:(void(^)(NSMutableDictionary *dic))block;
// 修改订单状态
- (void)getChangeOrderStateWithParmarters:(NSMutableDictionary*)dic     Success:(void(^)(NSMutableDictionary *dic))block;
// 收账
- (void)getChangeOrderCollectWithParmarters:(NSMutableDictionary*)dic   Success:(void(^)(NSMutableDictionary *dic))block;
//根据始发地和状态来查询
- (void)getStartLocationWithParmarters:(NSMutableDictionary*)dic        Success:(void(^)(NSMutableDictionary *dic))block;
//根据目的地和状态来查询
- (void)getEndLocationWithParmarters:(NSMutableDictionary*)dic          Success:(void(^)(NSMutableDictionary *dic))block;
//根据业务员ID和状态（状态为1，请求的已收款）请求订单
- (void)getSalesmanOrdersWithParmarters:(NSMutableDictionary*)dic       Success:(void(^)(NSMutableDictionary *dic))block;
//交账
- (void)getAccountOrdersWithParmarters:(NSMutableDictionary*)dic        Success:(void(^)(NSMutableDictionary *dic))block;
//总账
- (void)getAllTotalMoneyParmarters:(NSMutableDictionary*)dic            Success:(void(^)(NSMutableDictionary *dic))block;
//总账里面最后提交
- (void)getSubmitAllOrdersParmarters:(NSMutableDictionary*)dic          Success:(void(^)(NSMutableDictionary *dic))block;
// 财务里面我的现付
- (void)getMyNowPayOrdersParmarters:(NSMutableDictionary*)dic           Success:(void(^)(NSMutableDictionary *dic))block;
//订单作废
- (void)getInvalidAParmarters:(NSMutableDictionary*)dic                 Success:(void(^)(NSMutableDictionary *dic))block;
// 总账个人已完成订单
- (void)getUserFinishOrdersWithParmarters:(NSMutableDictionary*)dic     Success:(void(^)(NSMutableDictionary *dic))block;
//到达城市
- (void)getEndCityWithParmarters:(NSMutableDictionary*)dic              Success:(void(^)(NSMutableDictionary *dic))block;
// 下单
-(void)getPlaceOrderWithParmaters:(NSMutableDictionary*)dic             Success:(void(^)(NSMutableDictionary *dic))black;
//搜索订单
- (void)getSearchOrderParmarters:(NSMutableDictionary*)dic              Success:(void(^)(NSMutableDictionary *dic))block;
// 根据userid请求该用户订单
-(void)getUserOrderWithParmaters:(NSMutableDictionary*)dic              Success:(void(^)(NSMutableDictionary *dic))block;
//请求用户下单的订单
- (void)getGetClientWayBillsParmarters:(NSMutableDictionary*)dic        Success:(void(^)(NSMutableDictionary *dic))block;
//业务员接单
- (void)getPlaceUserOrderParmarters:(NSMutableDictionary*)dic           Success:(void(^)(NSMutableDictionary *dic))block;
//业务员代提单子
- (void)getReceivebleClientWaybillsParmarters:(NSMutableDictionary*)dic Success:(void(^)(NSMutableDictionary *dic))block;
//提货
- (void)getPickUpGoodsParmarters:(NSMutableDictionary*)dic              Success:(void(^)(NSMutableDictionary *dic))block;
//获取推送条数
- (void)getApnsNumberParmarters:(NSMutableDictionary*)dic               Success:(void(^)(NSMutableDictionary *dic))block;
//清空推送条数
- (void)getZeroApnsNumberParmarters:(NSMutableDictionary*)dic           Success:(void(^)(NSMutableDictionary *dic))block;
//获取需要审核的订单
- (void)getInvalidWayBillsParmarters:(NSMutableDictionary*)dic          Success:(void(^)(NSMutableDictionary *dic))block;
//通过审核
- (void)getInvalidWayBillParmarters:(NSMutableDictionary*)dic           Success:(void(^)(NSMutableDictionary *dic))block;
//不通过审核
- (void)getNotInvalidWayBillParmarters:(NSMutableDictionary*)dic        Success:(void(^)(NSMutableDictionary *dic))block;
@end
