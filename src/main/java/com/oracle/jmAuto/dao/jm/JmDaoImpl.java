package com.oracle.jmAuto.dao.jm;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Account;
import com.oracle.jmAuto.dto.FullUserInfo;
import com.oracle.jmAuto.dto.Business;
import com.oracle.jmAuto.dto.Certified;
import com.oracle.jmAuto.dto.User_Table;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class JmDaoImpl implements JmDao {
	private final SqlSession session;

	// NOTE - 로그인 처리 ********************************
	@Override
	public User_Table login(String user_id) {
		System.out.println("JmDaoImpl.login start...");

		User_Table user_table = new User_Table();

		try {
			user_table.setUser_id(user_id);

			user_table = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.loginUser", user_table);
			System.out.println("JmDaoImpl.login() [ user_table ] " + user_table);
		} catch (Exception e) {
			System.out.println("JmDaoImpl.login() ERROR !!!!!!!!!!!!!!!! " + e.getMessage());
		}
	
		return user_table;
	}

	// NOTE - 회원가입 *************************************
	@Override
	public int join(User_Table user) {
		System.out.println("JmDaoImpl.join start...");
		int joinResult = session.insert("com.oracle.jmAuto.dto.Mapper.jm.joinUser", user);
		return joinResult;
	}

	// NOTE - 아이디 중복 체크
	@Override
	public int confirmId(String user_id) {
		System.out.println("JmDaoImpl.confirmId... start!!");
		int result = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.confirmId", user_id);
		System.out.println("JmDaoImpl.confirmId result--->" + result);

		return result;
	}

	// NOTE - 판매자 회원가입
	@Override
	public int sellerJoin(Business business, User_Table user_table, Account account) {
		System.out.println("JmDaoImpl.sellerJoin start.....");
		System.out.println("JmDaoImpl.sellerJoin business --->>>" + business);
		System.out.println("JmDaoImpl.sellerJoin user_table --->" + user_table);
		System.out.println("JmDaoImpl.sellerJoin account --->" + account);

		// seller join 결과
		int sellerJoinResult = 0;

		try {
			// business table 정보 입력
			int buzInsertResult = session.insert("insertBuz", business);
			// user table 정보 입력
			// int userInsertResult = session.insert("joinUser", user_table);
			// account Table 정보 입력
			// int accountIncertResult = session.insert("insertAccount",account);

			if (buzInsertResult > 0) {
				System.out.println("buzInsert OK --> result " + buzInsertResult);
				// user_table ---> buz num set
				user_table.setBuz_num(business.getBuz_num());
				// user table 정보 입력
				int userInsertResult = session.insert("com.oracle.jmAuto.dto.Mapper.jm.joinUser", user_table);
				if (userInsertResult > 0) {
					System.out.println("userInsert Ok --> " + userInsertResult);
					// account table ---> user id set
					account.setUser_id(user_table.getUser_id());
					// account 정보 입력
					int accountIncertResult = session.insert("com.oracle.jmAuto.dto.Mapper.jm.insertAccount", account);
					if (accountIncertResult > 0) {
						System.out.println("account Ok ---> result " + accountIncertResult);

					}
				}
				sellerJoinResult = 1;
				System.out.println("buzJoin OK !!!!!!!!!!!!!!!!!");

			} else {
				sellerJoinResult = 0;
				System.out.println("buzInsert Fail --->  result " + buzInsertResult);
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("JmDaoImpl.sellerJoin Error!!" + e.getMessage());
			throw e; // 트랜잭션 롤백을 유도
		}

		return sellerJoinResult;
	}

	// NOTE - 회원가입 PROF
	@Override
	public int profJoin(Certified certified, User_Table user_table, Account account) {
		System.out.println("JmDaoImpl.profJoin start.....");
		System.out.println("JmDaoImpl.profJoin certified --->>>" + certified);
		System.out.println("JmDaoImpl.profJoin user_table --->" + user_table);
		System.out.println("JmDaoImpl.profJoin account --->" + account);

		// seller join 결과
		int certInsertResult = 0;

		try {
			// business table 정보 입력
			certInsertResult = session.insert("com.oracle.jmAuto.dto.Mapper.jm.insertProf", certified);
			// user table 정보 입력
			// int userInsertResult = session.insert("joinUser", user_table);
			// account Table 정보 입력
			// int accountIncertResult = session.insert("insertAccount",account);

			if (certInsertResult > 0) {
				System.out.println("certInsert OK --> result " + certInsertResult);
				// user_table ---> buz num set
				user_table.setCert_num(certified.getCert_num());
				// user table 정보 입력
				int userInsertResult = session.insert("com.oracle.jmAuto.dto.Mapper.jm.joinUser", user_table);
				if (userInsertResult > 0) {
					System.out.println("userInsert Ok --> " + userInsertResult);
					// account table ---> user id set
					account.setUser_id(user_table.getUser_id());
					// account 정보 입력
					int accountIncertResult = session.insert("com.oracle.jmAuto.dto.Mapper.jm.insertAccount", account);
					if (accountIncertResult > 0) {
						System.out.println("account Ok ---> result " + accountIncertResult);

					}
				}
				certInsertResult = 1;
				System.out.println("cert Join OK !!!!!!!!!!!!!!!!!");

			} else {
				certInsertResult = 0;
				System.out.println("certInsert Fail --->  result " + certInsertResult);
			}

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("JmDaoImpl.certJoin Error!!" + e.getMessage());
			throw e; // 트랜잭션 롤백을 유도
		}

		return certInsertResult;
	}

	// NOTE - 아이디 찾기
	@Override
	public String findId(User_Table user) {
		System.out.println("JmDaoImpl.findId start...");

		String user_id = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.findId", user);

		System.out.println("JmDaoImpl.findId user_id >>>" + user_id);

		return user_id;
	}

	// NOTE - 비밀번호 찾기 - 회원 확인
	@Override
	public User_Table findPw(User_Table user) {
		System.out.println("JmDaoImpl.findPw() start...");
		User_Table user_table = new User_Table();
		System.out.println(user);
		user_table = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.findPw", user);
		return user_table;
	}

	// NOTE - 임시 비밀번호 발급
	@Override
	public void updateTempPw(String user_id, String hashedTempPw) {
		System.out.println("JmDaoImpl.updateTempPw start/////");

		User_Table user = new User_Table();

		user.setUser_id(user_id);
		user.setUser_pw(hashedTempPw);

		int updateTempPw = session.update("com.oracle.jmAuto.dto.Mapper.jm.updateTempPw", user);

		if (updateTempPw > 0) {
			System.out.println("JmDaoImpl.updateTempPw() update 성공*****");
		} else {
			System.out.println("JmDaoImpl.updateTempPw() update 실패*****");
		}

	}

	// NOTE : 사용자 이메일 정보 GET
	@Override
	public String getUserEmail(String user_id) {
		System.out.println("JmDaoImpl.getUserEmail start !!!!!!!");

		String user_email = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.getUserEmail", user_id);
		System.out.println("JmDaoImpl.getUserEmail [user_email] : " + user_email);

		return user_email;
	}

	// NOTE : 회원목록조회
	@Override
	public List<User_Table> selectUserList(Map<String, Object> params) {
		System.out.println("AdminDaoImpl.selectUserList() start...");


		// Mapper 호출 시 Map 전달
		List<User_Table> userList = session.selectList("com.oracle.jmAuto.dto.Mapper.jm.selectUserList", params);

		System.out.println("JmDaoImpl.selectUserList() userList" + userList);
		// List<User_Table> userList =
		// session.selectList("com.oracle.jmAuto.dto.Mapper.jm.selectUserList");

		return userList;
	}

	// NOTE : 회원 비활성화
	@Override
	public int userDeactive(String user_id) {

		int result = session.update("com.oracle.jmAuto.dto.Mapper.jm.userDeactive", user_id);

		return result;
	}

	// NOTE : 회원 활성화
	@Override
	public int userActive(String user_id) {
		int result = session.update("com.oracle.jmAuto.dto.Mapper.jm.userActive", user_id);

		return result;
	}

	// NOTE - 승인 요청 회원 목록 조회
	@Override
	public List<User_Table> selectApprovalUserList(Map<String, Object> params) {
		System.out.println("AdminDaoImpl.selectUserList() start---------------------------");
		// Map 객체 생성하여 파라미터 설정
		List<User_Table> userList = session.selectList("com.oracle.jmAuto.dto.Mapper.jm.selectApprovalUserList",params);

		return userList;
	}

	// NOTE - 승인 요청 처리
	@Override
	public int userApprove(String user_id) {
		int result = session.update("com.oracle.jmAuto.dto.Mapper.jm.userApprove", user_id);

		return result;
	}

	// NOTE - 승인 요청 회원 상세 정보
	@Override
	public FullUserInfo userDetail(String user_id) {
		System.out.println("AdminDaoImpl.userDetail start...");

		FullUserInfo userInfo = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.userDetail", user_id);

		System.out.println("AdminDaoImpl.userDetail usesrInfo >>" + userInfo);

		return userInfo;
	}

	// NOTE - 관리자 추가
	@Override
	public int createManager(User_Table user) {
		System.out.println("AdminDaoImpl.createManager() start...");

		int result = session.insert("com.oracle.jmAuto.dto.Mapper.jm.createManager", user);

		System.out.println("AdminDaoImpl.createManager() result >>" + result);

		return result;
	}

	// NOTE - 회원 목록 검색
	@Override
	public List<User_Table> searchUserList(String keyword, int start, int end) {
		System.out.println("AdminDaoImpl.searchUserList() start...");

		System.out.println("+++" + keyword + start + end);
		// Map 객체 생성하여 파라미터 설정
		Map<String, Object> params = new HashMap<>();
		params.put("keyword", keyword); // String 타입
		params.put("start", start); // int 타입
		params.put("end", end); // int 타입

		List<User_Table> userList = session.selectList("com.oracle.jmAuto.dto.Mapper.jm.searchUserList", params);

		System.out.println("AdminDaoImpl.searchUserList() userList" + userList);

		return userList;
	}

	// NOTE - 총 회원 수
	@Override
	public int userTotal(Map<String, Object> params) {
		System.out.println("AdminDaoImpl.userTotal() start...");

		int userTotal = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.userTotal", params);

		System.out.println("AdminDaoImpl.userTotal()  userTotal  ===>	" + userTotal);

		return userTotal;
	}

	@Override
	public int userTotal() {
		System.out.println("JmDaoImpl.userTotal()---------------------");
		int userTotal = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.userTotal");

		System.out.println("AdminDaoImpl.userTotal()  userTotal  ===>	" + userTotal);

		return userTotal;
	}

	@Override
	public int approvalTotal() {
		System.out.println("JmDaoImpl.approvalTotal() start ------------------");
		int approvalTotal = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.approvalTotal");
		System.out.println("JmDaoImpl.approvalTotal() [approvalTotal]==> " + approvalTotal);
		return approvalTotal;
	}

	@Override
	public int approvalTotal(String keyword) {
		System.out.println("JmDaoImpl.approvalTotal() start ------------------");
		int approvalTotal = session.selectOne("com.oracle.jmAuto.dto.Mapper.jm.approvalTotal", keyword);
		System.out.println("JmDaoImpl.approvalTotal() [approvalTotal]==> " + approvalTotal);
		return approvalTotal;
	}

}
