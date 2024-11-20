package com.oracle.jmAuto.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.jmAuto.dto.Account;
import com.oracle.jmAuto.dto.Business;
import com.oracle.jmAuto.dto.Certified;
import com.oracle.jmAuto.dto.FullUserInfo;
import com.oracle.jmAuto.dto.Paging;
import com.oracle.jmAuto.dto.SessionUtils;
import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.service.jm.EmailService;
import com.oracle.jmAuto.service.jm.JmService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/view_jm")
public class JmController {

	private final JmService js;
	private final EmailService es;

	// NOTE - 로그인 화면 출력 **********************************************
	@GetMapping(value = "/login")
	public String loginForm() {
		return "view_jm/login";
	}

	// NOTE - 로그인 처리 로직 **********************************************
	@PostMapping(value = "/login")
	public String login(
										@RequestParam("user_id") String user_id, 
										@RequestParam("user_pw") String user_pw, Model model,
										HttpSession session, HttpServletRequest request) {
		
		

		log.info(" user_id  => {}", user_id);
		User_Table user_table = new User_Table();
		user_table = js.login(user_id, user_pw);
		
		log.info("로그인 성공");

		// 로그인 실패: 비밀번호가 틀리거나 사용자 정보가 없음
		if (user_table == null) {
			log.error("로그인 실패");
			model.addAttribute("loginError", "아이디 또는 비밀번호가 틀렸습니다.");
			model.addAttribute("user_id", user_id); // 입력한 아이디를 다시 전달
			return "view_jm/login"; 
		}

		// 탈퇴한 사용자 체크
		if (user_table.getDel_state() == 1) {
			log.error("로그인 실패 탈퇴 ");
			model.addAttribute("loginError", "탈퇴한 회원입니다.");
			model.addAttribute("user_id", user_id); // 입력한 아이디를 다시 전달
			return "view_jm/login";
		}

		// 승인 요청 중 체크
		if (user_table.getApproval().equals("0")) { // 예시로 승인 요청 중 체크
			log.error("승인 요청중");
			model.addAttribute("loginError", "승인 요청 중입니다.");
			model.addAttribute("user_id", user_id); // 입력한 아이디를 다시 전달
			return "view_jm/login";
		}
		
		String user_id1 = user_table.getUser_id();
		// 로그인 성공시
		log.info(" 로그인 성공 !! ");

		// 기존 세션을 무효화하고 새로운 세션 ID 발급
		session.invalidate(); // 기존 세션을 무효화
		// request.changeSessionId(); // 새로운 세션 ID 발급
		session = request.getSession(true); // 새로운 세션 생성

		// 사용자 정보를 세션에 저장
		session.setAttribute("user", user_table); // 새로운 세션에 사용자 정보 저장
		session.setMaxInactiveInterval(30 * 60); // 30분 동안 활동이 없으면 세션 만료 설정

		// 사용자 ID저장
		SessionUtils.addAttribute("user_id", user_id1);
		return "redirect:/";
	}

	// NOTE - 로그아웃 (세션 해제) **************************************
	@GetMapping(value = "/logout")
	public String logout(HttpSession session, Model model) {
		// 세션 해제
		session.invalidate();
		log.info("로그아웃");
		return "redirect:/";
	}



	// ********************* 아이디 찾기 ******************************** //

	// NOTE - 아이디 찾기 화면 출력
	@GetMapping(value = "/findId")
	public String findIdForm() {

		System.out.println("JmController.findIdForm  start..");

		return "view_jm/findId";
	}

	// NOTE - 아이디 찾기
	@PostMapping(value = "/findId")
	public String findId(@RequestParam("user_email") String user_email, @RequestParam("user_name") String user_name,
			Model model) {
		System.out.println("JmController.findId start....");

		System.out.println("JmController.findId user_email >>>>" + user_email);
		System.out.println("JmController.findId user_name >>>>" + user_name);

		User_Table user = new User_Table();

		user.setUser_email(user_email);
		user.setUser_name(user_name);

		String user_id = js.findId(user);

		System.out.println("JmController.findId user_id >>> " + user_id);

		if (user_id != null) {
			model.addAttribute("find_id", user_id);
			model.addAttribute("userCheckMessage", "회원님의 이메일로 가입된 아이디 입니다.");
		} else {
			model.addAttribute("userCheckMessage", "회원정보와 일치하는 아이디가 존재하지 않습니다.");
		}

		return "view_jm/findIdResult";
	}

