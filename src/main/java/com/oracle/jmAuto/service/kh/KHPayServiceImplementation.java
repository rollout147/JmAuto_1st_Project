package com.oracle.jmAuto.service.kh;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.view.RedirectView;

import com.oracle.jmAuto.dao.kh.KHTableDao;
import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.KaKaoPayCancelResponse;
import com.oracle.jmAuto.dto.KakaoPayApproveResponse;
import com.oracle.jmAuto.dto.KakaoPayReadyResponse;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.SessionUtils;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class KHPayServiceImplementation implements KHPayService {

	private KakaoPayReadyResponse readyResponse;
	private final KHTableDao khTableDao;
	private final MailSender mailSender;

	@Override
	public KakaoPayReadyResponse kakaoPayReadyCar(long sell_num) {

		Map<String, Object> payParams = new HashMap<>();
		Car_General_Info carDetail = khTableDao.getCarBySellId(sell_num);

		payParams.put("cid", "TC0ONETIME"); // 테스트 결제는 가맹점 코드로 'TC0ONETIME'를 사용
		payParams.put("partner_order_id", carDetail.getSell_num());
		payParams.put("partner_user_id", carDetail.getUser_id());
		payParams.put("item_name", carDetail.getModel());
		payParams.put("quantity", "1");
		payParams.put("total_amount", (carDetail.getPrice()) * 10000 * 1.17 + 50000);
		payParams.put("tax_free_amount", "0");
		payParams.put("approval_url", "http://localhost:8888/KH/pay/completed"); // 결제 성공시 넘어갈 url
		payParams.put("cancel_url", "http://localhost:8888/KH/pay/cancel"); // 결제 취소시 넘어갈 url
		payParams.put("fail_url", "http://localhost:8888/KH/pay/fail"); // 결제 실패시 넘어갈 url
		payParams.put("payment_method_type", "CARD");
		payParams.put("install_month", "0");

		SessionUtils.addAttribute("partner_order_id", carDetail.getSell_num());
		SessionUtils.addAttribute("partner_user_id", carDetail.getUser_id());

		HttpEntity<Map> requestEntity = new HttpEntity<>(payParams, this.getHeaders());
		// HttpEntity 전송객체를 형식에 맞체 생성해 주는 객체

		RestTemplate template = new RestTemplate();
		// Spring 에서 지원하는 객체로 간편하게 Rest 방식 API를 호출할 수 있는 Spring 내장 클래스
		// Spring 3.0부터 지원.
		// json, xml 모두 응답 가능
		// Rest API 서비스를 요청 후 응답 받을 수 있도록 설계
		// HTTP 프로토콜의 메소드(GET, POST, DELETE, PUT)들에 적합한 여러 메소드들을 제공

		String url = "https://open-api.kakaopay.com/online/v1/payment/ready";

		// RestTemplate template 객체를 사용하여, POST 방식으로 전송, 객체를 전달받음
		readyResponse = template.postForObject(	url, 
												requestEntity, 
												KakaoPayReadyResponse.class);

		System.out.println("readyResponse -> " + readyResponse);		

		return readyResponse;
	}

	@Override
	@Transactional
	public KakaoPayApproveResponse kakaoPayApprove(String tid, String pgToken, String partner_order_id,
			String partner_user_id) {
		Map<String, Object> payParams = new HashMap<>();

		payParams.put("cid", "TC0ONETIME"); // 테스트 결제는 가맹점 코드로 'TC0ONETIME'를 사용
		payParams.put("tid", tid);
		payParams.put("partner_order_id", partner_order_id);
		payParams.put("partner_user_id", partner_user_id);
		payParams.put("pg_token", pgToken);

		HttpEntity<Map> requestEntity = new HttpEntity<>(payParams, this.getHeaders());
		RestTemplate template = new RestTemplate();
		String url = "https://open-api.kakaopay.com/online/v1/payment/approve";

		KakaoPayApproveResponse approveResponse = 
				template.postForObject(	url, 
										requestEntity,
										KakaoPayApproveResponse.class);

		return approveResponse;
	}

	private HttpHeaders getHeaders() {
		HttpHeaders headers = new HttpHeaders();

		headers.set("Authorization", "SECRET_KEY DEVB919FE376B5B008D6CD42D7A9D0D8D990EEDA");
		headers.set("Content-type", "application/json");
		return headers;
	}
	

	@Override
	public KaKaoPayCancelResponse refundPayment(String tid) {
		Payment targetPayment = khTableDao.getPaymentByTid(tid);
		System.out.println("KHServiceImplementation refundPayment() targetPayment -> " + targetPayment);
				
		Map<String, String> cancelParams = new HashMap<>();
		String cancel_amount = Long.toString(targetPayment.getTotal_price());
		
		System.out.println("KHServiceImplementation refundPayment() cancel_amount -> " + cancel_amount);

		cancelParams.put("cid", "TC0ONETIME");
		cancelParams.put("tid", tid);
		cancelParams.put("cancel_amount", cancel_amount);
		cancelParams.put("cancel_tax_free_amount", "0");
		cancelParams.put("cancel_vat_amount", "0");

		HttpEntity<Map> requestEntity = new HttpEntity<>(cancelParams, this.getHeaders());
		RestTemplate template = new RestTemplate();
		String url = "https://open-api.kakaopay.com/online/v1/payment/cancel";

		KaKaoPayCancelResponse cancelResponse = template.postForObject(
												url, 
												requestEntity,
												KaKaoPayCancelResponse.class);
		
		khTableDao.updateRefundPayment(tid);

		return cancelResponse;
	}

	@Override
	public KakaoPayReadyResponse kakaoPayReadyExpert(long expert_review_num) {
		Map<String, Object> payParams = new HashMap<>();
		
		Expert_Review expertReviewDetail = khTableDao.getExpertReviewDetail(expert_review_num);
		Car_General_Info carDetail		 = khTableDao.getCarBySellId(expertReviewDetail.getSell_num());	

		payParams.put("cid", "TC0ONETIME"); // 테스트 결제는 가맹점 코드로 'TC0ONETIME'를 사용
		payParams.put("partner_order_id", expertReviewDetail.getExpert_review_num());
		payParams.put("partner_user_id", expertReviewDetail.getUser_id());
		payParams.put("item_name", "전문가 리뷰 " + carDetail.getCar_num());
		payParams.put("quantity", "1");
		payParams.put("total_amount", "5500");
		payParams.put("tax_free_amount", "0");
		payParams.put("approval_url", "http://localhost:8888/KH/pay/completed"); 	// 결제 성공시 넘어갈 url
		payParams.put("cancel_url", "http://localhost:8888/KH/pay/cancel"); 				// 결제 취소시 넘어갈 url
		payParams.put("fail_url", "http://localhost:8888/KH/pay/fail"); 					// 결제 실패시 넘어갈 url
		payParams.put("payment_method_type", "CARD");
		payParams.put("install_month", "0");

		SessionUtils.addAttribute("partner_order_id", expertReviewDetail.getExpert_review_num());
		SessionUtils.addAttribute("partner_user_id", expertReviewDetail.getUser_id());

		HttpEntity<Map> requestEntity = new HttpEntity<>(payParams, this.getHeaders());
		// HttpEntity 전송객체를 형식에 맞체 생성해 주는 객체

		RestTemplate template = new RestTemplate();
		// Spring 에서 지원하는 객체로 간편하게 Rest 방식 API를 호출할 수 있는 Spring 내장 클래스
		// Spring 3.0부터 지원.
		// json, xml 모두 응답 가능
		// Rest API 서비스를 요청 후 응답 받을 수 있도록 설계
		// HTTP 프로토콜의 메소드(GET, POST, DELETE, PUT)들에 적합한 여러 메소드들을 제공

		String url = "https://open-api.kakaopay.com/online/v1/payment/ready";

		// RestTemplate template 객체를 사용하여, POST 방식으로 전송, 객체를 전달받음
		readyResponse = template.postForObject(	url, 
												requestEntity, 
												KakaoPayReadyResponse.class);

		System.out.println("readyResponse -> " + readyResponse);

		return readyResponse;
	}

	@Override
	public String sendRefundPassword(String tid) {
		SimpleMailMessage msg = new SimpleMailMessage();
		String mailAddress	  =	"milkmilyto@naver.com";
		String refundPassword = khTableDao.getRefundPassword(tid);
		String mailStr		  = "환불비밀번호는 " + refundPassword + "입니다";
		
		// 받는 사람 이메일
		msg.setTo(mailAddress);
		
		// 이메일 제목
        msg.setSubject("jmAuto에서 발송하는 환불비밀번호입니다");
        
        // 이메일 내용
        msg.setText(mailStr);
        
        try {
            // 메일 보내기
            this.mailSender.send(msg);
            System.out.println("KHPayServiceImplementation sendRefundPassword is completed!");
        } catch (MailException e) {
            throw e;
        }
        
        return refundPassword;
	}

}
