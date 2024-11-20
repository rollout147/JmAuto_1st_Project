package com.oracle.jmAuto.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class FullUserInfo {
	private String user_id;  			// 아이디
	private String user_pw;			// 비밀번호
	private String user_name;		// 이름
	private String user_tel;				// 전화번호
	private String user_zipcode;	// 우편번호
	private String user_addr1;		// 주소
	private String user_addr2;		// 상세주소
	private String user_email;		// 이메일
	private Date user_regdate;		// 가입일자	
	private String buz_num;			// 사업자번호
	private String cert_num;			// 자격증번호
	private String user_level;			// 등급
	private String user_type;			// 사용자유형
	private int del_state;					// 탈퇴여부
	private String approval;			// 승인여부
	private String introduction;		// 소개
    
	private String buz_name;
	private String buz_addr;
	private String Buz_filename;
	private String buz_url;
	
	private String cert_name;
	private String cert_loc;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date cert_date;
	private String cert_filename;
	private String cert_url;
	
	private String account_num;
	private String account_name;
	private String account_bank;
	

}
