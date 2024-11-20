package com.oracle.jmAuto.controller;

//import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

//import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;
// import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;

import com.oracle.jmAuto.dto.KaKaoPayCancelResponse;
import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.ExpList;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.KakaoPayApproveResponse;
import com.oracle.jmAuto.dto.KakaoPayReadyResponse;
import com.oracle.jmAuto.dto.PayList;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Seller_Info;
import com.oracle.jmAuto.dto.SessionUtils;
import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.service.kh.KHPayService;
import com.oracle.jmAuto.service.kh.KHTableService;
import com.oracle.jmAuto.service.kh.Paging;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Controller
@RequestMapping("/KH/pay")
public class KhController {

	private final KHPayService payService;
	private final KHTableService khTableService;
	// private final BCryptPasswordEncoder passwordEncoder; 

	@Value("${spring.file.upload.path}")
	private String uploadPath;

	// 차량구매 관련 정보입력 페이지로 이동
	@GetMapping(value = "/goPay")
	public String goCarPay(long sell_num, Model model) {
		
		log.info("KhController goCarPay is called");
		String user_id 				= SessionUtils.getStringAttributeValue("user_id");
		if(user_id != "null") {
			User_Table buyer 	= khTableService.getUserById(user_id);
			SessionUtils.addAttribute("buyer_id", user_id);
			model.addAttribute("buyer", buyer);
			System.out.println("KhController goCarPay if loop is started");
		} else {			
			model.addAttribute("loginError", "먼저 로그인 해주세요");
			System.out.println("KhController goCarPay user_id -> " + SessionUtils.getStringAttributeValue("user_id").isEmpty());
						
			return "redirect:/view_jm/login";			// 로그인 페이지로 리다이렉트
		}

		// 구매자 아이디 받아옴

		Car_General_Info carDetail 	= khTableService.getCarBySellId(sell_num);
		User_Table seller 			= khTableService.getUserById(carDetail.getUser_id());
		long rawPrice 				= carDetail.getPrice() * 10000;
		String imageName			= khTableService.getImageName(sell_num);
		String carImagePath			= "../.." + imageName;

		System.out.println("KhController goCarPay carDetail -> " + carDetail);
		
		SessionUtils.addAttribute("carImagePath", carImagePath);
		SessionUtils.addAttribute("rawPrice", rawPrice);
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("seller", seller);
		

		return "view_kh/carPayment";
	}

