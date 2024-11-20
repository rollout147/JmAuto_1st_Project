package com.oracle.jmAuto.dto;

import java.util.Date;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class Faq {		// 자주묻는질문
	private int		faq_num;		// 자주질문번호
	private String	faq_cls;		// 자주질문분류
	private String	faq_title;		// 자주질문제목
	private String	faq_content;	// 자주질문내용
	private Date	faq_date;		// 자주질문날짜
	private String	user_id;		// 관리자 아이디
	private int		del_state;		// 삭제여부
	
	
}