	// ************************************************************

	// NOTE - 비밀번호 찾기 화면 출력 ********************************
	@GetMapping(value = "/findPw")
	public String findPwForm() {

		System.out.println("JmController.findpwForm  start -----------------------");

		return "view_jm/findPw";
	}

	// NOTE - 비밀번호 찾기 - 회원 확인
	@PostMapping(value = "/findPw")
	public String findPw(@ModelAttribute User_Table user, Model model) {
		System.out.println("JmController.findPw start....");

		// 파라메터가 왔는지 확인
		System.out.println("JmController.findPw user_id >>> " + user.getUser_id());
		System.out.println("JmController.findPw user_email >>> " + user.getUser_email());

		// 사용자 확인
		User_Table user_table = js.findPw(user);
		System.out.println("JmController.findPw() user_table" + user_table);
		if (user_table != null) {
			String user_id = user_table.getUser_id();
			model.addAttribute("user_id", user_id);
			model.addAttribute("userCheckMessage", "회원확인이 완료되셨습니다");
		} else {
			model.addAttribute("userCheckMessage", "존재하지 않는 회원입니다.");
		}

		return "view_jm/findPwResult";

	}

	// NOTE - 비밀번호 찾기 - 임시비밀번호 발급
	@PostMapping(value = "/tempPassword")
	public String tempPassword(@RequestParam String user_id, Model model) {
		// 임시 비밀번호 생성 후 업데이트
		String tempPassword = js.createTempPassword(user_id);
		System.out.println("JmController.tempPassword tempPassword : " + tempPassword);

		// 이메일로 비밀번호 발송
		int result = es.sendTempPw(user_id, tempPassword);
		System.out.println("JmController.tempPassword result >>> " + result);

		if (result > 0) {

			return "view_jm/login";

		} else {
			return "view_jm/findPw";
		}
	}

	// NOTE - 회원가입 유형 화면 출력 ***********************************
	@GetMapping(value = "/joinType")
	public String joinTypeForm() {
		return "view_jm/joinType";
	}


	// NOTE - 회원가입 동의화면 - 구매자 ***********************************
	@GetMapping(value = "/buyerJoinAgree")
	public String buyerJoinAgreeForm() {
		return "view_jm/buyerJoinAgree";
	}

	// NOTE - 회원가입 개인정보 입력 - 구매자 ***********************************
	@GetMapping(value = "/buyerJoinInfo")
	public String buyerJoinInfoForm() {
		System.out.println("Jmcontroller.buyerJoinInfoForm start ----------------");
		return "view_jm/buyerJoinInfo";
	}

	// NOTE - 회원가입 구현 - 구매자 ***************************************
	@PostMapping(value = "/join")
	public String join(@ModelAttribute User_Table user, Model model) {
		System.out.println("JmController.join start ------------------");
		System.out.println("JmController.join USER-->" + user);
		System.out.println("JmController.join USER-->" + user.getUser_type());

		// 유저 유형 저장
		user.setUser_type("B");
		// 등급 저장
		user.setUser_level("1");
		// 탈퇴 여부 저장
		user.setDel_state(0);
		// 승인 여부 저장
		user.setApproval("1");

		int joinResult = js.join(user);
		System.out.println("JmController.join joinResult--->>" + joinResult);
		if (joinResult > 0) {
			return "view_jm/joinOk";
		} else {
			model.addAttribute("msg", "회원가입에 실패하셨습니다");
			return "main";
		}
	}

	// ---------------------------------------------------------------------------------
	// NOTE - 회원가입 - 판매자 화면 출력 *******************************

	@GetMapping(value = "/sellerJoinAgree")
	public String sellerJoinAgreeForm() {

		System.out.println("JmController.sellerJoinAgreeForm start...");

		return "view_jm/sellerJoinAgree";
	}

