package com.oracle.jmAuto.dto;

import java.util.Date;

import lombok.Data;

@Data
public class KakaoPayReadyResponse {
	private String 	tid;
    private String 	next_redirect_pc_url;
    private Date 	created_at;
}
