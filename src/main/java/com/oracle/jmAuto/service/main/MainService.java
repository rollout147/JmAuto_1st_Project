package com.oracle.jmAuto.service.main;

import org.springframework.stereotype.Service;

import com.oracle.jmAuto.dao.main.MainDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainService {
	private final MainDao md;
	
	public int SelectUser() {
		int result = 0;
		result = md.selectUser();
		
		return result;
	}
	
	
}