	// NOTE - 회원가입 - 판매자 처리 ***********************************
	@GetMapping(value = "/sellerJoinInfo_1")
	public String sellerJoinInfoForm() {

		System.out.println("Jmcontroller.sellerJoinInfoForm start...");

		return "view_jm/sellerJoinInfo_1";
	}

	// NOTE - seller Join info - business Info_1 세션 저장 로직 구현
	@PostMapping(value = "/sellerJoinInfo_2")
	public String InsertBuz(@ModelAttribute Business business2, @RequestParam("fileUpload") MultipartFile file,
			HttpSession session) {
		System.out.println("JmController.buzInfoInsert start...");
		System.out.println("JmController.InsertBuz business2 -->" + business2);

		Business business = new Business();
		business.setBuz_num(business2.getBuz_num());
		business.setBuz_name(business2.getBuz_name());
		business.setBuz_addr(business2.getBuz_addr());

		// 사업자 번호를 파일 이름으로 사용
		String businessNumber = business2.getBuz_num();

		// 원래 파일의 확장자 추출
		String originalFilename = file.getOriginalFilename();
		String fileExtension = "";

		if (originalFilename != null && originalFilename.contains(".")) {
			fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
		}

		// 사업자 번호와 확장자를 결합하여 새 파일 이름 생성
		String fileName = businessNumber + fileExtension;

		// 파일 저장 경로 설정
		// String uploadDir = "C:/businessImage";
		// File savedFile = new File(uploadDir + File.separator + fileName);

		try {
			// 파일 저장
			// file.transferTo(savedFile);
			// 파일 이름 저장
			// business.setBuz_filename(fileName);

			// 파일 url 생성 (웹에서 접근 가능한 경로로 설정)
			String fileUrl = "/userImages/buzImages/" + fileName;
			business.setBuz_url(fileUrl); // business객체에 파일 url 설정

			// 방법 2
			// 파일 데이터를 byte[]로 변환하여 세션에 저장
			byte[] fileData = file.getBytes();
			// 파일 데이터를 세션에 저장
			session.setAttribute("fileData", fileData);
			// 파일 이름 세션에 저장
			session.setAttribute("fileName", fileName);
			// 비즈니스 테이블 정보 세션에 저장
			session.setAttribute("businessInfo", business);
		} catch (Exception e) {
			System.out.println("JmController.InsertBuz e.getMessage" + e.getMessage());
			return "view_jm/sellerJoinInfo_1";
		}

		return "view_jm/sellerJoinInfo_2";
	}

