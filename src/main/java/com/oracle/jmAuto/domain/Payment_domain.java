package com.oracle.jmAuto.domain;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Table(name = "PAYMENT")
@Data
public class Payment_domain {
	
	private String 	user_id; 			/* 구매자(아이디) */ 
	@Id
	private String 	approval_num;		//승인번호
	private Date	approval_date;		/* 승인일자 */	
	private int		sell_num;			/* 매물번호 */
	private int 	exper_review_num; 	/* 전문가평가번호 */
	private int		price;				/* 가격 */
	private int		tax;				/* 세금 */
	private int		fee;				/* 대행수수료 */
	private int		total_price;		/* 결제금액 */
	private int 	buz_fee; 		 	/* 판매수수료 */
	private int		buz_money; 			/* 판매자입금액 */
	private String	receiver_name;		/* 업체명 */
	private String	receiver_tel;		/* 전화번호 */
	private String	receiver_zipcode;	/* 우편번호 */
	private String	receiver_addr1;		/* 주소 */
	private String	receiver_addr2;		/* 상세주소 */
	private String	insure_img_name;	/* 보험증명파일이름 */
	private String	insure_img_url;		/* 보험증명파일경로 */
	private Date	delivery_date;		/* 배송일자 */
	private int		buy_type;			/* 결제구분 */	 
}
