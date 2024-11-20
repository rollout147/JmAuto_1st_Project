package com.oracle.jmAuto.service.ms;

import java.util.List;
import java.util.Map;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.oracle.jmAuto.dao.ms.MsDao;
import com.oracle.jmAuto.dao.ms.MsDaoImpl;
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
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MsServiceImpl implements MsService {
	private final MsDao md;

	//관심목록
	public List<Zzim> findZzim(String user_id) {
		System.out.println("MsServiceImpl findZzim start...");
		List<Zzim> ZzimList = md.findZzim(user_id);
		return ZzimList;
	}
	
	//구매한 사람 몇명
	public int PaymentUser() {
		System.out.println("MsServiceImpl SelectUser start...");
		int result=0;
		result=md.PaymentUser();
		return result;
	}
	
	//구매차량목록
	public List<Payment> buyList(String user_id) {
		System.out.println("MsServiceImpl buyList start.. ");
		List<Payment> buyList = md.buyList(user_id);
		return buyList;
	}
	
	//로그인
	public User_Table login(String user_id, String user_pw) {
		System.out.println("msServiceImpl.login start...");
		User_Table user_table = md.login(user_id, user_pw);
		System.out.println("smServiceImpl.login user_table->"+ user_table);
		return user_table;
	}
	
	//비밀번호 가져오기 로직
	public String findByPw(String myselfid) {
		System.out.println("msService findByPw start...");
		String dbUser_pw = md.findByPw(myselfid);
		return dbUser_pw;
	}
	
	//회원정보 수정 로직
	@Override
	public void userUpdate(User_Table user_table) {
		System.out.println("msService userUpdate start...");
		md.userUpdate(user_table);		
	}
	
	//내가 구매한 전문가 리뷰
	@Override
	public List<Expert_Review> expertReviews(String user_id) {
		System.out.println("msService expertReview start...");
		return md.expertReviews(user_id);
	}
	
	//나의 문의내역
	@Override
	public List<Qna> QnaList(String user_id) {
		System.out.println("msService QnaList start...");
		return md.QnaList(user_id);
	}
	
	//문의 내역 삭제
	@Override
	public int deleteQna(String user_id,  List<Long> Qnanum) {
		System.out.println("msService deleteQna start...");
		int result =0;
		result= md.deleteQna(user_id, Qnanum);
		System.out.println("msService deleteQna user_id->"+ user_id);
		System.out.println("msService deleteQna Qnanum->"+ Qnanum);
		return result;
	}
	
	//문의내역 상세조회
	@Override
	public Qna myQnaDetail(long qna_num, HttpSession session) {
		System.out.println("msService myQnaDetail start...");
		User_Table user_table = (User_Table)session.getAttribute("user");
		String user_id= user_table.getUser_id();
		System.out.println("msService myQnaDetail user_id->"+ user_id);
		
		Qna qnanum = md.myQnaDetail(qna_num, user_id);
		System.out.println("msService myQnaDetail qnanum->"+ qnanum);
		return qnanum;
	}
	
	//구매내역 상세조회
	@Override
	public Payment buyListDetail(String approval_num,String user_id) {
		System.out.println("msService buyListDetail start...");
		System.out.println("msService buyListDetail user_id..."+user_id);
		Payment buyList = md.buyListDetail(approval_num,user_id);
		System.out.println("msService buyListDetail buyList->"+ buyList);		
		return buyList;
	}
	
	//리뷰상세페이지
	@Override
	public Expert_Review reviewDetail(String expert_num, String user_id) {
		System.out.println("msService reviewDetail start...");
		Expert_Review expertnum = md.reviewDetail(expert_num, user_id);
		System.out.println("msService reviewDetail expertnum->"+expertnum);
		return expertnum;
	}
	
	//나의 관심목록 삭제
	@Override
	public int deleteZzim(String user_id, List<Long> sell_num) {
		System.out.println("msService deleteZzim start...");
		return md.deleteZzim(user_id, sell_num);
	}
	
//	//구매후기작성
//	@Override
//	public int hoogiwrite(Map<String, Object> params) {
//		System.out.println("msService hoogiwrite start...");
//		return md.hoogiwrite(params);
//	}
	
	
	//구매후기에 기존 차량 이미지 첨부
    @Override
    public ReviewListInfo imageList(ReviewListInfo ri) {
        System.out.println("msService imageList Start...");
        return md.imageList(ri);
    }

    //구매후기에 구매자 작성 내용+첨부파일
    @Override
    public int hoogiwrite(Review review) {
        System.out.println("msService hoogiwrite start...");
        return md.hoogiwrite(review);
    }


    //구매자 -> 내가 작성한 후기상세내용
    @Override
    public ReviewListInfo myhoogiDetail (String approval_num) {
        System.out.println("msService myhoogiDetail start...");
        return md.myhoogiDetail(approval_num);
    }
	
	//후기 작성폼에서 sell_num값 받아오려는 로직.....
	@Override
	public long paymentselect(String user_id) {
		System.out.println("msService paymentselet start..");
		System.out.println("msService paymentselet user_id->"+ user_id);
		
		long sellnum = md.paymentselect(user_id);
		System.out.println("msService paymentselet sellnum->"+sellnum);
		return sellnum;
	}
	
	//후기 리스트에 뿌려줄 나의 후기들
	@Override
	public List<Review> myhoogi(String user_id) {
		System.out.println("msService myhoogi start...");
		List<Review> reviews = md.myhoogi(user_id);
		System.out.println("msService myhoogi reviews->"+ reviews);
		System.out.println("msService myhoogi user_id->"+ user_id);
		return reviews;
	}
	
	//내가 작성한 후기 삭제
	@Override
	public int hoogiDelete(String user_id, String approval_num) {
		System.out.println("msService hoogiDelete start..");
		return md.hoogiDelete(user_id, approval_num);
	}
	
	//내가 작성한 전문가리뷰
	@Override
	public List<Expert_Review> myExpertReview(String user_id) {
		System.out.println("msService myExpertReview start...");
		return md.myExpertReview(user_id);
	}
	
	//내가 작성한 전문가리뷰 상세
	@Override
	public List<Expert_Review> myExpertReviewDetail(String user_id, long expert_review_num) {
		System.out.println("msService myExpertReviewDetail start...");
		return md.myExpertReviewDetail(user_id, expert_review_num);
	}
	
	//내가 판매중인 차량
	@Override
	public List<Car_General_Info> sellCar(String user_id) {
		System.out.println("msService sellCar start...");
		System.out.println("msServiece sellCar user_id"+user_id);
		return md.sellCar(user_id);
	}
	
	//판매완료목록
	@Override
	public List<Car_General_Info> sellWan(String user_id) {
		System.out.println("msService sellWan start..");
		return md.sellWan(user_id);
	}
	
	//쪽지보관함
	@Override
	public List<Note> myNote(String user_id) {
		System.out.println("msService myNote start..");
		return md.myNote(user_id);
	}
	
	//쪽지 상세보기
	@Override
	public Note myNoteDetail(String user_id, int note_num) {
		System.out.println("msService myNoteDetail start..");
		return md.myNoteDetail(user_id, note_num);
	}
	
	//쪽지 삭제
	@Override
	public int deleteNote(int note_num) {
		System.out.println("msService deleteNote start..");
		return md.deleteNote(note_num);
	}
	
	//쪽지 답장
	@Override
	public int noteDabjang(Map<String, Object> params) {
		System.out.println("msService noteDabjang start...");
		return md.noteDabjang(params);
	}
	
	//받은쪽지
	@Override
	public List<Note> ReceivedNotes(String user_id) {
		System.out.println("msService ReceivedNotes start...");
		return md.ReceivedNotes(user_id);
	}
	
	//보낸쪽지
	@Override
	public List<Note> SendNotes(String user_id) {
		System.out.println("msService SendNotes start...");
		return md.SendNotes(user_id);
	}
	
	//후기 작성시 불러오는 기본 구매정보
	@Override
	public List<Car_General_Info> gumaeHoogi(String approval_num) {
		System.out.println("msService gumaeHoogi start..");
		return md.gumaeHoogi(approval_num);
	}
	
	//후기 있나없나 확인
	@Override
	public boolean reviewExists(String user_id, String approval_num) {
		System.out.println("msService reviewExists start..");
		return md.reviewExists(user_id, approval_num);
	}
	
	//approval_num끌고오기
	@Override
	public String approval(String user_id, long sell_num) {
		System.out.println("msService approval_num start....");
		System.out.println("msService approval_num user_id->"+user_id);
		System.out.println("msService approval_num sell_num->"+sell_num);
		return md.approval(user_id, sell_num);
	}
	
	//판매자 -> 차량판매상세목록
	@Override
	public Payment sellListDetail(String approval_num, String user_id) {
		System.out.println("msService sellListDetail start....");
		return md.sellListDetail(approval_num, user_id);
	}
	
	//회원탈퇴
	@Override
	public void taltwae(String user_id) {
		System.out.println("msService taltwae start...");
		md.taltwae(user_id);		
	}

	//구매자 -> 내가 작성한 후기상세내용
	@Override
	public List<Review> myhoogiDetail(String user_id, String approval_num) {
		System.out.println("msService myhoogiDetail start...");
		return md.myhoogiDetail(user_id, approval_num);		
	}

	//user정보가져오기
	@Override
	public User_Table user(String user_id) {
		System.out.println("msService user start...");
		return md.user(user_id);
	}

	//판매중인 차량 삭제
	@Override
	public int deletesell(String user_id, List<Long> sell_num) {
		System.out.println("msService deletesell start...");
		System.out.println("msService deletesell sell_num..."+sell_num);
		
		return md.deletesell(user_id, sell_num);
	}

	//쪽지보내기
	@Override
    public int service_sending_note(Note note) {
        int sending_note = 0;
        sending_note = md.dao_sending_note(note);
        return sending_note;
    }

	//del_state값 불러오기
	@Override
	public Review del_state(String approval_num) {
		System.out.println("msService start..");
		return md.del_state(approval_num);
	}

	//문의 상세내역 삭제
	@Override
	public int qnaDetailDelete(String user_id, Long qna_num) {
		System.out.println("msService qnaDetailDelete start...");
		int result =0;
		result= md.qnaDetailDelete(user_id, qna_num);
		System.out.println("msService qnaDetailDelete user_id->"+ user_id);
		System.out.println("msService qnaDetailDelete Qnanum->"+ qna_num);
		return result;
	}

	//hoogiya~~~
	@Override
	public Review hoogiya(String user_id, String approval_num) {
		System.out.println("msService hoogiya start...");
		System.out.println("msService hoogiya user_id..."+user_id);
		System.out.println("msService hoogiya approval_num..."+approval_num);
		return md.hoogiya(user_id, approval_num);
	}




}
