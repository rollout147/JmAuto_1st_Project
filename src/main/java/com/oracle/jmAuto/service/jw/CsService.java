package com.oracle.jmAuto.service.jw;

import java.util.List;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Faq;
import com.oracle.jmAuto.dto.Notice_Table;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Review;
import com.oracle.jmAuto.dto.ReviewListInfo;


public interface CsService {

	// 자주 묻는 질문
	List<Faq> 					listFaq();	

	// 신고·문의·민원
	List<Qna> 					popOpen();				

	int 						insertQna(Qna qna);		
	
	int 						updateFile(Qna qna2);	

	
	//공지사항
	List<Notice_Table> 			listNotice();					

	Notice_Table 				detailNotice(int notice_num);	


	// 고객후기
	int 						totalReviewPage();		

	List<ReviewListInfo> 		listReview(ReviewListInfo ri);
	

	// 고객후기 팝업창
	Car_General_Info 			getCarDetail(long sell_num);

	Car_Image 					getCarImage(long sell_num);

	Review 						getReviewDetail(String approval_num);

	Payment 					getPayment(String user_id);


	}