	// 차량구매 관련 카카오 페이지로 이동
	@PostMapping(value = "/readyPay")
	public @ResponseBody RedirectView kakaoPayReadyCar(@RequestParam("insureFile") MultipartFile multipartFile,
			Payment payment) {
		log.info("sell_num: " + payment.getSell_num());

		String uuid = UUID.randomUUID().toString();
		String originalFileName = multipartFile.getOriginalFilename();
		
		System.out.println("originalFileName -> " + originalFileName );
		
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		String savePath = uploadPath + "insuranceFile/" + uuid + extension;

		if (!multipartFile.isEmpty()) {
			try {
				multipartFile.transferTo(new File(savePath));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}

		payment.setInsure_img_name(uuid + extension);
		payment.setInsure_img_url(savePath);

		KakaoPayReadyResponse readyResponse = payService.kakaoPayReadyCar(payment.getSell_num());
		// kakaoPay 요청양식에 따라 요청객체 만들어 보내는 메서드(service)

		log.info(readyResponse.toString());

		// kakaoPay가 준비요청 후 보내준 정보 확인

		SessionUtils.addAttribute("tid", readyResponse.getTid());
		SessionUtils.addAttribute("readyPayment", payment);
		System.out.println("KhController RedirectView kakaoPayReadyCar payment -> " + payment);

		RedirectView redirectView = new RedirectView();
		redirectView.setUrl(readyResponse.getNext_redirect_pc_url());

		return redirectView;

	}
	
	@GetMapping(value = "/carCheck")
	public String goCarCheck() {
		log.info("KhController goCarCheck is called");

		return "view_kh/carCheck";
	}
	
	@GetMapping(value = "/carRegistration")
	public String goCarRegistration() {
		log.info("KhController goCarRegistration is called");

		return "view_kh/carRegistration";
	}
	
	@GetMapping(value = "/contract")
	public String goContract(long sell_num, String user_id, Model model) {
		log.info("KhController goContract is called");
		
		Car_General_Info carDetail  = khTableService.getCarBySellId(sell_num);
		User_Table buyer			= khTableService.getUserById(user_id);
		Seller_Info sellerInfo		= khTableService.getSellerInfoById(carDetail.getUser_id());
		
		Date today					= new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		sellerInfo.setContract_date(dateFormat.format(today));
		
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("buyer", buyer);
		model.addAttribute("sellerInfo", sellerInfo);
		model.addAttribute("carType", SessionUtils.getStringAttributeValue("carType"));
		return "view_kh/contract";
	}
	
	
	@PostMapping(value = "/contractImage")
	public void saveContractImage(ModelMap modelMap, HttpServletRequest request, HttpServletResponse response, String sell_num) {
		log.info("KhController saveContractImage is called");
		FileOutputStream outStream	= null;
		String fileName				= sell_num + "_contract";
		String savePath 			= uploadPath + "contract/";
		
		try {
			String imgData 			= request.getParameter("imgData");
			// 디코딩을 위해서 string data의 "data:image/png;base64," 제거
			imgData					= imgData.replaceAll("data:image/png;base64,", "");
			
			byte[] file				= Base64.getDecoder().decode(imgData);
			outStream				= new FileOutputStream(savePath + fileName + ".png");
			
			outStream.write(file);
			outStream.close();
			
			System.out.println("KhController saveContractImage is completed");
			
			/*	IOUtils.copy를 이용하여 download 폴더에 바로 저장
			ByteArrayInputStream is	= new ByteArrayInputStream(file);
			response.setContentType("image/png");
			response.setHeader("Content-Disposition", "attachment; filename=report.png");
			
			System.out.println("response.getOutputStream() -> " + response.getOutputStream().toString());
			
			IOUtils.copy(is, response.getOutputStream());
			response.flushBuffer();
			*/
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	
	
	
	@GetMapping(value = "/privateInformation")
	public String goPrivateInformation() {
		log.info("KhController goPrivateInformation is called");

		return "view_kh/privateInformation";
	}	

	// 전분가리뷰 구매정보 확인 페이지로 이동
	@GetMapping(value = "/goExpertPay")
	public String goExpertPay(long expert_review_num, Model model) {
		// 전문가리뷰번호와 구매자 아이디는 반드시 받아와야 함!!! Get Method

		log.info("KhController goExpertPay is called");

		String user_id = SessionUtils.getStringAttributeValue("user_id");
		
		System.out.println("KhController goExpertPay user_id -> " + user_id);
		
		if(user_id != "null") {
			User_Table buyer 	= khTableService.getUserById(user_id);
			SessionUtils.addAttribute("buyer_id", user_id);
			model.addAttribute("buyer", buyer);
			System.out.println("KhController goCarPay if loop is started");
		} else {			
			model.addAttribute("loginError", "먼저 로그인 해주세요");
			System.out.println("KhController goCarPay user_id -> " + SessionUtils.getStringAttributeValue("user_id").isEmpty());
						
			return "view_jm/login";			// 로그인 페이지로 리다이렉트
		}

		Expert_Review expertReviewDetail = khTableService.getExpertReviewDetail(expert_review_num);
		Car_General_Info carDetail = khTableService.getCarBySellId(expertReviewDetail.getSell_num());
		User_Table buyer = khTableService.getUserById(user_id);
		User_Table seller = khTableService.getUserById(expertReviewDetail.getUser_id());

		model.addAttribute("expertReviewDetail", expertReviewDetail);
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("buyer", buyer);
		model.addAttribute("seller", seller);

		return "view_kh/expertPayment";
	}

	// 전분가리뷰 구매 카카오 페이지로 이동
	@PostMapping(value = "/readyExpertPay")
	public @ResponseBody RedirectView kakaoPayReadyExpert(Payment payment) {
		log.info("expert_review_num: " + payment.getExpert_review_num());

		KakaoPayReadyResponse readyResponse = payService.kakaoPayReadyExpert(payment.getExpert_review_num());
		// kakaoPay 요청양식에 따라 요청객체 만들어 보내는 메서드(service)

		log.info(readyResponse.toString());
		// kakaoPay가 준비요청 후 보내준 정보 확인

		SessionUtils.addAttribute("tid", readyResponse.getTid());
		SessionUtils.addAttribute("readyPayment", payment);

		RedirectView redirectView = new RedirectView();
		redirectView.setUrl(readyResponse.getNext_redirect_pc_url());

		return redirectView;
	}

	@GetMapping(value = "/consumerProtection")
	public String goconsumerProtection() {
		log.info("KhController goconsumerProtection is called");

		return "view_kh/consumerProtection";
	}

	// 차량구매 완료 페이지
	// DB payment table insert
	@GetMapping("/completed")
	public String kakaoPayApprove(@RequestParam("pg_token") String pgToken, Model model) {
		// pgToken : 결제 요청을 하기위한 인증 토큰이며, 결제인증 API 호출 시에 넣어줘야 하는 값
		// 자동으로 생성되어 전달받음

		String tid 					= SessionUtils.getStringAttributeValue("tid");
		String partner_order_id 	= SessionUtils.getStringAttributeValue("partner_order_id");
		String partner_user_id 		= SessionUtils.getStringAttributeValue("partner_user_id");
		Payment readyPayment 		= (Payment) SessionUtils.getAttribute("readyPayment");
		
		// UUID를 이용하여 10자리 환불비밀번호 생성
		String uuid 			= UUID.randomUUID().toString();
		uuid 					= uuid.replaceAll("-", "");
		uuid					= uuid.substring(0, 10);
		
		KakaoPayApproveResponse approveResponse = payService.kakaoPayApprove(tid, pgToken, partner_order_id,
				partner_user_id);
		// kakaoPay 요청양식에 따라 요청객체 만들어 보내는 메서드(service)

		System.out.println("KhController kakaoPayApprove approveResponse -> " + approveResponse);

		long price;
		long tax;
		long fee;
		long total_price;
		long buz_fee;
		long buz_money;

		User_Table buyer = khTableService.getUserById(SessionUtils.getStringAttributeValue("buyer_id"));
		Payment payment = new Payment();

		if (readyPayment.getBuy_type() == 2) {
			price = 5000;
			tax = 500;
			fee = 0;
			total_price = price + tax;
			buz_fee = 500;
			buz_money = price - buz_fee;
			payment.setExpert_review_num(readyPayment.getExpert_review_num());
			System.out.println("KhController kakaoPayApprove if(readyPayment.getBuy_type() == 2) is TRUE");

		} else {
			price = Long.parseLong(SessionUtils.getStringAttributeValue("rawPrice"));
			tax = (long) (price * 0.17);
			fee = 50000;
			total_price = price + tax;
			buz_fee = (long) (price * 0.3);
			buz_money = price - buz_fee;
			payment.setSell_num(readyPayment.getSell_num());
		}

		payment.setUser_id(buyer.getUser_id());
		payment.setApproval_num(approveResponse.getTid());
		payment.setPrice(price);
		payment.setTax(tax);
		payment.setFee(fee);
		payment.setTotal_price(total_price);
		payment.setBuz_fee(buz_fee);
		payment.setBuz_money(buz_money);
		payment.setReceiver_name(buyer.getUser_name());
		payment.setReceiver_tel(buyer.getUser_tel());
		payment.setReceiver_zipcode(buyer.getUser_zipcode());
		payment.setReceiver_addr1(buyer.getUser_addr1());
		payment.setReceiver_addr2(buyer.getUser_addr2());
		payment.setInsure_img_name(readyPayment.getInsure_img_name());
		payment.setInsure_img_url(readyPayment.getInsure_img_url());
		payment.setDelivery_date(readyPayment.getDelivery_date());
		payment.setBuy_type(readyPayment.getBuy_type());
		payment.setDel_state(0);
		payment.setRefund_password(uuid);

		khTableService.insertPayment(payment);
		khTableService.updateCarDelState(payment.getSell_num());
		
		Car_General_Info carDetail 	= khTableService.getCarBySellId(payment.getSell_num());

		model.addAttribute("approveResponse", approveResponse);
		model.addAttribute("buyer", buyer);
		model.addAttribute("payment", payment);
		model.addAttribute("carDetail", carDetail);

		if (readyPayment.getBuy_type() == 1) {
			return "view_kh/complete"; 				// 결제 승인 후 redirect 페이지(구매내역 페이지로 이동)
		} else {
			return "redirect:/KH/pay/expertReviewPage?expert_review_num=" + payment.getExpert_review_num();
		}

	}

	// 개별 구매정보 불러오기
	@GetMapping(value = "/paymentDetail")
	public String getPaymentlDetail(Payment payment, Model model) {
		log.info("KhController getPaymentlDetail is called");

		System.out.println("KhController getPaymentlDetail payment.getSell_num() -> " + payment.getSell_num());
		Payment paymentDetail = khTableService.getPaymentBySellId(payment.getSell_num());

		model.addAttribute("paymentDetail", paymentDetail);
		System.out.println("KhController getPaymentlDetail paymentDetail -> " + paymentDetail);

		return "view_kh/refund";
	}

	//결제취소 페이지 -> 미사용
	@GetMapping(value = "/cancel")
	public String cancel() {
		log.info("KhController refundPayment is called");

		return "cancel";
	}
	

	// 차랑구매 관련 정보입력페이지 차량기본정보 팝업
	@GetMapping(value = "/carBasicInfo")
	public String getCarBasicInfo(long sell_num, Model model) {
		log.info("KhController getCarBasicInfo is called");

		Car_General_Info carDetail = khTableService.getCarBySellId(sell_num);
		model.addAttribute("carDetail", carDetail);

		return "view_kh/carBasicInfo";
	}
	


	// 전문가리뷰페이지 호출
	// 구매여부를 판단하여 구매했으면 페이지를 노출
	// 비구매 시, 전문가리뷰 결제버튼 노출
	@GetMapping(value = "/expertReviewPage")
	public String goExpertReviewPage(long expert_review_num, Model model) {
		log.info("KhController goExpertReviewPage is called");

		String user_id 					 = SessionUtils.getStringAttributeValue("user_id");
		
		if(user_id.length() < 5) {
			model.addAttribute("loginError", "먼저 로그인 해주세요");
			System.out.println("KhController goCarPay user_id -> " + SessionUtils.getStringAttributeValue("user_id").isEmpty());
			return "view_kh/loginClose";			// 로그인 페이지로 리다이렉트
		}
		
		int result 						 = khTableService.getPurchaseExpert(user_id, expert_review_num);
		Expert_Review expertReviewDetail = khTableService.getExpertReviewDetail(expert_review_num);
		Car_General_Info carDetail		 = khTableService.getCarBySellId(expertReviewDetail.getSell_num());
		User_Table expert 				 = khTableService.getUserById(expertReviewDetail.getUser_id());
		
		model.addAttribute("result", result);
		model.addAttribute("experReviewDetail", expertReviewDetail);
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("expert", expert);
		
		System.out.println("KhController goExpertReviewPage result -> " + result);

		return "view_kh/expertReview";
	}
	
	
	//전문가 리뷰 작성 및 수정
	@GetMapping(value = "/createExpertReview")
	public String createExpertReview(@RequestParam("sell_num")long sell_num, Model model) {
		log.info("KhController createExpertReview is called");

		String user_id 					 = SessionUtils.getStringAttributeValue("user_id");
		Car_General_Info carDetail		 = khTableService.getCarBySellId(sell_num);
		User_Table expert 				 = khTableService.getUserById(user_id);
		
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("expert", expert);
		
		return "view_kh/createExpertReview";
	}
	
	
	//전문가리뷰 입력
	@PostMapping(value = "/insertExpertReview")
	public String insertExpertReview(Expert_Review expertReview) {
		log.info("KhController insertExpertReview is called");
		System.out.println("KhController insertExpertReview expertReview -> " + expertReview);
		
		khTableService.insertExpertReview(expertReview);
		
		return "redirect:/view_ms/myPage_P";
	}
	
	@PostMapping(value = "/previewExpertReview")
	public String previewExpertReview(Expert_Review expertReview, Model model) {
		
		Car_General_Info carDetail		= khTableService.getCarBySellId(expertReview.getSell_num());
		User_Table expert 				= khTableService.getUserById(expertReview.getUser_id());
		
		model.addAttribute("experReviewDetail", expertReview);
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("expert", expert);
		
		return "view_kh/previewExpertReview";
	}
	
	
	//전문가리뷰 수정
	@GetMapping(value = "/modifyExpertReview")
	public String modifyExpertReview(Expert_Review expertReview, Model model) {
		log.info("KhController modifyExpertReview is called");
		Expert_Review newExpertReview	= khTableService.getExpertReviewDetail(expertReview.getExpert_review_num());
		
		

		Car_General_Info carDetail		= khTableService.getCarBySellId(newExpertReview.getSell_num());
		User_Table expert 				= khTableService.getUserById(newExpertReview.getUser_id());
		
		model.addAttribute("experReviewDetail", newExpertReview);
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("expert", expert);
		
		return "view_kh/modifyExpertReview";
	}

		
	//전문가리뷰 수정입력
	@PostMapping(value = "/updateExpertReview")
	public String updateExpertReview(Expert_Review expertReview) {
		log.info("KhController insertExpertReview is called");
		System.out.println("KhController insertExpertReview expertReview -> " + expertReview);
		
		khTableService.updateExpertReview(expertReview);
		
		return "redirect:/view_ms/myExpertReview";	
	}	
	
	
	
	//adminFunction
	// 관리자 환불관련 페이지
	
	@GetMapping(value = "/admin") 
	public String adminMenu(Model model) {
		log.info("KhController adminPaymentSearch is called");
		String admin_id = "admin1";	
		model.addAttribute("admin_id", admin_id);
		
		return "view_kh/manager_menu";
	}
	
	
	@GetMapping(value = "/expertReviewListCon") 
	public String expertReviewListCon(ExpList expList, Model model) {
		log.info("KhController expertReviewListCon is called");
		
		String rawKeyword 			= expList.getKeyword();		
		if(rawKeyword != null && rawKeyword.length()==0) { 
			System.out.println("KhController getPaymentList rawKeyword is 0 -> " + rawKeyword );
			expList.setKeyword(null);
			expList.setSearch(null); 
		}
		
		List<ExpList> exReviewList = new ArrayList<>();
		User_Table buyer 			= khTableService.getUserById(expList.getUser_id());
		int totExpertReview			= khTableService.getTotExpertReview(expList);
		
		Paging paging = new Paging(totExpertReview, expList.getCurrentPage());

		expList.setStart(paging.getStart());
		expList.setEnd(paging.getEnd());
		
		exReviewList 				= khTableService.getReviewListCon(expList);
		
		model.addAttribute("originalExpList", expList);
		model.addAttribute("exReviewList", exReviewList);
		model.addAttribute("admin_id", expList.getAdmin_id());
		model.addAttribute("user_id", expList.getUser_id());
		model.addAttribute("buyer", buyer);
		model.addAttribute("page", paging);
		model.addAttribute("currentPage", expList.getCurrentPage());
		
		return "view_kh/adminReviewList";
	}

	
	// 사용자 구매리스트
	@GetMapping(value = "/paymentListCon") 
	public String getPaymentListCon(PayList payList, Model model) {
		log.info("KhController getPaymentList is called");
		System.out.println("KhController getPaymentList payList -> " + payList);
		
		String rawKeyword 				= payList.getKeyword();		
		if(rawKeyword != null && rawKeyword.length()==0) { 
			System.out.println("KhController getPaymentList rawKeyword is 0 -> " + rawKeyword );
			payList.setKeyword(null);
			payList.setSearch(null); 
		}
		
		List<PayList> paymentList 		= new ArrayList<>();
		String sendRefundPasswordResult = null;
		User_Table buyer 				= khTableService.getUserById(payList.getUser_id());
		int totPayment					= khTableService.getTotPaymentByCon(payList);
		
		
		
		if(SessionUtils.getStringAttributeValue("sendRefundPasswordResult") != null) {
			sendRefundPasswordResult = SessionUtils.getStringAttributeValue("sendRefundPasswordResult");
			System.out.println("KhController getPaymentList sendRefundPasswordResult -> " + sendRefundPasswordResult);
		}		
		
		Paging paging = new Paging(totPayment, payList.getCurrentPage());
		
		System.out.println("KhController getPaymentList paging -> " + paging);
		payList.setStart(paging.getStart());
		payList.setEnd(paging.getEnd());
		
		paymentList 					= khTableService.getPayListCon(payList);
		
		model.addAttribute("originalPaymentList", payList);
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("admin_id", payList.getAdmin_id());
		model.addAttribute("user_id", payList.getUser_id());
		model.addAttribute("buyer", buyer);
		model.addAttribute("page", paging);
		System.out.println("KhController getPaymentList paymentList -> " + paymentList);
		model.addAttribute("currentPage", payList.getCurrentPage());
		
		return "view_kh/adminPaymentList";
	}
	
	
	@PostMapping(value = "/ajax.autocomplete")
	public @ResponseBody Map<String, Object> getAutoCompleteList(@RequestParam Map<String, Object> paramMap){
		log.info("KhController getAutoCompleteList is called");
		System.out.println("KhController getAutoCompleteList paramMap -> " + paramMap);
		
		List<Map<String, Object>> resultList = khTableService.getAutoCompleteList(paramMap);
		System.out.println("KhController getAutoCompleteList resultList -> " + resultList);
		paramMap.put("resultList", resultList);
		
		return paramMap;
	}
	
	
	@GetMapping(value = "/paymentList") 
	public String getPaymentList(PayList payList, Model model) {
		log.info("KhController getPaymentList is called");
		
		List<PayList> paymentList 		= new ArrayList<>();
		String sendRefundPasswordResult = null;
		User_Table buyer 				= khTableService.getUserById(payList.getUser_id());
		int totPayment					= khTableService.getTotPaymentByUserId(payList.getUser_id());
		
		if(SessionUtils.getStringAttributeValue("sendRefundPasswordResult") != null) {
			sendRefundPasswordResult = SessionUtils.getStringAttributeValue("sendRefundPasswordResult");
			System.out.println("KhController getPaymentList sendRefundPasswordResult -> " + sendRefundPasswordResult);
		}		
		
		Paging paging = new Paging(totPayment, payList.getCurrentPage());
		
		payList.setStart(paging.getStart());
		payList.setEnd(paging.getEnd());
		
		paymentList 					= khTableService.getPayList(payList);
		
		model.addAttribute("paymentList", paymentList);
		model.addAttribute("admin_id", payList.getAdmin_id());
		model.addAttribute("user_id", payList.getUser_id());
		model.addAttribute("buyer", buyer);
		model.addAttribute("page", paging);
		System.out.println("KhController getPaymentList paymentList -> " + paymentList);
		model.addAttribute("currentPage", payList.getCurrentPage());
		
		return "view_kh/adminPaymentList";
	}
	
	
	@GetMapping(value = "/sendRefundPassword")
	public String sendRefundPassword(String tid, Model model) {
		log.info("KhController sendRefundPassword is called");
		String sendRefundPassword		= payService.sendRefundPassword(tid);
		String user_id					= khTableService.getUserIdByApprovalNum(tid);
				
		if(sendRefundPassword != null) {
			
			model.addAttribute("sendRefundPassword", sendRefundPassword);
			model.addAttribute("tid", tid);
			model.addAttribute("user_id", user_id);
			
			return "view_kh/refundPayment";
		}
		
		System.out.println("sendRefundPassword -> " + sendRefundPassword);
		
		return "redirect:/KH/pay/paymentList?user_id=" + user_id;	
	}
	
	@GetMapping(value = "/changeReviewDelState")
	public String changeReviewDelState(String del_state, long expert_review_num, Model model) {
		
		System.out.println("KhController changeReviewDelState del_state -> " + del_state);
		System.out.println("KhController changeReviewDelState expert_review_num -> " + expert_review_num);

		Expert_Review expertReviewDetail = khTableService.getExpertReviewDetail(expert_review_num);
		User_Table expert				 = khTableService.getUserById(expertReviewDetail.getUser_id());
		
		model.addAttribute("del_state", del_state);
		model.addAttribute("expert", expert); 
		model.addAttribute("expertReviewDetail", expertReviewDetail);
		
		return "view_kh/adminReviewDelStateChange";
	}
	
	@GetMapping(value = "/updateReviewDelState")
	public String updateReviewDelState(Expert_Review expertReview) {
		
		System.out.println("KhController updateReviewDelState del_state -> " + expertReview.getDel_state());
		System.out.println("KhController updateReviewDelState expert_review_num -> " + expertReview.getExpert_review_num());
		
		if(expertReview.getDel_state() == 0) {
			expertReview.setDel_state(1);
		}else {
			expertReview.setDel_state(0);
		}
		
		khTableService.updateReviewDelState(expertReview);
		
		return "redirect:/KH/pay/changeReviewDelState";
	}
	
	
	

	@Transactional
	@GetMapping(value = "/requestRefundPayment")
	public String refundPayment(String tid, Model model) {
		log.info("KhController refundPayment is called");
		System.out.println("KhController refundPayment tid -> " + tid);
		
		String user_id						= SessionUtils.getStringAttributeValue("user_id");		
		KaKaoPayCancelResponse refundDetail = payService.refundPayment(tid);

		model.addAttribute("refundDetail", refundDetail);
		System.out.println("KhController refundPayment refundDetail -> " + refundDetail);
		
		
		return "redirect:/KH/pay/adminPaymentList";
	}
	

	
	//차량리스트	
	@GetMapping(value = "/carList")
	public String getCarList(Model model) {
		log.info("KhController getCarList is called");
		System.out.println("KhController getCarList user_id -> " + SessionUtils.getStringAttributeValue("user_id"));
		
		List<Car_General_Info> carList = new ArrayList<>();
		carList = khTableService.getCarList();
		System.out.println("KhController carList carList -> " + carList);
		
		/*
		for(int i=0 ; i<24 ; i++) {
			String pass = passwordEncoder.encode("1111");
			System.out.println("pass -> " + pass);
		}
		*/	

		model.addAttribute("carList", carList);

		return "view_kh/carList";
	}
	
	
	@GetMapping(value = "/reviewList") 
	public String reviewList(Model model) {
		String user_id 			= "buyer" + Math.round(((Math.random() * 18)) + 1);
		long expert_review_num	= 50000000000L + (long)(Math.random() * 10 + 1);	

		Expert_Review expertReviewDetail = khTableService.getExpertReviewDetail(expert_review_num);
		Car_General_Info carDetail = khTableService.getCarBySellId(expertReviewDetail.getSell_num());
		User_Table buyer = khTableService.getUserById(user_id);
		User_Table seller = khTableService.getUserById(expertReviewDetail.getUser_id());
		
		SessionUtils.addAttribute("buyer", buyer);
		SessionUtils.addAttribute("buyer_id", user_id);

		model.addAttribute("expertReviewDetail", expertReviewDetail);
		model.addAttribute("carDetail", carDetail);
		model.addAttribute("buyer", buyer);
		model.addAttribute("seller", seller);
		
		return "view_kh/expertPayment";
	}
	

	//개별 차량 상세 정보호출
	@GetMapping(value = "/carDetail")
	public  @ResponseBody RedirectView getCarDetail(long sell_num, Model model) {
		log.info("KhController getCarDetail is called");
		Payment payment = new Payment();
		
		String user_id 	= "buyer" + Math.round((Math.random() * 18 + 1));
		User_Table user	= khTableService.getUserById(user_id);
		
		payment.setUser_id(user_id);
		payment.setSell_num(sell_num);
		payment.setReceiver_zipcode(user.getUser_zipcode());
		payment.setReceiver_addr1(user.getUser_addr1());
		payment.setReceiver_addr2(user.getUser_addr2());
		payment.setBuy_type(1);
		
		Car_General_Info carDetail	= khTableService.getCarBySellId(sell_num);
		long rawPrice 				= carDetail.getPrice() * 10000;
		SessionUtils.addAttribute("rawPrice", rawPrice);
		
		KakaoPayReadyResponse readyResponse = payService.kakaoPayReadyCar(sell_num);
		// kakaoPay 요청양식에 따라 요청객체 만들어 보내는 메서드(service)

		log.info(readyResponse.toString());
		// kakaoPay가 준비요청 후 보내준 정보 확인
		
		SessionUtils.addAttribute("user_id", user_id);
		SessionUtils.addAttribute("buyer_id", user_id);
		SessionUtils.addAttribute("tid", readyResponse.getTid());
		SessionUtils.addAttribute("readyPayment", payment);

		RedirectView redirectView = new RedirectView();
		redirectView.setUrl(readyResponse.getNext_redirect_pc_url());

		return redirectView;
	}
	
}
