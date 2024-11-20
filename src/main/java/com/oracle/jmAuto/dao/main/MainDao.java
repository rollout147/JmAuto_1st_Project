package com.oracle.jmAuto.dao.main;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MainDao {
	private final SqlSession session;
	
	public int selectUser() {
		int result = 0;
		
		result = session.selectOne("selectUser");
		
		return result;
	}
}
