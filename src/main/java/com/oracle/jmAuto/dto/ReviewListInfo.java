package com.oracle.jmAuto.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewListInfo {

	// REVIEW 테이블: 이용자 리뷰
	private String 		approval_num;    //승인번호 (pk, PAYMENT와도 겹침)
	private String  	review_title;    //후기제목
	private String  	review_content;  //후기내용
	private Date 		review_date;     //후기날짜
	private int     	evaluation;      //구매평점
	private String  	file_url;        //후기파일경로
	private String  	file_name1;      //후기파일이름1
	private String  	file_name2;      //후기파일이름2
	private String  	file_name3;      //후기파일이름3
	
	// CAR_GENERAL_INFO: 차량정보
	private long    	sell_num;		// 매물번호 (pk, CAR_IMAGE와도 겹침)
    private int    		car_type;       // 차종
    private String 		fuel;			// 연료
    private String		brand;          // 제조사
    private String     	model;          // 모델
    private String     	mileage;        // 주행거리
  
	
	// PAYMENT: 결제 정보 
	private String 		user_id; 			//구매자(아이디) (pk, REVIEW와도 겹침)
	private String		receiver_name;		//업체명 
	private int			buy_type;			//결제구분	
	
	// CAR_IMAGE: 차량정보
	private int       	img_num;  		//이미지 번호 (pk)
	private String    	img_name;		//이미지 이름
	private String    	img_url;  		//이미지 경로
	
	//oracle에서 따로 만든 컬럼
	private String manu_date_char;
			
	// Paging 작업위해 만듬
	private int		start;
	private int		end;
	private String	currentPage;
	

}
