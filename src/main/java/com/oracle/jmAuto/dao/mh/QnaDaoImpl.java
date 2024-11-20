package com.oracle.jmAuto.dao.mh;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.hibernate.internal.build.AllowSysOut;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Qna;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class QnaDaoImpl implements QnaDao {
	
	private final SqlSession session;
	

	@Override
	public int totalQnaCount(String keyword) {
		System.out.println("QnaDaoImpl totalQnaCount start...");
		int totalQna = 0;
		
		try {
			totalQna = session.selectOne("com.oracle.jmAuto.dto.Mapper.mh.QnaCount",keyword);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return totalQna;
	}


	@Override
	public List<Qna> listQnaPage(int startIndex, int endIndex, String keyword) {
		System.out.println("QnaDaoImpl listQnaPage start...");
		List<Qna> qnaPageList = null;
		Map<String, Object> parm = new HashMap<>();
		parm.put("startIndex", startIndex);
		parm.put("endIndex", endIndex);
		parm.put("keyword", keyword);
		
		try {
			qnaPageList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.PageListQna", parm);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return qnaPageList;
	}


	@Override
	public int submitAnswer(int qnaNum, String answer) {
		int updateAnswer = 0;
		System.out.println("QnaDaoImpl submitAnswer start...");
		Map<String, Object> params = new HashMap<>();
		params.put("qnaNum",qnaNum);
		params.put("answer", answer);
		
		try {
			updateAnswer = session.update("com.oracle.jmAuto.dto.Mapper.mh.submitAnswerList", params);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return updateAnswer;
	}


	@Override
	public int totalQnaCountS() {
		System.out.println("QnaDaoImpl totalQnaCount start...");
		int totalQnas = 0;
		
		try {
			totalQnas = session.selectOne("com.oracle.jmAuto.dto.Mapper.mh.QnaCountS");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return totalQnas;
	}


	@Override
	public int getUseynQna(int qnaNum) {
		System.out.println("QnaDaoImpl getUseynQna start...");
		int useYn = 0;
		
		try {
			useYn = session.selectOne("com.oracle.jmAuto.dto.Mapper.mh.getUseYnQna",qnaNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return useYn;
	}


	@Override
	public int totalQnaCountA(Integer answerStatus) {
		System.out.println("QnaDaoImpl totalQnaCount start...");
		int totalQnas = 0;
		
		try {
			totalQnas = session.selectOne("com.oracle.jmAuto.dto.Mapper.mh.QnaCountA", answerStatus);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return totalQnas;
	}


	@Override
	public List<Qna> listQnaPageA(int startIndex, int endIndex, Integer answerStatus) {
		System.out.println("QnaDaoImpl listQnaPage start...");
		List<Qna> qnaPageList = null;
		Map<String, Object> parm = new HashMap<>();
		parm.put("startIndex", startIndex);
		parm.put("endIndex", endIndex);
		parm.put("answerStatus", answerStatus);
		
		try {
			qnaPageList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.PageListQnaA", parm);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return qnaPageList;
	}

}