	// NOTE - 판매자 회원가입
	@PostMapping(value = "/sellerJoinRequest")
	public String sellerJoin(HttpServletRequest request, User_Table user_table, HttpSession session, Account account)
			throws FileNotFoundException, IOException {
		System.out.println("JmController.sellerJoin start...");

		// 세션에서 사업자 정보와 파일 데이터를 가져옴
		Business business = (Business) session.getAttribute("businessInfo");
		byte[] fileData = (byte[]) session.getAttribute("fileData");
		String fileName = (String) session.getAttribute("fileName");

		// 판매 회원에 대한 테이블 값 처리
		// 사업자 번호 저장
		user_table.setBuz_num(business.getBuz_num());
		// 유저 유형 저장
		user_table.setUser_type("S");
		// 등급 저장
		user_table.setUser_level("1");
		// 탈퇴 여부 저장
		user_table.setDel_state(0);
		// 승인 여부 저장
		user_table.setApproval("0");
		// 계좌 정보 user_id 저장
		account.setUser_id(user_table.getUser_id());

		// 실제 파일 저장 처리
		if (fileData != null && fileName != null) {
			// 실제 파일 저장 경로
			String filePath = request.getSession().getServletContext().getRealPath("/userImages/buzImages");
			// String uniqueFileName = business.getBuz_num() + "_" + fileName; // 고유 파일명 설정
			File dest = new File(filePath + File.separator + fileName);
			System.out.println("JmController.sellerJoin filePath >>" + filePath);

			try (FileOutputStream fos = new FileOutputStream(dest)) {
				// 파일을 실제로 저장
				fos.write(fileData);
				// 파일 이름 저장
				business.setBuz_filename(fileName);
				// 파일 경로 저장
				// business.setBuz_url(filePath);

				// 세션에서 파일 관련 데이터 삭제
				session.removeAttribute("fileData");
				session.removeAttribute("fileName");
				session.removeAttribute("businessInfo");

				// join 처리 start..
				int sellerJoinResult = js.sellerJoin(business, user_table, account);

				if (sellerJoinResult > 0) {
					System.out.println("Business info saved successfully");
					return "view_jm/sellerJoinRequest";
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "view_jm/sellerJoinInfo_1";
	}

	// ********************************************************
	// 전문가 회원가입 ******************************************

	// NOTE - 전문가 회원가입 동의화면
	@GetMapping(value = "/profJoinAgree")
	public String profJoinAgreeForm() {
		return "view_jm/profJoinAgree";
	}

	// NOTE - 전문가 회원가입 
	@GetMapping(value = "/profJoinInfo_1")
	public String profJoinInfoForm() {
		return "view_jm/profJoinInfo_1";
	}

	// NOTE - prof Join info - certified Info_1 세션 저장 로직 구현
	@PostMapping(value = "/profJoinInfo_2")
	public String InsertCert(@ModelAttribute Certified certified5, @RequestParam("fileUpload") MultipartFile file,
			HttpSession session) {
		System.out.println("JmController.InsertCert start...");
		System.out.println("JmController.InsertBuz business2 -->" + certified5);

		Certified cert = new Certified();

		cert.setCert_num(certified5.getCert_num());
		cert.setCert_name(certified5.getCert_name());
		cert.setCert_date(certified5.getCert_date());
		cert.setCert_loc(certified5.getCert_loc());

		// 자격증 번호를 파일 이름으로 사용
		String certNumber = cert.getCert_num();

		// 원래 파일의 확장자 추출
		// 파일 이름이 document.pdf file.getOriginalFilename() --->"document.pdf"
		String originalFilename = file.getOriginalFilename();
		// originalFilename이 "document.pdf"
		// lastIndexOf(".")는 8을 반환합니다 (즉, .의 위치).
		// substring(8)은 ".pdf"를 반환합니다.
		String fileExtension = "";

		if (originalFilename != null && originalFilename.contains(".")) {
			fileExtension = originalFilename.substring(originalFilename.lastIndexOf("."));
		}

		// 사업자 번호와 확장자를 결합하여 새 파일 이름 생성
		String fileName = certNumber + fileExtension;

		try {

			// 파일 url 생성 (웹에서 접근 가능한 경로로 설정)
			String fileUrl = "/userImages/certImages/" + fileName;
			cert.setCert_url(fileUrl); // 자격증 파일 url 설정

			// 방법 2
			// 파일 데이터를 byte[]로 변환하여 세션에 저장
			byte[] fileData = file.getBytes();
			// 파일 데이터를 세션에 저장
			session.setAttribute("fileData", fileData);
			// 파일 이름 세션에 저장
			session.setAttribute("fileName", fileName);
			// 비즈니스 테이블 정보 세션에 저장
			session.setAttribute("certifiedInfo", cert);
			System.out.println("Certified Info in Session: " + session.getAttribute("certifiedInfo"));
		} catch (Exception e) {
			System.out.println("JmController.InsertBuz e.getMessage" + e.getMessage());
			return "view_jm/profJoinInfo_1";
		}

		return "view_jm/profJoinInfo_2";
	}

	// NOTE - 전문가 회원가입
	@PostMapping(value = "/profJoinRequest")
	public String profJoin(HttpServletRequest request, @ModelAttribute User_Table user_table, HttpSession session,
			Account account)
			throws FileNotFoundException, IOException {
		System.out.println("JmController.profJoin start...");
		System.out.println("Certified Info in Session: " + session.getAttribute("certifiedInfo"));
		// 세션에서 사업자 정보와 파일 데이터를 가져옴
		Certified certified = (Certified) session.getAttribute("certifiedInfo");
		byte[] fileData = (byte[]) session.getAttribute("fileData");
		String fileName = (String) session.getAttribute("fileName");

		// 판매 회원에 대한 테이블 값 처리
		// 자격증 번호 저장
		user_table.setCert_num(certified.getCert_num());
		// 유저 유형 저장
		user_table.setUser_type("P");
		// 등급 저장
		user_table.setUser_level("1");
		// 탈퇴 여부 저장
		user_table.setDel_state(0);
		// 승인 여부 저장
		user_table.setApproval("0");
		// 계좌 정보 user_id 저장
		account.setUser_id(user_table.getUser_id());

		// 실제 파일 저장 처리
		if (fileData != null && fileName != null) {
			// 실제 파일 저장 경로
			String filePath = request.getSession().getServletContext().getRealPath("/userImages/certImages");
			// String uniqueFileName = business.getBuz_num() + "_" + fileName; // 고유 파일명 설정
			File dest = new File(filePath + File.separator + fileName);

			try (FileOutputStream fos = new FileOutputStream(dest)) {
				// 파일을 실제로 저장
				fos.write(fileData);
				// 파일 이름 저장
				certified.setCert_filename(fileName);
				// 파일 경로 저장
				// business.setBuz_url(filePath);

				// 세션에서 파일 관련 데이터 삭제
				session.removeAttribute("fileData");
				session.removeAttribute("fileName");
				session.removeAttribute("businessInfo");

				// join 처리 start..
				int profJoinResult = js.profJoin(certified, user_table, account);

				if (profJoinResult > 0) {
					System.out.println("Business info saved successfully");
					return "view_jm/profJoinRequest";
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return "view_jm/profJoinInfo_1";
	}

	// ---------------------------------------------------------
	// NOTE - 아이디 중복 확인
	@GetMapping(value = "/confirmId")
	@ResponseBody // JSON 응답을 위해 추가
	public int confirmId(@RequestParam("user_id") String user_id) {
		System.out.println("JmController.confirmId start...");
		int result = js.confirmId(user_id);
		return result;
	}

	@PostMapping("/sendAuthCode")
	@ResponseBody
	public Map<String, String> sendAuthCode(HttpServletRequest request, @RequestParam("user_email") String user_email) {
		Map<String, String> response = new HashMap<>();
		System.out.println("JmController.sendAuthCode() start....");
		System.out.println("JmController.sendAuthCode() user_email >>> " + user_email);
		try {
			String authCode = es.sendAuthCode(user_email);
			HttpSession session = request.getSession();
			System.out.println("JmController.sendAuthCode() 트라이 start....");
			session.setAttribute("authCode", authCode);
			session.setMaxInactiveInterval(300);
			response.put("message", "이메일로 인증번호가 전송되었습니다.");

		} catch (Exception e) {
			response.put("message", "이메일 전송에 실패했습니다.");
		}
		return response;
	}

	// NOTE - 인증번호 확인 로직
	@PostMapping("/verifyAuthCode")
	public ResponseEntity<?> verifyAuthCode(HttpSession session, @RequestParam("auth_code") String inputCode) {
		// 세션에 저장된 인증번호 가져오기
		String sessionAuthCode = (String) session.getAttribute("authCode");

		// 입력한 인증번호와 세션의 인증번호를 비교
		if (sessionAuthCode != null && sessionAuthCode.equals(inputCode)) {
			return ResponseEntity.ok(Map.of("valid", true));
		} else {
			return ResponseEntity.ok(Map.of("valid", false));
		}
	}

	

	// *********************************************************************** //
	// *************************** 관리자 페이지 ******************************* //
	// ********************************************************************** //

	// NOTE - 회원 목록 조회
	// @GetMapping(value = "/manager_userList")
	// public String adminPage(@RequestParam(value = "currentPage", defaultValue =
	// "1") String currentPage
	// ,HttpSession session, Model model) {

	// System.out.println("AdminController.adminPage() start...");
	// User_Table user = (User_Table) session.getAttribute("user");

	// // manager 페이지 접근을 위해 --> user가 null인지 확인하고, user_type이 'A'인지 확인
	// if (user != null && "A".equals(user.getUser_type())) {

	// // 총 회원수
	// int userTotal = js.userTotal();
	// // 관리자용 페이징
	// Paging page = new Paging(userTotal,currentPage);

	// System.out.println("JmController.adminPage() page"+page);
	// // 회원 목록 조회
	// List<User_Table> userList = js.selectUserList(page.getStart(),
	// page.getEnd());

	// // 모델에 데이터 추가
	// model.addAttribute("total", userTotal);
	// model.addAttribute("page", page);
	// model.addAttribute("userList", userList);

	// // user_type이 'A'인 경우 관리자 페이지로 이동
	// return "view_jm/manager_userList";
	// } else {
	// // user가 없거나 user_type이 'A'가 아닌 경우 로그인 페이지로 리다이렉트
	// return "view_jm/login";
	// }
	// }

	// NOTE : 회원 목록 검색
	@GetMapping(value = "/searchUser")
	public String searchUserList(
			@RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
			@RequestParam(value = "keyword", required = false) String keyword,
			HttpSession session,
			Model model) {

		System.out.println("AdminController.searchUserList() start...");

		int userTotal = 0;
		Paging page = new Paging();
		List<User_Table> userList = null;
		
		User_Table user = (User_Table) session.getAttribute("user");
		
		// // manager 페이지 접근을 위해 --> user가 null인지 확인하고, user_type이 'A'인지 확인
		if (user != null && "A".equals(user.getUser_type())) {
		// 검색 키워드가 null 이거나 비어져 있는 경우
				if (keyword == null || keyword.trim().isEmpty()) {
					userTotal = js.userTotal();
					// 페이징에 따라 조회 범위 설정
					page = new Paging(userTotal, currentPage);
					// Map 객체 생성하여 파라미터 설정
					Map<String, Object> params = new HashMap<>();
					params.put("start", page.getStart());
					params.put("end", page.getEnd());
					userList = js.selectUserList(params);
		
				} else {
					Map<String, Object> params = new HashMap<>();
					params.put("keyword", keyword); // String 타입
					userTotal = js.userTotal(params);
					page = new Paging(userTotal, currentPage);
					System.out.println("확인 ++++++++" + page);
		
					userList = js.searchUserList(keyword, page.getStart(), page.getEnd());
		
				}

		model.addAttribute("keyword", keyword);
		model.addAttribute("total", userTotal);
		model.addAttribute("userList", userList);
		model.addAttribute("page", page);

		return "view_jm/manager_userList";
		}else {
			 // user가 없거나 user_type이 'A'가 아닌 경우 로그인 페이지로 리다이렉트
			 return "view_jm/login";
			 }
	}

	// NOTE - 관리자 목록
	@GetMapping("/manager_adminList")
	public String adminList(
			@RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
			@RequestParam(value = "keyword", required = false) String keyword,
			@RequestParam(value = "user_type", required = false) String user_type,
			HttpSession session,
			Model model) {
				
		System.out.println("JmController.adminList() start....");
		System.out.println("user_Type===>" + user_type);
		int userTotal = 0;
		Paging page = new Paging();
		List<User_Table> userList = null;
		// Map 객체 생성하여 파라미터 설정
		Map<String, Object> params = new HashMap<>();
		params.put("keyword", keyword); // String 타입
		params.put("user_type", user_type); // int 타입
		userTotal = js.userTotal(params);

		System.out.println("------->" + userTotal);

		page = new Paging(userTotal, currentPage);

		System.out.println("확인 ++++++++" + page);
		params.put("start", page.getStart());
		params.put("end", page.getEnd());
		userList = js.selectUserList(params);

		System.out.println("AdminController.adminPage()  --> userList" + userList);

		model.addAttribute("total", userTotal);
		model.addAttribute("userList", userList);
		model.addAttribute("page", page);

		return "view_jm/manager_adminList";
	}

	// NOTE - 사용자 계정 비활성화
	@GetMapping("/userDeactive")
	@ResponseBody
	public int userDeactive(@RequestParam("user_id") String user_id) {
		System.out.println("AdminController.userDeactive() start...");
		System.out.println("AdminController.userDeactive() user_id ....>>" + user_id);

		int result = js.userDeactive(user_id);

		return result;
	}

	// NOTE -  사용자 계정 활성화 
	@GetMapping("/userActive")
	@ResponseBody
	public int userActive(@RequestParam("user_id") String user_id) {

		System.out.println("AdminController.userActive() start ----------------");
		System.out.println("AdminController.userActive() [ user_id ] ------- >>" + user_id);
		int result = js.userActive(user_id);
		
		return result;
	}

	// NOTE : 판매자 전문가 승인 요청 목록
	@GetMapping("/manager_userApproval")
	public String userApproval(
			@RequestParam(value = "currentPage", defaultValue = "1") String currentPage,
			@RequestParam(value = "user_type", required = false) String user_type,
			HttpSession session,
			Model model) {

		System.out.println("AdminController.userApproval() ----------------------");
		System.out.println("JmController.userApproval() [ user_type ] >> " + user_type );
		
		int approvalTotal = 0;
		Paging page = new Paging();
		List<User_Table> userList = null;

		Map<String, Object> params = new HashMap<>();
		params.put("user_type", user_type); // int 타입

		// 검색 키워드가 null 이거나 비어져 있는 경우
		if (user_type == null || user_type.trim().isEmpty()) {
			approvalTotal = js.approvalTotal();
			page = new Paging(approvalTotal, currentPage);
			params.put("start", page.getStart());
			params.put("end", page.getEnd());
			// 페이징에 따라 조회 범위 설정
			userList = js.selectApprovalUser(params);

		} else {
			approvalTotal = js.approvalTotal(user_type);
			page = new Paging(approvalTotal, currentPage);
			params.put("start", page.getStart());
			params.put("end", page.getEnd());
			// 페이징에 따라 조회 범위 설정
			userList = js.selectApprovalUser(params);
		}

		System.out.println("AdminController.adminPage()  --> userList" + userList);

		model.addAttribute("total", approvalTotal);
		model.addAttribute("userList", userList);
		model.addAttribute("page", page);

		return "view_jm/manager_userApproval";

	}

	// NOTE : 판매자, 전문가 승인 요청 처리
	@GetMapping("/userApprove")
	@ResponseBody
	public int userApprove(@RequestParam("user_id") String user_id) {
		System.out.println("AdminController.userApprove start....");
		System.out.println("AdminController.userApprove user_id >>>" + user_id);

		int result = js.userApprove(user_id);

		// 승인 처리 성공
		if (result > 0) {
			// 이메일 전송
			int sendResult = es.sendApproveMail(user_id);
			System.out.println("AdminController.userApprove 이메일 발송 결과 >>>" + sendResult);

		}

		System.out.println("AdminController.userApprove result >>>" + result);

		return result;
	}

	// NOTE : 승인 요청 유저 정보 상세 페이지
	@GetMapping(value = "/manager_userDetail")
	public String userDetail(Model model, @RequestParam("user_id") String user_id) {
		System.out.println("AdminController.userDetail start....");
		System.out.println("AdminController.userDetail user_id >>>>" + user_id);

		FullUserInfo userInfo = js.userDetail(user_id);

		System.out.println("AdminController.userDetail userInfo" + userInfo);

		model.addAttribute("userInfo", userInfo);

		return "view_jm/manager_userDetail";
	}

	// NOTE - 관리자 추가
	@PostMapping(value = "/createManager")
	public String createManage(@ModelAttribute User_Table user_table) {
		System.out.println("AdminController.createManage() user_table >>> " + user_table);
	

		// 3. 서비스로 보내서 insert
		int result = js.createManager(user_table);

		System.out.println("fjldsflkdslf" + result);

		if (result > 0) {
			return "redirect:/view_jm/manager_adminList?user_type=" + user_table.getUser_type();
		} else {
			return "view_jm/login";
		}

	}

}