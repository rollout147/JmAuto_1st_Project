package com.oracle.jmAuto.dao.ms;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.Note;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Review;
import com.oracle.jmAuto.dto.ReviewListInfo;
import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.dto.Zzim;

import jakarta.persistence.EntityManager;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MsDaoImpl implements MsDao {
	private final SqlSession session;

	//구매한 사람 몇명
	@Override
	public int PaymentUser() {	
		System.out.println("MsDaoImpl totalUser start...");
		int totUserCount = 0;
		try {
			totUserCount = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.PaymentUser");
			System.out.println("MsDaoImpl totalUser totUserCount->" + totUserCount);
		} catch (Exception e) {
			System.out.println("MsDaoImpl totalUser totUserCount error->" + e.getMessage());
		}
		return totUserCount;
	}

	//관심목록
	@Override
	public List<Zzim> findZzim(String user_id) {
		System.out.println("MsDaoImpl findZzim start...");
		List<Zzim> ZzimList = null;
		try {
			ZzimList = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.findZzim", user_id);
		} catch (Exception e) {
			System.out.println("MsDaoImpl findZzim error->" + e.getMessage());
		}
		return ZzimList;
	}

	//로그인
	public User_Table login(String user_id, String user_pw) {
		System.out.println("msDaoImpl login start...");
		User_Table user_table = new User_Table();
		try {
			user_table.setUser_id(user_id);
			user_table.setUser_pw(user_pw);
			user_table = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.loginUser", user_table);
		} catch (Exception e) {
			System.out.println("msDaoImpl login error->" + e.getMessage());
		}
		return user_table;
	}

	// 회원정보 수정 전 체크할 때, 비밀번호 가져오기.
	public String findByPw(String myselfid) {
		System.out.println("msDaoImpl findByPw strat...");
		String dbUser_pw = null;
		try {
			dbUser_pw = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.findByPw", myselfid);
			System.out.println("msDaoImpl findByPw myselfid-> " + myselfid);
		} catch (Exception e) {
			System.out.println("msDaoImpl findByPw error->" + e.getMessage());
		}
		return dbUser_pw;
	}

	// 회원정보 수정 로직
	@Override
	public void userUpdate(User_Table user_table) {
		System.out.println("msDao userUpdate start...");
		int result = 0;
		try {
			result = session.update("com.oracle.jmAuto.dto.Mapper.ms.userUpdate", user_table);
			System.out.println("msDao userUpdate result->" + result);

		} catch (Exception e) {
			System.out.println("msDao userUpdate error->" + e.getMessage());
		}
	}

	//내가 구매한 전문가리뷰리스트
	@Override
	public List<Expert_Review> expertReviews(String user_id) {
		System.out.println("msDao expertReview start...");
		List<Expert_Review> expertReview = null;
		System.out.println("msDao expertReview user_id->"+user_id);
		try {
			expertReview = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.expertReview", user_id);
		} catch (Exception e) {
			System.out.println("msDao expertReviews error->"+e.getMessage());
		}
		return expertReview;
	}

	//내 문의내역 리스트
	@Override
	public List<Qna> QnaList(String user_id) {
		System.out.println("msDao QnaList start...");
		List<Qna> QnaList = null;
		try {
			QnaList = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.QnaList",user_id);
		} catch (Exception e) {
			System.out.println("msDao QnaList error->"+ e.getMessage());
		}
		return QnaList;
	}
	
	//내 문의 내역 상세조회
	@Override
	public Qna myQnaDetail(long qna_num, String user_id) {
		System.out.println("msDao myQnaDetail start...");
		Qna qnanum = null;
		try {
			qnanum = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.qnaDetail", new HashMap<String, Object>(){
				{
					put("qna_num",qna_num);
					put("user_id",user_id);
				}});
		} catch (Exception e) {
			System.out.println("msDao myQnaDetail error-> " + e.getMessage());
		}
		return qnanum;
	}
	
	//내 문의 내역 삭제
	@Override
	public int deleteQna(String user_id, List<Long> qna_nums) {
		System.out.println("msDao deleteQna start...");
		int resultTot = 0;
		try {
		     for (Long qna_num : qna_nums) {//qna_nums리스트에 포함된 각각의 qna_num을 삭제하기 위해 for사용
		     int result = session.update("com.oracle.jmAuto.dto.Mapper.ms.deleteQna", Map.of("user_id", user_id, "qna_num", qna_num));
		     resultTot += result;
		    }
		     System.out.println("총 삭제된 게시물 수: " + resultTot);
		 } catch (Exception e) {
		     System.out.println("msDao deleteQna error -> " + e.getMessage());
		}
		return resultTot;
	}	
	
	//구매리스트
	public List<Payment> buyList(String user_id) {
		System.out.println("MsDaoImpl buyList start... ");
		System.out.println("MsDaoImpl buyList user_id->" +user_id);
		List<Payment> buyList = null;
		try {
			buyList = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.buyList",user_id);
		} catch (Exception e) {
			System.out.println("MsDaoImpl buyList error->" + e.getMessage());
		}
		return buyList;
	}
		
	//나의 구매목록 상세조회
	@Override
	public Payment buyListDetail(String approval_num,String user_id) {
		System.out.println("msDao buyListDetail start...");
		System.out.println("msDao buyListDetail user_id->"+ user_id);
		System.out.println("msDao buyListDetail approval_num->"+ approval_num);
		Payment buyList = null;
		try {
			buyList = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.buyListDetail", Map.of("approval_num",approval_num,"user_id",user_id));
			if(buyList==null) {
				System.out.println("msDao buyListDetail buyList=null approval_num:"+ approval_num+", user_id="+user_id);
			}
		} catch (Exception e) {
			System.out.println("msDao buyListDetail error-> " + e.getMessage());
		}
		return buyList;
	}
	
	//나의 판매목록 상세조회
	@Override
	public Payment sellListDetail(String approval_num,String user_id) {
		System.out.println("msDao sellListDetail start...");
		System.out.println("msDao sellListDetail user_id->"+ user_id);
		System.out.println("msDao sellListDetail approval_num->"+ approval_num);
		Payment buyList = null;
		try {
			buyList = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.sellListDetail", Map.of("approval_num",approval_num,"user_id",user_id));
			if(buyList==null) {
				System.out.println("msDao sellListDetail buyList=null approval_num:"+ approval_num+", user_id="+user_id);
			}
		} catch (Exception e) {
			System.out.println("msDao sellListDetail error-> " + e.getMessage());
		}
		return buyList;
	}

	//전문가 리뷰 상세조회
	@Override
	public Expert_Review reviewDetail(String expert_review_num, String user_id) {
		System.out.println("msDao reviewDetail start..");
		System.out.println("msDao reviewDetail user_id->"+ user_id);
		System.out.println("msDao reviewDetail expert_review_num->"+ expert_review_num);
		Expert_Review expertnum = null;
		try {
			expertnum = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.reviewDetail", new HashMap<String, Object>(){
				{
					put("expert_review_num", expert_review_num);
					put("user_id",user_id);
				}});
		} catch (Exception e) {
			System.out.println("msDao reviewDetail error ->"+ e.getMessage());
		}
		return expertnum;
	}

	//나의 관심목록 삭제
	@Override
	public int deleteZzim(String user_id, List<Long> sell_num) {
		System.out.println("msDao deleteZzim start..");
		System.out.println("msDao deleteZzim user_id->"+ user_id);
		System.out.println("msDao deleteZzim sell_num->"+ sell_num);
		int resultTot = 0;
		try {
			for(Long sell_nums : sell_num) {
				int result = session.delete("com.oracle.jmAuto.dto.Mapper.ms.deleteZzim", Map.of("user_id", user_id, "sell_nums",sell_nums));
				resultTot += result;
			}		
		} catch (Exception e) {
			System.out.println("msDao deleteZzim error->"+ e.getMessage());
		}
		return resultTot;
	}
	
	
	//구매후기에 기존 차량 이미지 첨부
    @Override
    public ReviewListInfo imageList(ReviewListInfo ri) {
        System.out.println("msDao imageList Start...");
        System.out.println("msDao imageList ri->"+ri);

        ReviewListInfo reviewListInfo = new ReviewListInfo();

        try {
            reviewListInfo = session.selectOne("selectHoogiCar", ri);
            System.out.println("msDao reviewListInfo ri->"+ri);

        } catch (Exception e) {
            System.out.println("msDao imageList Exception->"+e.getMessage());
        }

        return reviewListInfo;
    }

    //구매후기에 구매자 작성 내용+첨부파일
    @Override
    public int hoogiwrite(Review review) {
        int resultHoogi = 0;
        System.out.println("msDao hoogiwrite start..");

        try {
            System.out.println("msDao hoogiwrite review->"+ review);
            resultHoogi = session.insert("hoogiwrite", review);
            System.out.println("msDao hoogiwrite resultHoogi->"+ resultHoogi);

        } catch (Exception e) {
            System.out.println("msDao hoogiwrite Exception->"+e.getMessage());
        }

        return resultHoogi;
    }

    // 내가 작성한 후기
    @Override
    public ReviewListInfo myhoogiDetail(String approval_num) {
        System.out.println("msDato myhoogiDetail start...");

        ReviewListInfo ri = new ReviewListInfo();

        try {
            ri = session.selectOne("myhoogiDetail", approval_num);
            System.out.println("후기디테일 리스트 >>>>>"+ri);

        } catch (Exception e) {
            System.out.println("msDao myhoogiDetail error->"+ e.getMessage());
        }
        return ri;
    }
	


	//sell_num가져오기
	@Override
	public long paymentselect(String user_id) {
		System.out.println("msDao paymentselect start..");
		System.out.println("msDao paymentselect user_id->"+user_id);
		long payment = 0;
		try {
			payment= session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.paymentselect", user_id);
		} catch (Exception e) {
			System.out.println("msDao paymentselect error->"+e.getMessage());		
		}
		return payment;
	}

	//구매후기작성한 목록 노출하려고 값 가지러 간다~~
	@Override
	public List<Review> myhoogi(String user_id) {
		System.out.println("msDao myhoogi start...");
		List<Review> reviews = null;
		try {
			reviews = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.myhoogi",user_id);
		} catch (Exception e) {
			System.out.println("msDao myhoogi error->"+e.getMessage());
		}
		System.out.println("msDao myhoogi reviews->"+reviews);
		return reviews;
	}

	//내가 작성한 후기 삭제
	@Override
	public int hoogiDelete(String user_id, String approval_num) {
		System.out.println("msDao hoogiDelete start..");
		System.out.println("msDao hoogiDelete approval_num->"+approval_num);
		System.out.println("msDao hoogiDelete user_id->"+user_id);
		int result=0;
		try {
				result = session.update("com.oracle.jmAuto.dto.Mapper.ms.hoogiDelete", Map.of("user_id", user_id, "approval_num", approval_num));
				System.out.println("msDao hoogiDelete result->"+result);
				System.out.println("msDao hoogiDelete user_id->"+user_id);
				System.out.println("msDao hoogiDelete approval_num->"+approval_num);
			
		} catch (Exception e) {
			System.out.println("msDao hoogiDelete error->"+e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	//내가 작성한 전문가 리뷰 보기
	@Override
	public List<Expert_Review> myExpertReview(String user_id) {
		System.out.println("msDao myExpertReview start..");
		List<Expert_Review> expert_review = null;
		try {
			expert_review = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.myExpertReview", user_id);
			System.out.println("msDao myExpertReview expert_review->"+ expert_review);
		} catch (Exception e) {
			System.out.println("msDao myExpertReview error->"+ e.getMessage());
			e.getStackTrace();
		}
		return expert_review;
	}

	//내가 작성한 전문가 리뷰 상세보기
	@Override
	public List<Expert_Review> myExpertReviewDetail(String user_id, long expert_review_num ) {
		System.out.println("msDao myExpertReviewDetail start..");
		System.out.println("msDao myExpertReviewDetail user_id->"+user_id);
		System.out.println("msDao myExpertReviewDetail expert_review_num->"+expert_review_num);
		
		List<Expert_Review> expert_review = null;
		try {
			expert_review = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.myExpertReviewDetail",  new HashMap<String, Object>(){
				{
					put("expert_review_num",expert_review_num);
					put("user_id",user_id);
				}});
			System.out.println("msDao myExpertReviewDetail expert_review->"+ expert_review);
		} catch (Exception e) {
			System.out.println("msDao myExpertReviewDetail error->"+ e.getMessage());
			e.getStackTrace();
		}
		return expert_review;
	}

	//내가 판매중인 차량
	@Override
	public List<Car_General_Info> sellCar(String user_id) {
		System.out.println("msDao cellCar start...");
		System.out.println("msDao cellCar user_id->"+user_id);
		List<Car_General_Info> sellCar = null;
		try {
			sellCar = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.sellCar",user_id);
		} catch (Exception e) {
			System.out.println("msDao cellCar error->"+e.getMessage());
			e.getStackTrace();
		}
		return sellCar;
	}

	//판매완료된 차량
	@Override
	public List<Car_General_Info> sellWan(String user_id) {
		System.out.println("msDao sellWan start..");
		List<Car_General_Info> sellWan = null;
		try {
			sellWan = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.mySellWan", user_id);
		} catch (Exception e) {
			System.out.println("msDao sellWan error->"+e.getMessage());
		}
		return sellWan;
	}

	//쪽지
	@Override
	public List<Note> myNote(String user_id) {
		System.out.println("msDao myNote start..");
		List<Note> myNoteList = null;
		try {
			myNoteList = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.zzokzi",user_id);
			System.out.println("msDao myNoteList user_id->"+ user_id);
		} catch (Exception e) {
			System.out.println("msDao myNoteList error->"+e.getMessage());
		}
		return myNoteList;
	}
	
	//쪽지보내기
	@Override
    public int dao_sending_note(Note note) {
        int sending_note = 0;
        try {
            sending_note = session.insert("com.oracle.jmAuto.dto.Mapper.ms.sending_note", note);
            System.out.println("StatsDaoImpl sending_note->" + sending_note);
        } catch (Exception e) {
            System.out.println("CsDaoImpl insertQna Exception->"+e.getMessage());
        }
        return sending_note;
    }

	//쪽지 상세조회
	@Override
	public Note myNoteDetail(String user_id, int note_num) {
		System.out.println("msDao myNoteDetail start..");
		Note noteDetail=null;
		try {
			noteDetail = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.zzokziList", Map.of("user_id",user_id, "note_num", note_num));
			System.out.println("msDao myNoteDetail user_id->"+user_id);
			System.out.println("msDao myNoteDetail note_num->"+note_num);
		} catch (Exception e) {
			System.out.println("msDao myNoteDetail error->"+ e.getMessage());
		}
		return noteDetail;
	}

	//쪽지 삭제
	@Override
	public int deleteNote(int note_num) {
		System.out.println("msDao deleteNote start..");
		int result =0;
		try {
			result = session.update("com.oracle.jmAuto.dto.Mapper.ms.deleteNote", note_num);
			System.out.println("msDao deleteNote result->"+result);
		} catch (Exception e) {
			System.out.println("msDao deleteNote error.."+e.getMessage());
		}
		return result;
	}

	//쪽지 답장
	@Override
	public int noteDabjang(Map<String, Object> params) {
		System.out.println("msDao noteDabjang start..");
		System.out.println("msDao noteDabjang params->"+params);
		return session.insert("com.oracle.jmAuto.dto.Mapper.ms.noteDabjang", params);	
	}

	//받은쪽지
	@Override
	public List<Note> ReceivedNotes(String user_id) {
		System.out.println("msDao ReceivedNotes start...");
		List<Note> receviedNotes = null;
		try {
			receviedNotes = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.ReceivedNotes",user_id);
			System.out.println("msDao ReceivedNotes receviedNotes->"+receviedNotes);
		} catch (Exception e) {
			System.out.println("msDao ReceivedNotes error->"+e.getMessage());
		}
		return receviedNotes;
	}

	//보낸쪽지
	@Override
	public List<Note> SendNotes(String user_id) {
		System.out.println("msDao SendNotes start...");
		List<Note> sendNotes = null;
		try {
			sendNotes = session.selectList("sendNotes",user_id);
			System.out.println("msDao SendNotes sendNotes->"+ sendNotes);
		} catch (Exception e) {
			System.out.println("msDao SendNotes error->"+e.getMessage());
		}
		return sendNotes;
	}

	//구매후기 작성시 불러올 구매정보
	@Override
	public List<Car_General_Info> gumaeHoogi(String approval_num) {
		System.out.println("msDao gumaeHoogi start..");
		List<Car_General_Info> car_general_info = null;
		try {
			car_general_info = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.gumaeHoogi",approval_num);
			System.out.println("msDao gumaeHoogi car_general_info->"+car_general_info);
		} catch (Exception e) {
			System.out.println("msDao goomaeHoogi error->"+ e.getMessage());
		}
		
		return car_general_info;
	}

	//후기 있나 없나 확인
	@Override
	public boolean reviewExists(String user_id, String approval_num) {
		System.out.println("msDao reviewExists start..");
		boolean result = false;
		try {
			int resultA=session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.reviewExists",Map.of("user_id",user_id,"approval_num", approval_num));
			System.out.println("msDao reviewExists user_id->"+user_id+"approval_num->"+approval_num);
			if(resultA !=0) {
				result =true;
			}
		} catch (Exception e) {
			System.out.println("msDao reviewExists error->"+ e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	//approvalnum가져오기
	@Override
	public String approval(String user_id, long sell_num) {
		System.out.println("msDao approval_num start...");
		String approval_num = null;
		System.out.println("msDao approval_num user_id..."+user_id);
		System.out.println("msDao approval_num sell_num..."+sell_num);
		try {
			approval_num = session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.approval",Map.of("user_id", user_id,"sell_num", sell_num));
		} catch (Exception e) {
			System.out.println("msDao approval_num error..."+e.getMessage());
		}
		return approval_num;
	}

	//회원탈퇴
	@Override
	public void taltwae(String user_id) {
		System.out.println("msDao taltwae start...");
		int result =0;
		try {
			result = session.update("com.oracle.jmAuto.dto.Mapper.ms.taltwae",user_id);
			System.out.println("msDao taltwae result->"+result);
			
		} catch (Exception e) {
			System.out.println("msDao taltwae error->"+ e.getMessage());
		}
		
	}

	//내가 작성한 후기
	@Override
	public List<Review> myhoogiDetail(String user_id, String approval_num) {
		System.out.println("msDao myhoogiDetail start...");
		System.out.println("msDao myhoogiDetail user_id, approval_num->"+ user_id+ approval_num);
		List<Review> myhoogi = null;
		try {
			myhoogi = session.selectList("com.oracle.jmAuto.dto.Mapper.ms.myhoogiDetail",Map.of("user_id",user_id,"approval_num", approval_num));
			System.out.println("msDao myhoogiDetail myhoogi->"+myhoogi);
		} catch (Exception e) {
			System.out.println("msDao myhoogiDetail error->"+ e.getMessage());
		}
		return myhoogi;
	}

	//회원정보수정시 정보값 가져오기
	@Override
	public User_Table user(String user_id) {
		System.out.println("msDao user start...user_id"+ user_id);
		User_Table user = null;
		try {
			user=session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.user", user_id);
			System.out.println("msDao user user->"+user);
		} catch (Exception e) {
			System.out.println("msDao user error->"+e.getMessage());
		}
		return user;
	}

	//판매자-판매중인 차량 삭제
	@Override
	public int deletesell(String user_id, List<Long> sell_num) {
		System.out.println("msDao deletesell start..");
		System.out.println("msDao deletesell sell_num->"+sell_num);
		int sellcarD = 0;
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("user_id", user_id);
			params.put("sell_num", sell_num);
			
			sellcarD = session.update("com.oracle.jmAuto.dto.Mapper.ms.sellcarD",params);
			System.out.println("msDao deletesellcar sellcarD->"+sellcarD);
			System.out.println("msDao deletesell params->"+user_id + sell_num);
		} catch (Exception e) {
			System.out.println("msDao deletesellcar error->"+e.getMessage());
		}
		return sellcarD;
	}

	//del_state
	@Override
	public Review del_state(String approval_num) {
		System.out.println("msDao del_state start...");
		Review review = null;
		try {
			review= session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.del_state",approval_num);
			System.out.println("msDao del_state review->"+review);
		} catch (Exception e) {
			System.out.println("msDao del_state error->"+e.getMessage());
		}
		return review;
	}

	//문의 상세 내역 삭제
	@Override
	public int qnaDetailDelete(String user_id, Long qna_num) {
		System.out.println("msDao qnaDetailDelete start...");
		System.out.println("msDao qnaDetailDelete user_id..."+user_id);
		System.out.println("msDao qnaDetailDelete qna_num..."+qna_num);
		
		int resultTot = 0;
		try {
		     int result = session.update("com.oracle.jmAuto.dto.Mapper.ms.qnaDetailDelete", Map.of("user_id", user_id, "qna_num", qna_num));
		     resultTot += result;		    
		     System.out.println("총 삭제된 게시물 수: " + resultTot);
		 } catch (Exception e) {
		     System.out.println("msDao qnaDetailDelete error -> " + e.getMessage());
		}
		return resultTot;
	}

	//hoogi작성할래 볼래 냅둘래
	@Override
	public Review hoogiya(String user_id, String approval_num) {
		System.out.println("msDao hoogiya start...");
		System.out.println("msDao hoogiya user_id..."+user_id);
		System.out.println("msDao hoogiya approval_num..."+approval_num);
		Review review = null;
		try {
			review= session.selectOne("com.oracle.jmAuto.dto.Mapper.ms.hoogiya",Map.of("user_id",user_id,"approval_num", approval_num));
			System.out.println("msDao hoogiya review->"+review);
		} catch (Exception e) {
			System.out.println("msDao hoogiya error->"+e.getMessage());
		}
		return review;
	}




}

