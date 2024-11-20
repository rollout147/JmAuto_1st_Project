package com.oracle.jmAuto.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewPaymentCarInfo {
	
	//이용자 리뷰
	private String 	approval_num;    //승인번호
	private String  review_title;    //후기제목
	private String  review_content;  //후기내용
	private Date 	review_date;     //후기날짜
	private int     evaluation;      //구매평점
	private String  file_url;        //후기파일경로
	private String  file_name1;      //후기파일이름1
	private String  file_name2;      //후기파일이름2
	private String  file_name3;      //후기파일이름3
	
	//결제 정보 
	private Date	approval_date;		/* 승인일자 */	
	private long 	exper_review_num; 	/* 전문가평가번호 */
	private long	tax;				/* 세금 */
	private long	fee;				/* 대행수수료 */
	private long	total_price;		/* 결제금액 */
	private long 	buz_fee; 		 	/* 판매수수료 */
	private long	buz_money; 			/* 판매자입금액 */
	private String	receiver_name;		/* 업체명 */
	private String	receiver_tel;		/* 전화번호 */
	private String	receiver_zipcode;	/* 우편번호 */
	private String	receiver_addr1;		/* 주소 */
	private String	receiver_addr2;		/* 상세주소 */
	private String	insure_img_name;	/* 보험증명파일이름 */
	private String	insure_img_url;		/* 보험증명파일경로 */
	private Date	delivery_date;		/* 배송일자 */
	private int		buy_type;			/* 결제구분 */	 
	
	// 차량기본정보
	private long 	sell_num; 			// 매물번호
	private int 	car_type;			// 차종
	private String 	brand;				// 제조사
	private String 	model;				// 모델
	private String 	car_num;			// 차량번호
	private String 	manu_date;			// 제조일
	private String 	mileage;			// 주행거리
	private String 	color;				// 색상
	private String 	fuel;				// 연료
	private String 	transmission; 		// 변속기
	private String 	accident;			// 사고유무
	private String 	repossession;		// 압류유무
	private int 	price;				// 가격
	private String 	sell_regi;			// 자동차등록증경로
	private String 	sell_certi_tax;		// 자동차세완납증명서경로
	private String 	sell_shinbun;		// 신분증사본경로
	private String 	user_id;			// 판매자아이디
	private int 	sale;				// 판매여부
	private Date 	reg_date;			// 등록일자
	private int 	del_state; 			// 삭제여부
	
	//oracle에서 따로 만든 컬럼
	private String manu_date_char;
	private String img_url;
	
	
}
