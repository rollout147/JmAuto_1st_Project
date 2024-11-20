package com.oracle.jmAuto.service.mh;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dao.mh.Car_General_InfoDao;
import com.oracle.jmAuto.dao.mh.Expert_ReviewDao;
import com.oracle.jmAuto.dao.mh.FaqDao;
import com.oracle.jmAuto.dao.mh.Notice_TableDao;
import com.oracle.jmAuto.dao.mh.QnaDao;
import com.oracle.jmAuto.dao.mh.ReviewDao;
import com.oracle.jmAuto.dao.mh.ReviewPaymentCarInfoDao;
import com.oracle.jmAuto.dao.mh.User_TableDao;
import com.oracle.jmAuto.dao.mh.ZzimDao;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Faq;
import com.oracle.jmAuto.dto.Notice_Table;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Zzim;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MhServiceImpl implements MhService {
	private final Expert_ReviewDao 	   		exr;
	private final Car_General_InfoDao 	   	cgi;
	private final ReviewDao 			   	rv;
	private final ReviewPaymentCarInfoDao 	rpc;
	private final Notice_TableDao		   	nt;
	private final User_TableDao		   		ut;
	private final FaqDao					faq;
	private final ZzimDao					zz;
	private final QnaDao					qna;
	
	@Override
	public int ReviewListCount() {
		System.out.println("MhServiceImpl ReviewListCount start...");
		int expert = exr.listReviewCount();
		return expert;
	}

	@Override
	public List<Expert_ReviewDao> ListReview() {
		System.out.println("MhServiceImpl ListReview start...");
		List<Expert_ReviewDao> revuewList = exr.listReview();
		
		return revuewList;
	}

	@Override
	public List<Car_General_InfoDao> CarList() {
		System.out.println("MhServiceImpl CarList start...");
		List<Car_General_InfoDao> carInfo = cgi.CarList();
		
		return carInfo;
	}

	@Override
	public List<ReviewDao> reviewList() {
		System.out.println("MhServiceImpl reviewList start...");
		List<ReviewDao> review = rv.ReviewList();
		
		return review;
	}

	@Override
	public List<Expert_ReviewDao> expList() {
		System.out.println("MhServiceImpl expList start...");
		List<Expert_ReviewDao> exp_list = exr.expList();
		return exp_list;
	}

	@Override
	public List<ReviewPaymentCarInfoDao> reviewInfoList() {
		System.out.println("MhServiceImpl reviewInfoList start...");
		return rpc.listReviewInfo();
	}

	@Override
	public List<Notice_TableDao> noticeList() {
		System.out.println("MhServiceImpl noticeList start...");
		return nt.listnotice();
	}

	@Override
	public List<Car_General_InfoDao> SearchCarList(String keyword, int searchType) {
		System.out.println("MhServiceImpl SearchCarList start...");
		
		return cgi.carSearchList(keyword, searchType);
	}

	@Override
	public List<Car_General_InfoDao> CarInfoList(String sellNum) {
		System.out.println("MhServiceImpl CarInfoList start...");
		
		return cgi.carInfoList(sellNum);
	}

	@Override
	public List<User_TableDao> userInfo(String id) {
		System.out.println("MhServiceImpl userInfo start...");
		return ut.tableUser(id);
	}

	@Override
	public List<Expert_ReviewDao> selExpList(String sellNum) {
		System.out.println("MhServiceImpl selExpList start...");
		return exr.selExpList(sellNum);
	}

	@Override
	public List<FaqDao> faqList() {
		System.out.println("MhServiceImpl selExpList start...");
		return faq.allFaqList();
	}

	@Override
	public void zzimInsert(Zzim zzim) {
		System.out.println("MhServiceImpl zzimInsert start...");
		zz.insertZzim(zzim);
	}

	@Override
	public List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) {
		System.out.println("MhServiceImpl autocomplete start...");
		return cgi.autocomplete(paramMap);
	}

	@Override
	public List<Car_Image> selListImg(String sellNum) {
		System.out.println("MhServiceImpl selListImg start...");
		List<Car_Image> carList = cgi.selListImg(sellNum);
		
		return carList;
	}

	@Override
	public List<Faq> selFaqList(Integer faqNum) {
		System.out.println("MhServiceImpl selFaqList start...");
		return faq.selFaqList(faqNum);
	}

	@Override
	public int updateFaq(Faq faqlist) {
		System.out.println("MhServiceImpl updateFaq start...");
		return faq.updateFaq(faqlist);
	}

	@Override
	public int insertFaq(Faq faqInsList) {
		System.out.println("MhServiceImpl insertFaq start...");
		return faq.instFaqList(faqInsList);
	}

	@Override
	public int delectFaq(String faqNum) {
		System.out.println("MhServiceImpl insertFaq start...");
		
		return faq.delFaq(faqNum);
	}

	@Override
	public int exposFaq(String faqNum) {
		System.out.println("MhServiceImpl insertFaq start...");
		
		return faq.exposFaq(faqNum);
	}

	@Override
	public int qnaTotalCount(String keyword) {
		System.out.println("MhServiceImpl qnaTotalCount start...");
		return qna.totalQnaCount(keyword);
	}

	@Override
	public List<Qna> qnaListPage(int startIndex, int endIndex, String keyword) {
		System.out.println("MhServiceImpl qnaListPage start...");
		return qna.listQnaPage(startIndex, endIndex, keyword);
	}

	@Override
	public int answerSubmit(int qnaNum, String answer) {
		System.out.println("MhServiceImpl qnaListPage start...");
		return qna.submitAnswer(qnaNum, answer);
	}

	@Override
	public int delGogiTable(String noticeNum) {
		System.out.println("MhServiceImpl qnaListPage start...");
		return nt.delTableGogi(noticeNum);
	}

	@Override
	public int exposGogi(String noticeNum) {
		System.out.println("MhServiceImpl exposGogi start...");
		return nt.exposGogi(noticeNum);
	}

	@Override
	public List<Notice_TableDao> notListstate() {
		System.out.println("MhServiceImpl notListstate start...");
		return nt.listNotState();
	}

	@Override
	public List<Notice_Table> selNotList(Integer notNum) {
		System.out.println("MhServiceImpl selNotList start...");
		return nt.notSelList(notNum);
	}

	@Override
	public int updateNotGogi(Notice_Table notlist) {
		System.out.println("MhServiceImpl updateNotGogi start...");
		return nt.notUpdateGogi(notlist);
	}

	@Override
	public int insertNotice(Notice_Table notInsList) {
		System.out.println("MhServiceImpl insertNotice start...");
		return nt.noticeInsert(notInsList);
	}

	@Override
	public int qnaTotalCountS() {
		System.out.println("MhServiceImpl qnaTotalCountS start...");
		return qna.totalQnaCountS();
	}

	@Override
	public int getQnaUseYn(int qnaNum) {
		System.out.println("MhServiceImpl getQnaUseYn start...");
		return qna.getUseynQna(qnaNum);
	}

	@Override
	public int qnaTotalCountA(Integer answerStatus) {
		System.out.println("MhServiceImpl qnaTotalCountA start...");
		return qna.totalQnaCountA(answerStatus);
	}

	@Override
	public List<Qna> qnaListPageA(int startIndex, int endIndex, Integer answerStatus) {
		System.out.println("MhServiceImpl qnaListPageA start...");
		return qna.listQnaPageA(startIndex, endIndex, answerStatus);
	}
	
}
