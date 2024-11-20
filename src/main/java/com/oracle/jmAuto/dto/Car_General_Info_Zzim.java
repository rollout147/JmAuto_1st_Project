package com.oracle.jmAuto.dto;

import lombok.Data;

@Data
public class Car_General_Info_Zzim {
	//Zzim 테이블
	private Long  sell_num; /*매물번호*/
	private String 	user_id;  /*구매자 아이디*/
	private int 	zzim_num; /*구분번호*/
	
	//Car_General_Info
	private String model; 
	private int price;		
	private String color;
	private String car_num;
	private String manu_date;
	private String mileage;
	private String accident;
	private String fuel;
	
	
}
