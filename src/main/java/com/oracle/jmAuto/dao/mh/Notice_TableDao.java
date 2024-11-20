package com.oracle.jmAuto.dao.mh;

import java.util.List;

import com.oracle.jmAuto.dto.Notice_Table;

public interface Notice_TableDao {

	List<Notice_TableDao> listnotice();

	int delTableGogi(String noticeNum);

	int exposGogi(String noticeNum);

	List<Notice_TableDao> listNotState();

	List<Notice_Table> notSelList(Integer notNum);

	int notUpdateGogi(Notice_Table notlist);

	int noticeInsert(Notice_Table notInsList);

}
