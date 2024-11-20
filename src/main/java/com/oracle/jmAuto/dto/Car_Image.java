package com.oracle.jmAuto.dto;

import lombok.Data;

@Data
public class Car_Image {
	
	 private int         sell_num; //매물번호
	 private String    	 img_name; //이미지 이름
	 private String    	 img_url;  //이미지 경로
	 private int         img_num;  //이미지 번호 (pk)
	
}
