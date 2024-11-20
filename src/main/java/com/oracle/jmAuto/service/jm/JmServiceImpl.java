package com.oracle.jmAuto.service.jm;

import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.swing.Spring;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.oracle.jmAuto.dao.jm.JmDao;
import com.oracle.jmAuto.dto.Account;
import com.oracle.jmAuto.dto.FullUserInfo;
import com.oracle.jmAuto.dto.Business;
import com.oracle.jmAuto.dto.Certified;
import com.oracle.jmAuto.dto.User_Table;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class JmServiceImpl implements JmService {
	private final JmDao jd;
  // Spring Security에서 제공하는 비밀번호 암호화(해싱) 클래스
	private final BCryptPasswordEncoder passwordEncoder;

	// NOTE - 로그인 처리 로직 **********************************
	@Override
	public User_Table login(String user_id, String user_pw) {
		System.out.println("JmServiceImpl.login start....");

		// DB에서 user_id로 사용자 조회
		User_Table user_table = jd.login(user_id);

		// 사용자가 없으면 로그인 실패
		if (user_table == null) {
			return null; // 로그인 실패
		}

		// 입력한 비밀번호와 DB에 저장된 해시된 비밀번호를 비교
		boolean passwordMatch = passwordEncoder.matches(user_pw, user_table.getUser_pw());

		// 비밀번호 불일치 처리
		if (!passwordMatch) {
			return null; // 비밀번호 불일치
		}

		// 사용자 정보 반환
		return user_table;
	}

	// NOTE - 회원가입 *******************************************
	@Override
	public int join(User_Table user) {
		// 비밀번호를 해시화하여 Db에 저장
		String encodePassword = passwordEncoder.encode(user.getUser_pw());
		user.setUser_pw(encodePassword);
		int joinResult = jd.join(user);
		System.out.println("JmServiceImpl.join joinResult--->" + joinResult);

		return joinResult;
	}

	// NOTE - 아이디 중복 체크
	@Override
	public int confirmId(String user_id) {
		System.out.println("JmServiceImpl.confirmId start...");
		int result = jd.confirmId(user_id);
		System.out.println("JmServiceImpl.confirmId result--->" + result);

		return result;
	}




	// NOTE - 회원 가입 SELLER
	@Override
	public int sellerJoin(Business business, User_Table user_table, Account account) {
		String encodePassword = passwordEncoder.encode(user_table.getUser_pw());
		user_table.setUser_pw(encodePassword);

		int sellerJoinResult = jd.sellerJoin(business, user_table, account);

		return sellerJoinResult;
	}

	// NOTE - 회원 가입 PROF  
	@Override
	public int profJoin(Certified certified, User_Table user_table, Account account) {
		String encodePassword = passwordEncoder.encode(user_table.getUser_pw());
		user_table.setUser_pw(encodePassword);
		int profJoinResult = jd.profJoin(certified, user_table, account);

		return profJoinResult;
	}

	// NOTE -  아이디 찾기
	@Override
	public String findId(User_Table user) {
		System.out.println("JmServiceImpl.findId start...");
		System.out.println("JmServiceImpl.findId user_name >>>>" + user.getUser_name());
		System.out.println("JmServiceImpl.findId user_email >>>>" + user.getUser_email());

		String user_id = jd.findId(user);

		System.out.println("JmServiceImpl.findId user_id >>> " + user_id);

		return user_id;
	}

	// NOTE - 비밀번호 찾기 
	@Override
	public User_Table findPw(User_Table user) {
		System.out.println("JmServiceImpl.findPw() start... ");
		User_Table user_table = jd.findPw(user);
		System.out.println("JmServiceImpl.findPw() user_id &&& user_email" + user_table);

		return user_table;
	}

	// NOTE - 임시비밀번호 데이터 베이스 UPDATE
	@Override
	public String createTempPassword(String user_id) {
		// 랜덤 패스워드 생성 후 저장
		String tempPassword = createRandomPw();

		// 비밀번호 해시화
		String hashedTempPw = passwordEncoder.encode(tempPassword);

		// 비밀번호 DB 업데이트
		jd.updateTempPw(user_id, hashedTempPw);

		return tempPassword;
	}

	// NOTE - 랜덤 비밀번호 생성
	private String createRandomPw() {
		// 랜덤 비밀번호 생성 로직

		// 비밀번호 길이 : 6
		int length = 6;
		// 사용할 문자 : 대문자, 소문자, 숫자를 포함
		String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
		// 랜덤 객체 생성(비밀번호 생성을 위한 난수 생성)
		Random random = new Random();
		// 비밀번호를 저장할 StringBuilder 초기화
		StringBuilder password = new StringBuilder(length);

		// length 만큼 반복하여 비밀번호 생성
		for (int i = 0; i < length; i++) {
			// chars에서 랜덤으로 하나의 문자를 선택하여 passWord에 추가
			password.append(chars.charAt(random.nextInt(chars.length())));
		}
		// 생성된 비밀번호를 문자열로 반환
		return password.toString();
	}
	
	
	
	
	
	
	
	//	*********************  //
	//	*****관리자용 페이지*****  //
	//	*********************  //
	
	
	
	
	

	// NOTE - 회원목록 조회
	@Override
	public List<User_Table> selectUserList(Map<String, Object> params) {

		System.out.println("AdminServiceImpl.selectUserList() start....");
		List<User_Table> userList = jd.selectUserList(params);

		return userList;
	}
	
	
	// NOTE - 회원 검색 목록
	@Override
	public List<User_Table> searchUserList(String keyword,int start, int end) {
		System.out.println("AdminServiceImpl.searchUserList() start....");

		List<User_Table> userList = jd.searchUserList(keyword, start,end);

		return userList;
	}

	// NOTE - 회원 비활성화
	@Override
	public int userDeactive(String user_id) {
		System.out.println("AdminServiceImpl.userDeactive() start....");
		int result = jd.userDeactive(user_id);
		System.out.println("AdminServiceImpl.userDeactive() Result >>" + result);

		return result;
	}

	// NOTE - 회원 활성화
	@Override
	public int userActive(String user_id) {
		System.out.println("AdminServiceImpl.userActive() start....");
		int result = jd.userActive(user_id);
		System.out.println("AdminServiceImpl.userActive() Result >>" + result);

		return result;
	}

	// NOTE - 승인 요청한 회원 목록
	@Override
	public List<User_Table> selectApprovalUser(Map<String, Object> params) {
		System.out.println("AdminServiceImpl.selectApprovalUser start....");
		List<User_Table> userList = jd.selectApprovalUserList(params);

		return userList;
	}

	// NOTE - 승인 요청 처리
	@Override
	public int userApprove(String user_id) {
		System.out.println("AdminServiceImpl.userApprove start..");

		int result = jd.userApprove(user_id);

		return result;
	}

	
	// NOTE - 승인 요청 사용자 상세 정보 
	@Override
	public FullUserInfo userDetail(String user_id) {
		System.out.println("AdminServiceImpl.userDetail start...");

		FullUserInfo userInfo = jd.userDetail(user_id);

		return userInfo;
	}
	
	

	// NOTE - 관리자 추가
	@Override
	public int createManager(User_Table user) {

		System.out.println("AdminServiceImpl.createUser() start...");

		int result = jd.createManager(user);

		return result;
	}
	
	
	// NOTE - 총 회원수 
	@Override
	public int userTotal(Map<String, Object> params) {
		System.out.println("AdminServiceImpl.userTotal() start...");
		return jd.userTotal(params);
	}

	// NOTE - 검색어가 있는 총 회원 수 
	@Override
	public int userTotal() {
		System.out.println("AdminServiceImpl.userTotal(keyword) start... 키워드 검색 회원 수 ");
		return jd.userTotal();
	}

	// NOTE - 승인 요청 회원 수 
	@Override
	public int approvalTotal() {
		System.out.println("JmServiceImpl.approvalTotal() start.....");

		return jd.approvalTotal();
	}

	@Override
	public int approvalTotal(String keyword) {
		System.out.println("JmServiceImpl.approvalTotal() start.....");

		return jd.approvalTotal(keyword);
	}



	}


