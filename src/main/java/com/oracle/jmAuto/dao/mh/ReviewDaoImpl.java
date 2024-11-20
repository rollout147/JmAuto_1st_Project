package com.oracle.jmAuto.dao.mh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReviewDaoImpl implements ReviewDao {
	private final SqlSession session;

	@Override
	public List<ReviewDao> ReviewList() {
		System.out.println("ReviewImpl ReviewList start....");
		List<ReviewDao> review = null;
		
		try {
			review = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.ReviewListS");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return review;
	}

	
	
}
