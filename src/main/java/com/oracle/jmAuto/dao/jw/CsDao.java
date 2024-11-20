package com.oracle.jmAuto.dao.jw;

import java.util.List;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Faq;
import com.oracle.jmAuto.dto.Notice_Table;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Review;
import com.oracle.jmAuto.dto.ReviewListInfo;


public interface CsDao {
	
	// 자주 묻는 질문
	List<Faq> 					listFaq();	

	
	// 신고·문의·민원
	List<Qna> 					popQna();				
	
	int 						insertQna(Qna qna);		

	int 						fileUpdate(Qna qna2);	


	// 공지사항
	List<Notice_Table> 			listNotice();				
	
	Notice_Table 				detailNotice(int notice_num);	

	
	// 고객후기 
	int 						totalReview();		

	List<ReviewListInfo> 		listReview(ReviewListInfo ri);

	
	// 고객후기 팝업창
	Car_General_Info 			detailCarInfo(long sell_num);

	Car_Image 					detailImage(long sell_num);

	Review 						detailReview(String approval_num);

	Payment 					detailUser(String user_id);

}
