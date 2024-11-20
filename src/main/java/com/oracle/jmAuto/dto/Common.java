package com.oracle.jmAuto.dto;

import lombok.Data;

/*공통테이블 (분류 테이블)*/
@Data
public class Common {
	
	private int 	car_type; /*대분류 번호(차종)*/
	private int 	brand;   /*중분류(제조사)*/
	private String 	content;  /*내역*/
	private String 	notice;   /*비고*/
	
}
