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
@Table(name="account")
public class Account5 { // 계좌정보
	@Id
	private String account_num;
	private String account_name;
	private String account_bank;
		
	@OneToOne
    @JoinColumn(name="user_id") // 외래 키 컬럼 명
    private User_Table5 user;
}
