package com.oracle.jmAuto.dto;

import lombok.Data;

@Data
public class KakaoPayApproveResponse {
	private String 	aid;				//결제승인번호
    private String 	tid;				//결제고유번호
    private String 	cid;				//매장고유번호
    private String 	sid;				//정기결제번호
    private String 	partner_order_id;	//매물번호
    private String 	partner_user_id;	//판매자ID
    private String 	payment_method_type;//결제수단
   
    private String 	item_name;			//상품이름
    private String 	item_code;			//상품코드
    private Integer quantity;			//상품수량
    private String 	created_at;			//결제요청시간
    private String 	approved_at;		//결제승인시간

    private Amount 	amount;				//결제금액정보
}
