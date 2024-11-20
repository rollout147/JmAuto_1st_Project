package com.oracle.jmAuto.dto;

import lombok.Data;

@Data
public class Account { // 계좌정보
	private String account_num;
	private String account_name;
	private String account_bank;
	private String user_id;
}
