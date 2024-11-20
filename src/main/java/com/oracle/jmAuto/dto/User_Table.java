package com.oracle.jmAuto.dto;

import java.util.Date;

import lombok.Data;

@Data
public class User_Table {
	private String user_id;  		// 아이디
	private String user_pw;			// 비밀번호
	private String user_name;		// 이름
	private String user_tel;		// 전화번호
	private String user_zipcode;	// 우편번호
	private String user_addr1;		// 주소
	private String user_addr2;		// 상세주소
	private String user_email;		// 이메일
	private Date user_regdate;		// 가입일자	
	private String buz_num;			// 사업자번호
	private String cert_num;		// 자격증번호
	private String user_level;		// 등급
	private String user_type;		// 사용자유형
	private int del_state;			// 탈퇴여부
	private String approval;		// 승인여부
	private String introduction;	// 소개
	
	private String region;          // oracle에서 만든 컬럼 (지역)
    private String buz_name;        // oracle Join용 사업장 주소
    private String buz_addr;        // oracle Join용 사업장 이름 주소
    

}
