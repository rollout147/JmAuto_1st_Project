package com.oracle.jmAuto.dao.mh;

import java.util.List;

public interface Expert_ReviewDao {

	int listReviewCount();

	List<Expert_ReviewDao> listReview();

	List<Expert_ReviewDao> expList();

	List<Expert_ReviewDao> selExpList(String sellNum);

}
