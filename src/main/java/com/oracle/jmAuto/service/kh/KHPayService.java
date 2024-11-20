package com.oracle.jmAuto.service.kh;

import com.oracle.jmAuto.dto.KaKaoPayCancelResponse;
import com.oracle.jmAuto.dto.KakaoPayApproveResponse;
import com.oracle.jmAuto.dto.KakaoPayReadyResponse;

public interface KHPayService {
	public KakaoPayReadyResponse 	kakaoPayReadyCar(long sell_num);
	public KakaoPayApproveResponse 	kakaoPayApprove(String tid, String pgToken, String partner_order_id, String partner_user_id);
	public KaKaoPayCancelResponse 	refundPayment(String tid);
	public KakaoPayReadyResponse 	kakaoPayReadyExpert(long expert_review_num);
	public String 					sendRefundPassword(String mailArrdess);		
}
