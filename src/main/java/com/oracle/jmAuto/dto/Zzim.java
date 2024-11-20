package com.oracle.jmAuto.dto;

import lombok.Data;

@Data
public class Zzim {
	
	private Long  sell_num; /*매물번호*/
	private String 	user_id;  /*구매자 아이디*/
	private int 	zzim_num; /*구분번호*/
	
	private String model; 	//차량 모델 (미숙 추가 - 나의 구매, 관심 목록등에 뿌려줄 값)
	private int price;		//차량 가격
	private String color;
	private String car_num;
	private String manu_date;
	private String mileage;
	private String accident;
	private String fuel;
	private String img_name;
	private String img_url;
	private String car_user_id;
	
}
