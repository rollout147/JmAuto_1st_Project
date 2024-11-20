package com.oracle.jmAuto.dao.kh;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.ExpList;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.PayList;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Seller_Info;
import com.oracle.jmAuto.dto.SessionUtils;
import com.oracle.jmAuto.dto.User_Table;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class KHTableDaoImplementation implements KHTableDao {
	private final SqlSession session;

	@Override
	public Car_General_Info getCarBySellId(long sell_num) {

		Car_General_Info carDetail = null;

		System.out.println("KHTableDaoImplementation getCarBySellId(long sell_num) is called");

		try {
			carDetail 		= session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.selectCarBySellId", sell_num);
			String brand 	= session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getBrand", carDetail.getBrand());
			String type 	= session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getCarType", carDetail.getCar_type());
			carDetail.setBrand(brand);
			
			System.out.println("com.oracle.jmAuto.dto.kh_TableMapper.getCarType -> type" + type);
			SessionUtils.addAttribute("carType", type);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getCarBySellId() e.getMessage() -> " + e.getMessage());
		}

		return carDetail;
	}

	@Override
	public Payment getPaymentBySellId(long sell_num) {
		Payment paymentDetail = null;

		System.out.println("KHTableDaoImplementation getPaymentBySellId() is called");

		try {
			paymentDetail = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.selectPaymentBySellId", sell_num);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getPaymentBySellId() e.getMessage() -> " + e.getMessage());
		}

		return paymentDetail;
	}

	@Override
	public List<Payment> getPaymentList(String user_id) {
		List<Payment> paymetList = null;

		System.out.println("KHTableDaoImplementation getPaymentList() is called");

		try {
			paymetList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.selectPaymentListByUserId", user_id);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getPaymentList() e.getMessage() -> " + e.getMessage());
		}

		return paymetList;
	}

	@Override
	public Payment getPaymentByTid(String tid) {
		Payment paymentDetail = null;

		System.out.println("KHTableDaoImplementation getPaymentByTid() is called");

		try {
			paymentDetail = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.selectPaymentByTid", tid);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getPaymentByTid() e.getMessage() -> " + e.getMessage());
		}
		
		return paymentDetail;
	}

	@Override
	public User_Table getUserById(String user_id) {
		System.out.println("KHTableDaoImplementation getUserById() is called");
		User_Table buyer = null;

		try {
			buyer = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.selectUserById", user_id);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getUserById() e.getMessage() -> " + e.getMessage());
		}		
		
		return buyer;
	}

	@Override
	public Expert_Review getExpertReviewDetail(long expert_review_num) {
		System.out.println("KHTableDaoImplementation getExpertReviewDetail() is called");
		Expert_Review expertReviewDetail = null;

		try {
			expertReviewDetail = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.expertReviewDetail", expert_review_num);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getExpertReviewDetail() e.getMessage() -> " + e.getMessage());
		}		
		
		return expertReviewDetail;
	}

	@Override
	public void insertPayment(Payment payment) {
		System.out.println("KHTableDaoImplementation insertPayment() is called");
		
		try {
			session.insert("com.oracle.jmAuto.dto.kh_TableMapper.InsertPayment", payment);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation insertPayment() e.getMessage() -> " + e.getMessage());
		}
				
	}

	@Override
	public List<Car_General_Info> getCarList() {
		List<Car_General_Info> carList 	= null;
		
		try {
			carList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getCarList");
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getCarList() e.getMessage() -> " + e.getMessage());
		}
		return carList;
	}

	@Override
	public List<Expert_Review> getExpertReviewList(long sell_num) {
		List<Expert_Review> expertReviewList 	= null;
		
		try {
			expertReviewList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getExpertReviewList", sell_num);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getExpertReviewList() e.getMessage() -> " + e.getMessage());
		}
		return expertReviewList;
	}

	@Override
	public int getPurchaseExpert(String user_id, long expert_review_num) {
		List<Long> userPurchase 	= null;
		int result 					= 0;
		
		try {
			userPurchase = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getPurchaseExpertList", user_id);
			if(userPurchase != null) {
				if(userPurchase.contains(expert_review_num)) {
					result = 1;
				}
			}
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getPurchaseExpert() e.getMessage() -> " + e.getMessage());
		}
				
		return result;
	}

	@Override
	public String getRefundPassword(String approval_num) {
		String refundPassword = "";
		
		try {
			refundPassword = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getRefundPassword", approval_num);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getRefundPassword() e.getMessage() -> " + e.getMessage());
		}		
		
		return refundPassword;
	}

	@Override
	public void updateRefundPayment(String approval_num) {
		
		try {
			session.update("com.oracle.jmAuto.dto.kh_TableMapper.updateRefundPayment", approval_num);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation updateRefundPayment() e.getMessage() -> " + e.getMessage());
		}
		
	}

	@Override
	public void updateCarDelState(Long sell_num) {
		System.out.println("com.oracle.jmAuto.dto.kh_TableMapper.updateCarDelState -> " + sell_num);
		try {
			session.update("com.oracle.jmAuto.dto.kh_TableMapper.updateCarDelState", sell_num);
		} catch (Exception e) {
			
			System.out.println("KHTableDaoImplementation updateCarDelState() e.getMessage() -> " + e.getMessage());
		}
		
	}

	@Override
	public String getUserIdByApprovalNum(String approval_num) {
		String user_id = "";
		
		try {
			user_id = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getUserIdByApprovalNum", approval_num);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getUserIdByApprovalNum() e.getMessage() -> " + e.getMessage());
		}		
		
		return user_id;
	}

	@Override
	public void insertExpertReview(Expert_Review expertReview) {
		System.out.println("KHTableDaoImplementation insertExpertReview() is called");
		
		try {
			session.insert("com.oracle.jmAuto.dto.kh_TableMapper.insertExpertReview", expertReview);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation insertExpertReview() e.getMessage() -> " + e.getMessage());
		}
		
	}

	@Override
	public void updateExpertReview(Expert_Review expertReview) {
		System.out.println("KHTableDaoImplementation updateExpertReview() is called");
		
		try {
			session.insert("com.oracle.jmAuto.dto.kh_TableMapper.updateExpertReview", expertReview);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation insertExpertReview() e.getMessage() -> " + e.getMessage());
		}
	}

	@Override
	public int getTotPaymentByUserId(String user_id) {
		System.out.println("KHTableDaoImplementation getTotPaymnetByUserId() is called");
		int totPayment = 0;
		
		try {
			totPayment = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getTotPaymentByUserId", user_id);
			System.out.println("KHTableDaoImplementation getTotPaymnetByUserId() totPayment -> " + totPayment);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getTotPaymnetByUserId() e.getMessage() -> " + e.getMessage());
		}
		
		return totPayment;
	}

	@Override
	public List<PayList> getPayList(PayList payList) {
		List<PayList> paymentList = null; 
		
		try {
			paymentList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getPayList", payList);

		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getPayList() e.getMessage() -> " + e.getMessage());
		}
		
		return paymentList;
	}
	
	@Override
	public List<PayList> getPayListAll(PayList payList) {
		List<PayList> paymentList = null; 
		
		try {
			paymentList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getPayListAll", payList);

		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getPayListAll() e.getMessage() -> " + e.getMessage());
		}
		
		return paymentList;
	}

	@Override
	public List<PayList> getPayListCon(PayList payList) {
		List<PayList> paymentList = null; 
		
		try {
			paymentList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getPayListCon", payList);

		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getPayListCon() e.getMessage() -> " + e.getMessage());
		}
		
		return paymentList;
	}

	@Override
	public int getTotPaymentByCon(PayList payList) {
		System.out.println("KHTableDaoImplementation getTotPaymentByCon() is called");
		int totPayment = 0;
		
		try {
			totPayment = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getTotPaymentByCon", payList);
			System.out.println("KHTableDaoImplementation getTotPaymentByCon() totPayment -> " + totPayment);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getTotPaymentByCon() e.getMessage() -> " + e.getMessage());
		}
		
		return totPayment;
	}

	@Override
	public int getTotExpertReview(ExpList expList) {
		System.out.println("KHTableDaoImplementation getTotExpertReview() is called");
		int totExpertReview = 0;
		
		try {
			totExpertReview = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getTotExpertReview", expList);
			System.out.println("KHTableDaoImplementation getTotExpertReview() totPayment -> " + totExpertReview);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getTotExpertReview() e.getMessage() -> " + e.getMessage());
		}
		
		return totExpertReview;
	}

	@Override
	public List<ExpList> getReviewListCon(ExpList expList) {
		List<ExpList> exReviewList = null; 
		
		try {
			exReviewList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getReviewListCon", expList);

		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getReviewListCon() e.getMessage() -> " + e.getMessage());
		}
		
		return exReviewList;
	}

	@Override
	public void updateReviewDelState(Expert_Review expertReview) {
	System.out.println("KHTableDaoImplementation updateReviewDelState() is called");
		
		try {
			session.update("com.oracle.jmAuto.dto.kh_TableMapper.updateReviewDelState", expertReview);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation updateReviewDelState() e.getMessage() -> " + e.getMessage());
		}
		
	}

	@Override
	public String getImageName(long sell_num) {
		System.out.println("com.oracle.jmAuto.dto.kh_TableMapper.getImageName" +  sell_num);
		List<Object> imageName = null;
		
		imageName = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getImageName", sell_num);
		
		if(imageName.size() == 0 ) {
			
			return "/carImages/팔정민2테스트/팔정민2테스트_1.jpg";
		}
		/*
		try {
			
			
			System.out.println("KHTableDaoImplementation getImageName() -> " + imageName);
		} catch (Exception e) {
			
			System.out.println("KHTableDaoImplementation getImageName() e.getMessage() -> " + e.getMessage());
		}
		*/
		return imageName.get(0).toString();
	}

	@Override
	public List<Map<String, Object>> getAutoCompleteList(Map<String, Object> paramMap) {
		List<Map<String, Object>> autoCompleteList = null;
		
		try {
			autoCompleteList = session.selectList("com.oracle.jmAuto.dto.kh_TableMapper.getAutoCompleteList", paramMap);

		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation autoCompleteList() e.getMessage() -> " + e.getMessage());
		}
		
		return autoCompleteList;
	}

	@Override
	public Seller_Info getSellerInfoById(String user_id) {
		Seller_Info sellerInfo = null;
		
		try {
			sellerInfo = session.selectOne("com.oracle.jmAuto.dto.kh_TableMapper.getSellerInfoById", user_id);
			System.out.println("KHTableDaoImplementation getSellerInfoById() sellerInfo -> " + sellerInfo);
		} catch (Exception e) {
			System.out.println("KHTableDaoImplementation getSellerInfoById() e.getMessage() -> " + e.getMessage());
		}
		
		return sellerInfo;
	}
}
