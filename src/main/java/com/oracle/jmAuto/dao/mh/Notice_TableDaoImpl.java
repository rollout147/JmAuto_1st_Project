package com.oracle.jmAuto.dao.mh;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Notice_Table;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class Notice_TableDaoImpl implements Notice_TableDao {
	private final SqlSession session;

	@Override
	public List<Notice_TableDao> listnotice() {
		System.out.println("Notice_TableImpl listnotice start...");
		List<Notice_TableDao> notList = null;
		
		try {
			notList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.notList");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return notList;
	}

	@Override
	public int delTableGogi(String noticeNum) {
		System.out.println("Notice_TableImpl delTableGogi start...");
		int notNumUpdate = 0;
		
		try {
			notNumUpdate = session.update("com.oracle.jmAuto.dto.Mapper.mh.delNotTable", noticeNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return notNumUpdate;
	}

	@Override
	public int exposGogi(String noticeNum) {
		System.out.println("Notice_TableImpl exposGogi start...");
		int notNumUd = 0;
		
		try {
			notNumUd = session.update("com.oracle.jmAuto.dto.Mapper.mh.exposNotTable", noticeNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return notNumUd;
	}

	@Override
	public List<Notice_TableDao> listNotState() {
		System.out.println("Notice_TableImpl listNotState start...");
		List<Notice_TableDao> listNot = null;
		
		try {
			listNot = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.listTableNot");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return listNot;
	}

	@Override
	public List<Notice_Table> notSelList(Integer notNum) {
		System.out.println("Notice_TableImpl notSelList start...");
		List<Notice_Table> selNot = null;
		
		try {
			selNot = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.selListNotTable", notNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return selNot;
	}

	@Override
	public int notUpdateGogi(Notice_Table notlist) {
		System.out.println("Notice_TableImpl notUpdateGogi start...");
		int gogiUpdate = 0;
		
		try {
			gogiUpdate = session.update("com.oracle.jmAuto.dto.Mapper.mh.updateGoginot", notlist);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return gogiUpdate;
	}

	@Override
	public int noticeInsert(Notice_Table notInsList) {
		System.out.println("Notice_TableImpl noticeInsert start...");
		int notListInsert = 0;
		
		try {
			notListInsert = session.insert("com.oracle.jmAuto.dto.Mapper.mh.InsNoticeList", notInsList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return notListInsert;
	}

	
	
}
