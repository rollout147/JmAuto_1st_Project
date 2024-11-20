package com.oracle.jmAuto.dao.mh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class User_TableDaoImpl implements User_TableDao {
	private final SqlSession session;

	@Override
	public List<User_TableDao> tableUser(String id) {
		System.out.println("User_TableImpl tableUser start...");
		List<User_TableDao> userList = null;
		System.out.println("id>>>>>>>"+id);
		try {
			userList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.InfoUserSel",id);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return userList;
	}
	
	
}
