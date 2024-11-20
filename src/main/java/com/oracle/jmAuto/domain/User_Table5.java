package com.oracle.jmAuto.domain;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name="user_table")
public class User_Table5 {
	@Id
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_tel;
	private String user_zipcode;
	private String user_addr1;
	private String user_addr2;
	private String user_email;
	private Date user_regdate;
	private String buz_num;
	private String cert_num;
	private String user_level;
	private String user_type;
	private int del_state;
	private String approval;
	
	@OneToOne(mappedBy = "user") // 'Account5'에서 'user' 필드에 의해 매핑됨
    private Account5 account5;

}
