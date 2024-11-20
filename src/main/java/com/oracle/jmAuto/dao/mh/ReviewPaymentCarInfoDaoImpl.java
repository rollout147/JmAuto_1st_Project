package com.oracle.jmAuto.dao.mh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReviewPaymentCarInfoDaoImpl implements ReviewPaymentCarInfoDao {

	private final SqlSession session;
	
	@Override
	public List<ReviewPaymentCarInfoDao> listReviewInfo() {
		System.out.println("ReviewPaymentCarInfoImpl listReviewInfo start...");
		List<ReviewPaymentCarInfoDao> review = null;
		
		try {
			review = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.RevInfoList");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return review;
	}

}
