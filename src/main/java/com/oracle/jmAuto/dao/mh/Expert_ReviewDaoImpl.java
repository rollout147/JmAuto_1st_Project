package com.oracle.jmAuto.dao.mh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class Expert_ReviewDaoImpl implements Expert_ReviewDao {
	private final SqlSession session;

	@Override
	public int listReviewCount() {
		System.out.println("Expert_ReviewImpl listReviewCount start....");
		int expert = 0;
		
		try {
			expert = session.selectOne("com.oracle.jmAuto.dto.Mapper.mh.ReviewList");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return expert;
	}

	@Override
	public List<Expert_ReviewDao> listReview() {
		System.out.println("Expert_ReviewImpl listReview start...");
		List<Expert_ReviewDao> listReview = null;
		
		try {
			listReview = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.ListReview");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return listReview;
	}

	@Override
	public List<Expert_ReviewDao> expList() {
		List<Expert_ReviewDao> expList = null;
		System.out.println("Expert_ReviewImpl expList start...");
		
		try {
			expList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.ListReview");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return expList;
	}

	@Override
	public List<Expert_ReviewDao> selExpList(String sellNum) {
		List<Expert_ReviewDao> selListExp = null;
		System.out.println("Expert_ReviewImpl selExpList start...");
		
		try {
			selListExp = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.selExp_Revlist", sellNum);
			System.out.println("Expert_ReviewImpl selExpList selListExp.size() => " + selListExp.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return selListExp;
	}
}
