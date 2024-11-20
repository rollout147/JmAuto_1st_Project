package com.oracle.jmAuto.dao.mh;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Zzim;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ZzimDaoImpl implements ZzimDao {
	private final SqlSession session;
	
	@Override
	public void insertZzim(Zzim zzim) {
		System.out.println("ZzimDaoImpl insertZzim start...");
		
		try {
			session.insert("com.oracle.jmAuto.dto.Mapper.mh.insZzimList", zzim);
			
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
