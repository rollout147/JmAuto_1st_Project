package com.oracle.jmAuto.dao.mh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Faq;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class FaqDaoImpl implements FaqDao {
	private final SqlSession session;

	@Override
	public List<FaqDao> allFaqList() {
		List<FaqDao> faqAllList = null;
		System.out.println("FaqDaoImpl allFaqList start...");
		
		try {
			faqAllList = session.selectList("com.oracle.jmAuto.FaqMapper.mh.allFaqList");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return faqAllList;
	}

	@Override
	public List<Faq> selFaqList(Integer faqNum) {
		List<Faq> faqList = null;
		System.out.println("FaqDaoImpl selFaqList start...");
		
		try {
			faqList = session.selectList("com.oracle.jmAuto.FaqMapper.mh.selFaqList", faqNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return faqList;
	}

	@Override
	public int updateFaq(Faq faqlist) {
		int faqup = 0;
		System.out.println("FaqDaoImpl updateFaq start...");
		
		try {
			faqup = session.update("com.oracle.jmAuto.FaqMapper.mh.updateFaq", faqlist);
			System.out.println("faqup ==> " + faqup);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return faqup;
	}

	@Override
	public int instFaqList(Faq faqInsList) {
		System.out.println("FaqDaoImpl instFaqList start...");
		int faqInsert = 0;
		
		try {
			faqInsert = session.insert("com.oracle.jmAuto.FaqMapper.mh.insrtFaqList", faqInsList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return faqInsert;
	}

	@Override
	public int delFaq(String faqNum) {
		int faqListFaq = 0;
		System.out.println("FaqDaoImpl delFaq start...");
		
		try {
			faqListFaq = session.update("com.oracle.jmAuto.FaqMapper.mh.delFaqList", faqNum);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return faqListFaq;
	}

	@Override
	public int exposFaq(String faqNum) {
		int faqListFaq = 0;
		System.out.println("FaqDaoImpl exposFaq start...");
		
		try {
			faqListFaq = session.update("com.oracle.jmAuto.FaqMapper.mh.exposFaqList", faqNum);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return faqListFaq;
	}
	
	
}
