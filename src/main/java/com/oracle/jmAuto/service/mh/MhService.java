package com.oracle.jmAuto.service.mh;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;

import com.oracle.jmAuto.dao.mh.Car_General_InfoDao;
import com.oracle.jmAuto.dao.mh.Expert_ReviewDao;
import com.oracle.jmAuto.dao.mh.FaqDao;
import com.oracle.jmAuto.dao.mh.Notice_TableDao;
import com.oracle.jmAuto.dao.mh.ReviewDao;
import com.oracle.jmAuto.dao.mh.ReviewPaymentCarInfoDao;
import com.oracle.jmAuto.dao.mh.User_TableDao;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Faq;
import com.oracle.jmAuto.dto.Notice_Table;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Zzim;


public interface MhService {

	int ReviewListCount();

	List<Expert_ReviewDao> ListReview();

	List<Car_General_InfoDao> CarList();

	List<ReviewDao> reviewList();

	List<Expert_ReviewDao> expList();

	List<ReviewPaymentCarInfoDao> reviewInfoList();

	List<Notice_TableDao> noticeList();

	List<Car_General_InfoDao> SearchCarList(String keyword, int searchType);

	List<Car_General_InfoDao> CarInfoList(String sellNum);

	List<User_TableDao> userInfo(String id);

	List<Expert_ReviewDao> selExpList(String sellNum);

	List<FaqDao> faqList();

	void zzimInsert(Zzim zzim);

	List<Map<String, Object>> autocomplete(Map<String, Object> paramMap);

	List<Car_Image> selListImg(String sellNum);

	List<Faq> selFaqList(Integer faqNum);

	int updateFaq(Faq faqlist);

	int insertFaq(Faq faqInsList);

	int delectFaq(String faqNum);

	int exposFaq(String faqNum);

	int qnaTotalCount(String keyword);

	List<Qna> qnaListPage(int startIndex, int endIndex, String keyword);

	int answerSubmit(int qnaNum, String answer);

	int delGogiTable(String noticeNum);

	int exposGogi(String noticeNum);

	List<Notice_TableDao> notListstate();

	List<Notice_Table> selNotList(Integer notNum);

	int updateNotGogi(Notice_Table notlist);

	int insertNotice(Notice_Table notInsList);

	int qnaTotalCountS();

	int getQnaUseYn(int qnaNum);

	int qnaTotalCountA(Integer answerStatus);

	List<Qna> qnaListPageA(int startIndex, int endIndex, Integer answerStatus);
}
