package com.oracle.jmAuto.dto;

import java.sql.Date;

import lombok.Data;

/*쪽지*/
@Data
public class Note {
	
	private Long 	sell_num; 		/*매물 번호*/
	private Long 	note_num; 		/*쪽지 번호*/
	private String 	note_sd; 		/*구매자*/
	private String 	note_rd; 		/*판매자*/
	private String 	note_title; 	/*쪽지 제목*/
	private String 	note_content; 	/*쪽지 내용*/
	private Date 	note_date; 		/*쪽지 작성시간*/
	private int 	del_state; 		/*쪽지 삭제여부*/
	private int 	send_state; 	/*쪽지 상태 (읽음, 읽지않음)*/
}
