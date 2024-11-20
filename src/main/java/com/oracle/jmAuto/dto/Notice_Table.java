package com.oracle.jmAuto.dto;

import java.util.Date;

import jakarta.validation.constraints.NotEmpty;
import lombok.Data;

@Data
public class Notice_Table {			// 공지사항 및 약관
	
	private int		notice_num;		// 공지사항번호
	private String	notice_cls;		// 공지사항분류 (공지사항 or 약관)
	private String	notice_title;	// 공지사항제목
	private String	notice_content;	// 공지사항내용
	private Date	notice_date;	// 공지사항날짜
	private String	file_name;		// 공지사항이름
	private String	file_url;		// 공지파일경로
	private String	user_id;		// 관리자 아이디
	private int		del_state;		// 삭제여부
	
	// Page 정보
	private String	currentPage;

}
