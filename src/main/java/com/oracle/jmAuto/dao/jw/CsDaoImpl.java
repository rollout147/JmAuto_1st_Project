package com.oracle.jmAuto.dao.jw;

import java.util.List;


import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Faq;
import com.oracle.jmAuto.dto.Notice_Table;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Review;
import com.oracle.jmAuto.dto.ReviewListInfo;


import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CsDaoImpl implements CsDao {
	private final SqlSession session;

	// 2. 자주묻는질문: 카테고리별 내용 가져오기
	@Override
	public List<Faq> listFaq() {
		List<Faq> faqList = null;
		System.out.println("CsDaoImpl listFaq Start...");

		try {			
			faqList = session.selectList("FaqListCls");
			System.out.println("CsDaoImpl listFaq faqList.size()->"+faqList.size());
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl Exception e.getmessage()->"+e.getMessage());
		}
		
		return faqList;
	}

	// 3-2. 로그인 한 회원에게 팝업창 뜸
	@Override
	public List<Qna> popQna() {
		List<Qna> openPopUp = null;
		System.out.println("CsDaoImpl openPopUp Start...");

		try {
			openPopUp = session.selectList("qnaPop");
			System.out.println("CsDaoImpl openPopUp qnaList.size()->"+openPopUp.size());
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl openPopUp Exception->"+e.getMessage());
		}
		
		return openPopUp;
	}

	// 3-3. QnA 팝업창 내용작성
	@Override
	public int insertQna(Qna qna) {
		int result = 0;
		System.out.println("CsDaoImpl insertQna Start...");
		
		try {
			result = session.insert("insertQna", qna);
			System.out.println("CsDaoImpl insertQna qna->"+qna);
			System.out.println("CsDaoImpl insertQna result->"+result);
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl insertQna Exception->"+e.getMessage());
		}
		
		return result;
	}
	
	// 3-4. QnA 파일명, url
	@Override
	public int fileUpdate(Qna qna2) {
		int result = 0;
		System.out.println("CsDaoImpl fileUpdate Start...");
		System.out.println("CsDaoImpl fileUpdate qna2->"+qna2);
		
		try {
			result = session.update("updateFile", qna2);
			System.out.println("CsDaoImpl fileUpdate result->"+result);
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl fileUpdate Exception->"+e.getMessage());
		}
		
		return result;
	}
	
	// 4-1. 공지사항 및 약관: 카테고리별 내용 가져오기
	@Override
	public List<Notice_Table> listNotice() {
		List<Notice_Table> noticeList = null;
		System.out.println("CsDaoImpl listNotice Start...");
		
		try {
			noticeList = session.selectList("NoticeListCls");
			System.out.println("CsDaoImpl listNotice noticeList.size()->"+noticeList.size());
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl listNotice Exception->"+e.getMessage());
		}
		
		return noticeList;
	}

	// 4-2. 공지사항 및 약관: 제목 누르면 나오는 상세페이지
	@Override
	public Notice_Table detailNotice(int notice_num) {
		System.out.println("CsDaoImpl detailNotice start...");
		
		Notice_Table notice_table = new Notice_Table();
		
		try {
			notice_table = session.selectOne("NoticeSelOne", notice_num);
			System.out.println("CsDaoImpl detailNotice get->"+notice_table.getNotice_title());
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl detailNotice Exception->"+e.getMessage());
		}

		return notice_table;
	}


	// 5-1. 고객후기 페이지 작업 1
	@Override
	public int totalReview() {
		int totReviewCount = 0;
		System.out.println("CsDaoImpl totalReview Start...");
		
		try {
			totReviewCount = session.selectOne("com.oracle.jmAuto.ReviewMapper.jw.reviewTotalPage");
			System.out.println("CsDaoImpl totalReview totReviewCount->"+totReviewCount);
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl totalReview Exception->"+e.getMessage());
		}

		return totReviewCount;
	}

	// 5-2. 고객후기 메인 페이지 리스트
	@Override
	public List<ReviewListInfo> listReview(ReviewListInfo ri) {
		List<ReviewListInfo> listResult = null;
		System.out.println("CsDaoImpl listReview Start...");
		
		try {
			listResult = session.selectList("selectReview", ri);
			System.out.println("CsDaoImpl listReview listResult.size()->"+listResult.size());
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl listReview Exception->"+e.getMessage());
		}
		
		return listResult; 
	}

	// 5-3. 고객후기: CAR_GENERAL_INFO 테이블의 차량정보
	@Override
	public Car_General_Info detailCarInfo(long sell_num) {
		System.out.println("CsDaoImpl detailCarInfo Start...");
		
		Car_General_Info carInfo = new Car_General_Info();
		
		try {
			carInfo = session.selectOne("selectCarInfo", sell_num);
			System.out.println("CsDaoImpl detailCarInfo carInfo->"+carInfo);
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl detailCarInfo Exception->"+e.getMessage());
		}
		
		return carInfo;
	}

	// 5-4. 고객후기: CAR_IMAGES 테이블의 차량 이미지
	@Override
	public Car_Image detailImage(long sell_num) {
		System.out.println("CsDaoImpl detailImage Start...");
		
		Car_Image carImage = new Car_Image();
		
		try {
			carImage = session.selectOne("selectImage", sell_num);
			System.out.println("CsDaoImpl detailImage carImage->"+carImage);
						
		} catch (Exception e) {
			System.out.println("CsDaoImpl detailImage Exception->"+e.getMessage());
		}
		
		return carImage;
	}

	// 5-5. 고객후기: REVIEW 테이블의 리뷰정보
	@Override
	public Review detailReview(String approval_num) {
		System.out.println("CsDaoImpl detailReview Start...");
		
		Review review = new Review();
		
		try {
			review = session.selectOne("selectReviews", approval_num);
			System.out.println("CsDaoImpl detailReview review->"+review);
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl detailReview Exception->"+e.getMessage());
		}
		
		return review;
	}

	// 5-6. 고객후기: Payment 테이블의 유저 정보
	@Override
	public Payment detailUser(String user_id) {
		System.out.println("CsDaoImpl detailUser Start...");
		
		Payment payment = new Payment();
		
		try {
			payment = session.selectOne("selectUser", user_id);
			System.out.println("CsDaoImpl detailUser payment->"+payment);
			
		} catch (Exception e) {
			System.out.println("CsDaoImpl detailUser Exception->"+e.getMessage());
		}
		
		return payment;
	}


}
