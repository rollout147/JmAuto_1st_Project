package com.oracle.jmAuto.service.kh;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.jmAuto.dao.kh.KHTableDao;
import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.ExpList;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.PayList;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Seller_Info;
import com.oracle.jmAuto.dto.User_Table;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class KHTableServiceImplementation implements KHTableService {

	private final KHTableDao khTableDao;
	
	@Override
	public Car_General_Info getCarBySellId(long sell_num) {
		System.out.println("KHTableServiceImplementation getCarBySellId(long sell_num) is called");
		System.out.println("KHTableServiceImplementation getCarBySellId sell_num -> " + sell_num);
		Car_General_Info carDetail = khTableDao.getCarBySellId(sell_num);

		return carDetail;
	}

	@Override
	public Payment getPaymentBySellId(long sell_num) {
		System.out.println("KHTableServiceImplementation paymentDetailCall() is called");
		System.out.println("KHTableServiceImplementation paymentDetailCall getSell_num -> " + sell_num);
		Payment paymentDetail = khTableDao.getPaymentBySellId(sell_num);
		return paymentDetail;
	}

	@Override
	public List<Payment> getPaymentList(String user_id) {
		System.out.println("KHTableServiceImplementation paymentListCall() is called");
		System.out.println("KHTableServiceImplementation paymentListCall User_id -> " + user_id);
		List<Payment> paymentList = khTableDao.getPaymentList(user_id);
		return paymentList;
	}

	@Override
	public User_Table getUserById(String user_id) {
		System.out.println("KHTableServiceImplementation userDetail() is called");
		System.out.println("KHTableServiceImplementation userDetail User_id -> " + user_id);
		
		User_Table buyer = khTableDao.getUserById(user_id);
		System.out.println("KHTableServiceImplementation userDetail buyer -> " + buyer);		
		
		return buyer;
	}

	@Override
	public Expert_Review getExpertReviewDetail(long expert_review_num) {
		System.out.println("KHTableServiceImplementation expertDetail() is called");
		System.out.println("KHTableServiceImplementation expertDetail expert_review_num -> " + expert_review_num);
		
		Expert_Review expertReviewDetail  = khTableDao.getExpertReviewDetail(expert_review_num);
		
		return expertReviewDetail;
	}

	@Override
	public void insertPayment(Payment payment) {
		System.out.println("KHTableServiceImplementation insertPayment() is called");
		System.out.println("KHTableServiceImplementation insertPayment() payment -> " + payment);
		
		khTableDao.insertPayment(payment);		
	}

	@Override
	public List<Car_General_Info> getCarList() {
		List<Car_General_Info> carList 	= new ArrayList<>();
		carList 						= khTableDao.getCarList(); 		
		return carList;
	}

	@Override
	public List<Expert_Review> getExpertReviewList(long sell_num) {
		List<Expert_Review> expertReviewList 	= new ArrayList<>();
		expertReviewList 						= khTableDao.getExpertReviewList(sell_num); 		
		return expertReviewList;
	}

	@Override
	public int getPurchaseExpert(String user_id, long expert_review_num) {
		
		int result	= khTableDao.getPurchaseExpert(user_id, expert_review_num);
		
		return result;
	}

	@Override
	public void updateCarDelState(long sell_num) {
		
		System.out.println("KHTableServiceImplementation updateCarDelState() sell_num -> " + sell_num);
		
		khTableDao.updateCarDelState(sell_num);
		
	}

	@Override
	public String getUserIdByApprovalNum(String approval_num) {
		System.out.println("KHTableServiceImplementation getUserIdByApprovalNum() approval_num -> " + approval_num);		
		String user_id = khTableDao.getUserIdByApprovalNum(approval_num);
		
		return user_id;
	}

	@Override
	public void insertExpertReview(Expert_Review expertReview) {
		System.out.println("KHTableServiceImplementation insertExpertReview() expertReview -> " + expertReview);
		khTableDao.insertExpertReview(expertReview);
	}

	@Override
	public void updateExpertReview(Expert_Review expertReview) {
		System.out.println("KHTableServiceImplementation updateExpertReview() expertReview -> " + expertReview);
		khTableDao.updateExpertReview(expertReview);
		
	}

	@Override
	public int getTotPaymentByUserId(String user_id) {
		System.out.println("KHTableServiceImplementation getTotPaymnetByUserId() user_id -> " + user_id);
		int totPayment = khTableDao.getTotPaymentByUserId(user_id);
		
		return totPayment;
	}

	@Override
	public List<PayList> getPayList(PayList payList) {
		System.out.println("KHTableServiceImplementation getPayList() payList -> " + payList);
		List<PayList> paymentList = khTableDao.getPayList(payList);
		
		return paymentList;
	}

	@Override
	public List<PayList> getPayListCon(PayList payList) {
		System.out.println("KHTableServiceImplementation getPayList() payList -> " + payList);
		List<PayList> paymentList = khTableDao.getPayListCon(payList);
		
		return paymentList;
	}

	@Override
	public int getTotPaymentByCon(PayList payList) {
		System.out.println("KHTableServiceImplementation getTotPaymentByCon() payList -> " + payList);
		int totPayment = khTableDao.getTotPaymentByCon(payList);
		
		return totPayment;
	}

	@Override
	public int getTotExpertReview(ExpList expList) {
		System.out.println("KHTableServiceImplementation getTotExpertReview() expertReviewList -> " + expList);
		int totExpertReview = khTableDao.getTotExpertReview(expList);
		
		return totExpertReview;
	}

	@Override
	public List<ExpList> getReviewListCon(ExpList expList) {
		List<ExpList> exReviewList = khTableDao.getReviewListCon(expList);
		
		return exReviewList;
	}

	@Override
	public void updateReviewDelState(Expert_Review expertReview) {
		khTableDao.updateReviewDelState(expertReview);
		
	}

	@Override
	public String getImageName(long sell_num) {
		String imageName = khTableDao.getImageName(sell_num);
		return imageName;
	}

	@Override
	public List<Map<String, Object>> getAutoCompleteList(Map<String, Object> paramMap) {
		
		List<Map<String, Object>> autoCompleteList = khTableDao.getAutoCompleteList(paramMap);
		
		return autoCompleteList;
	}

	@Override
	public Seller_Info getSellerInfoById(String user_id) {
		Seller_Info sellerInfo = khTableDao.getSellerInfoById(user_id);
		
		return sellerInfo;
	}
}
