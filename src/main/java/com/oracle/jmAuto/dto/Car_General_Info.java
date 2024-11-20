package com.oracle.jmAuto.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class Car_General_Info {
    private long    	 sell_num;             // 매물번호
    private int    		 car_type;            // 차종
    private String     brand;                // 제조사
    private String     model;                // 모델
    private String     car_num;            // 차량번호
    private String     manu_date;            // 제조일
    private String     mileage;            // 주행거리
    private String     color;                // 색상
    private String     fuel;                // 연료
    private String     transmission;         // 변속기
    private String     accident;            // 사고유무
    private String     repossession;        // 압류유무
    private int     			price;                // 가격
    private String     sell_regi;            // 자동차등록증경로
    private String     sell_certi_tax;        // 자동차세완납증명서경로
    private String     sell_shinbun;        // 신분증사본경로
    private String     user_id;            // 판매자아이디
    private int     		sale;                // 판매여부
    private Date     reg_date;            // 등록일자
    private int     		del_state;             // 삭제여부

    // Buffer용
    private String     manu_date_yy;            // 제조년 (둘이 합쳐서 제조일)
    private String     manu_date_mm;            // 제조월 (둘이 합쳐서 제조일)

    // 조회용
    private String searchkeyword;    //서치 키워드 (성희 추가)
    private String model_name;        //모델이름 검색 (성희 추가)
    private int   	 min_price;        //최소예산 검색 (성희 추가)
    private int       max_price;        //최대예산 검색 (성희 추가)
    private String img_url;            //검색하면 나오는 메인이미지 담기 위함
    private String img_name;

    private String pageNum;            //페이지 번호 (성희 추가)
    private int start;                //매물 시작 번호 (성희 추가)
    private int end;                //매물 끝 번호 (성희 추가)
    private String currentPage;        //현재 페이지 정보 (성희 추가)
    private int total;                //전체 매물 수 저장용..(페이지 가져옴) (성희 추가)
    private String url;                //체이지 이동 시 담을 url값(서치 구분용)
    
    // 상세 페이지용 
    private String     tax;                    	// oracle 가격의 10% 세금
    private String     agency_fee;            	// oracle 가격의 5% / 2 대행 수수료
    private String     sum_price;            	// oracle 가격 + 세금 + 대행 수수료 합계
    private String 	   price_fre;               // oracle 가격 ',' / * 10000 추가한 가격
    private String     munu_date_cos;         	// oracle 커스텀 컬럼(연식 표현식)
    private String     years_passed;          	// oracle 년도 빼서 지난 연도
    private String     mon_passed;            	// oracle 월 빼서 지난 월
    
    
    // 마이페이지용
	private String 		approval_num;
	private Date 		approval_date;
	private String 		receiver_name;
    
    
}