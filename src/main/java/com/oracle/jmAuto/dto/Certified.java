package com.oracle.jmAuto.dto;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;
@Data
public class Certified { // 전문가
	private String cert_num;
	private String cert_name;
	private String cert_loc;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date cert_date;
	private String cert_filename;
	private String cert_url;
}
