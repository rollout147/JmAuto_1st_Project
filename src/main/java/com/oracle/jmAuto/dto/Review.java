package com.oracle.jmAuto.dto;

import java.sql.Date;

import jakarta.persistence.Entity;
import lombok.Data;

@Data
public class Review {

	// REVIEW 고객후기 테이블
	private String 	user_id;         //구매자(아이디)
	private String 	approval_num;    //승인번호
	private String  review_title;    //후기제목
	private String  review_content;  //후기내용
	private Date 	review_date;     //후기날짜
	private int     evaluation;      //구매평점
	private String  file_url;       //후기파일경로1
	private String  file_name1;      //후기파일이름1
	private String  file_name2;      //후기파일이름2
	private String  file_name3;      //후기파일이름3
	private int     del_state;       //삭제여부
}
