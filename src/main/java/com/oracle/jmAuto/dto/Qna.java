package com.oracle.jmAuto.dto;

import java.sql.Date;

import jakarta.persistence.Entity;
import lombok.Data;

@Data
public class Qna {

	private int qna_num; 		// 문의번호
	private Date qna_date; 		// 문의날짜
	private String user_id; 	// 이용자(아이디)
	private String qna_cls; 	// 문의유형
	private String qna_title; 	// 문의제목
	private String qna_content; // 문의내용
	private String file_name; 	// 민원파일이름
	private String file_url; 	// 민원파일경로
	private String ans_content; // 답변내용
	private Date ans_date; 		// 답변날짜
	private int sell_num; 		// 매물번호
	private int qna_useyn; 		// 문의확인
	private int del_state; 		// 삭제여부

}
