package com.oracle.jmAuto.service.ms;

import java.util.List;
import java.util.Map;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.Note;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Review;
import com.oracle.jmAuto.dto.ReviewListInfo;
import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.dto.Zzim;

import jakarta.servlet.http.HttpSession;

public interface MsService {
	List<Zzim> 				findZzim(String user_id);
	int 					PaymentUser();
	List<Payment> 			buyList(String user_id);
	String 					findByPw(String id);
	void 					userUpdate(User_Table user_table);
	List<Expert_Review> 	expertReviews(String user_id);
	List<Qna> 				QnaList(String user_id);
	int 					deleteQna(String user_id, List<Long> qnanum);
	Qna 					myQnaDetail(long qna_num, HttpSession session);
	Payment 				buyListDetail(String approval_num, String user_id);
	Expert_Review 			reviewDetail(String expert_num, String user_id);
	int 					deleteZzim(String user_id, List<Long> sell_num);
	long 					paymentselect(String user_id);
	
	
	
	ReviewListInfo          imageList(ReviewListInfo ri);
    int                     hoogiwrite(Review review);
    ReviewListInfo          myhoogiDetail(String approval_num);
    List<Review>            myhoogi(String user_id);
	
	int 					hoogiDelete(String user_id, String approval_num);
	List<Expert_Review> 	myExpertReview(String user_id);
	List<Expert_Review> 	myExpertReviewDetail(String user_id, long expert_review_num);
	List<Car_General_Info> 	sellCar(String user_id);
	List<Car_General_Info> 	sellWan(String user_id);
	List<Note> 				myNote(String user_id);
	Note 					myNoteDetail(String user_id, int note_num);
	int 					noteDabjang(Map<String, Object> params);
	int 					deleteNote(int note_num);
	List<Note> 				ReceivedNotes(String user_id);
	List<Note> 				SendNotes(String user_id);
	List<Car_General_Info> 	gumaeHoogi(String approval_num);
	boolean 				reviewExists(String user_id, String approval_num);
	String 					approval(String user_id, long sell_num);
	Payment 				sellListDetail(String approval_num, String user_id);
	void 					taltwae(String user_id);
	List<Review> 			myhoogiDetail(String user_id, String approval_num);
	User_Table 				user(String user_id);
	int 					deletesell(String user_id, List<Long> sell_num);
	int 					service_sending_note(Note note);
	Review 					del_state(String approval_num);
	int 					qnaDetailDelete(String user_id, Long qnanum);
	Review 					hoogiya(String user_id, String approval_num);
	

	
	

}

