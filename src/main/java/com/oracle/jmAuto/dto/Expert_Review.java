package com.oracle.jmAuto.dto;

import java.util.Date;

import lombok.Data;

@Data
public class Expert_Review {
	
	private long	expert_review_num;		/* 전문가평가번호 */
	private long	sell_num;				/* 매물번호 */
	private Date	write_date;				/* 작성일 */
	private int		score;					/* 평가점수 */
	private String	content;				/* 평가내용 */
	private String	user_id;				/* 전문가(아이디) */
	private int		ess_state;				/* 기본상태 */
	private int		ess_mileage;			/* 기본주행거리 */
	private int		ess_regi;				/* 기본등록증 */
	private int		egine_oil;				/* 소모엔진오일 */
	private int		brake_oil;				/* 소모브레이크오일 */
	private int		coolant;				/* 소모냉각수 */
	private int		tire;					/* 소모타이어 */
	private int		brake_pad;				/* 소모브레이크패드 */
	

	private String  model; 					/* 차리스트에 모델명 */
	private int		del_state;				/* 삭제여부 */
	
	
	// 마이페이지용 
	private String color; 					/* 미숙 추가 전문가 리뷰 작성 리스트 */
	private long price;
	private long total_price;
	private String car_num;
	private String img_url; // 검색하면 나오는 메인이미지 담기 위함
	private String img_name;


	//페이징용 
	private String pageNum;            //페이지 번호 (성희 추가)
	private int start;                //매물 시작 번호 (성희 추가)
	private int end;                //매물 끝 번호 (성희 추가)
	private String currentPage;        //현재 페이지 정보 (성희 추가)
	private int total;                //전체 매물 수 저장용..(페이지 가져옴) (성희 추가)
	
	//날짜포맷용
		private String formatted_write_date;	//db date sql에서 포맷해서 가져오는 용도
}
