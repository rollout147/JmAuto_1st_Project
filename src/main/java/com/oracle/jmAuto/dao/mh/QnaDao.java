package com.oracle.jmAuto.dao.mh;

import java.util.List;

import com.oracle.jmAuto.dto.Qna;

public interface QnaDao {

	int totalQnaCount(String keyword);

	List<Qna> listQnaPage(int startIndex, int endIndex, String keyword);

	int submitAnswer(int qnaNum, String answer);

	int totalQnaCountS();

	int getUseynQna(int qnaNum);

	int totalQnaCountA(Integer answerStatus);

	List<Qna> listQnaPageA(int startIndex, int endIndex, Integer answerStatus);

}
