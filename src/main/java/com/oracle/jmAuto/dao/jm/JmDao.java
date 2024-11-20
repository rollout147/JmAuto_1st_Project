package com.oracle.jmAuto.dao.jm;

import java.util.List;
import java.util.Map;

import com.oracle.jmAuto.dto.Account;
import com.oracle.jmAuto.dto.FullUserInfo;
import com.oracle.jmAuto.dto.Business;
import com.oracle.jmAuto.dto.Certified;
import com.oracle.jmAuto.dto.User_Table;

public interface JmDao {

	// 로그인
	User_Table login(String user_id);

	// 회원가입 - BUYER
	int join(User_Table user);
	 

	int confirmId(String user_id);

	int sellerJoin(Business business, User_Table user_table, Account account);

	int profJoin(Certified certified, User_Table user_table, Account account);

	String findId(User_Table user);

	User_Table findPw(User_Table user);

    void updateTempPw(String user_id, String hashedTempPw);

	String getUserEmail(String user_id);


	
	// 관리자용 페이지 로직
    List<User_Table> selectUserList(Map<String, Object> params);

	List<User_Table> searchUserList(String keyword,int start, int end);

    int createManager(User_Table user);

    FullUserInfo userDetail(String user_id);

    int userApprove(String user_id);

    List<User_Table> selectApprovalUserList(Map<String, Object> params);

    int userActive(String user_id);

    int userDeactive(String user_id);


	int userTotal(Map<String, Object> params);

    int userTotal();

    int approvalTotal();

    int approvalTotal(String keyword);


}
