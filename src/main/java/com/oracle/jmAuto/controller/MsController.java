package com.oracle.jmAuto.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.xml.transform.Result;

import org.hibernate.internal.build.AllowSysOut;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.oracle.jmAuto.dao.ms.MsDaoImpl;
import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.Note;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Review;
import com.oracle.jmAuto.dto.ReviewListInfo;
import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.dto.Zzim;
import com.oracle.jmAuto.service.ms.MsService;
import com.oracle.jmAuto.service.ms.MsServiceImpl;

import jakarta.persistence.metamodel.SetAttribute;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Slf4j
@Controller
//@RequestMapping("/jmAuto/MS")
@RequiredArgsConstructor
public class MsController {
	private final MsService ms;
	private final BCryptPasswordEncoder passwordEncoder; 

	// 마이페이지 -> 사용자 유형별로 이동
	@GetMapping(value = "/view_ms/myPage")
	public String myPage(Model model, HttpSession session) {
		System.out.println("mscontroller myPage start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_type = user_table.getUser_type();
		System.out.println("사용자 유형:" + user_type);

		switch (user_type) {
		case "B":
			return myPage_B(model, session); // 구매자
		case "S":
			return myPage_S(model, session); // 판매자
		case "P":
			return myPage_P(model, session); // 전문가
		}
		return "redirect:/error";
	}
	

	
	
	

	// 마이페이지 메인 (B) - 구매자
	@GetMapping(value = "/view_ms/myPage_B")
	public String myPage_B(Model model, HttpSession session) {
		System.out.println("mscontroller myPage_B strat...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller userid=>"+user_id);
		// 결제 리스트 나오게
		List<Payment> buyList = null;
		buyList = ms.buyList(user_id);
		System.out.println("MsController buyList ->" + buyList);
		model.addAttribute("Payment", buyList);

		// 관심목록 리스트 나오게
		List<Zzim> ZzimList = null;
		ZzimList = ms.findZzim(user_id);
		System.out.println("mscontroller findzzim user_id->"+ user_id);
		System.out.println("MsController findZzim ZzimList->" + ZzimList);
		model.addAttribute("Zzim", ZzimList);

		return "view_ms/myPage_B";
	}

	// 마이페이지 메인 (S)- 판매자
	@GetMapping(value = "/view_ms/myPage_S")
	public String myPage_S(Model model, HttpSession session) {
		System.out.println("mscontroller myPage_S strat...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();

		// 나의 판매중인 차량 나오게
		List<Car_General_Info> sellCar = ms.sellCar(user_id);
		System.out.println("mscontroller sellCar user_id"+user_id);
		System.out.println("mscontroller myPage_S sellCar->" + sellCar);
		model.addAttribute("Car_General_Info", sellCar);

		// 나의 판매완료 매물 나오게
		List<Car_General_Info> sellWan = ms.sellWan(user_id);
		model.addAttribute("sellWan", sellWan);
		System.out.println("mscontroller myPage_S sellWan ->" + sellWan);

		return "view_ms/myPage_S";
	}

	// 마이페이지 메인 (P) - 전문가
	@GetMapping(value = "/view_ms/myPage_P")
	public String myPage_P(Model model, HttpSession session) {
		System.out.println("mscontroller myPage_P strat...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();

		// 나의 관심내역 나오게
		List<Zzim> ZzimList = null;
		ZzimList = ms.findZzim(user_id);
		System.out.println("mscontroller myPage_P ZzimList ->" + ZzimList);
		model.addAttribute("Zzim", ZzimList);
		
		// 나의 전문가리뷰 나오게
		List<Expert_Review> expert_reviewList = null;
		expert_reviewList = ms.myExpertReview(user_id);
		System.out.println("mscontroller myPage_P expertReviews expert_reviewList->" + expert_reviewList);
		model.addAttribute("Expert_Review", expert_reviewList);

		return "view_ms/myPage_P";
	}

	// 마이페이지(구매자) 1.-> 회원정보수정 누르면 실행되는 체크화면..
	@GetMapping(value = "/view_ms/myPageEditCheck")
	public String checkPassword(Model model, HttpSession session) {
		User_Table user_table=(User_Table)session.getAttribute("user");
		System.out.println("msController checkPassword userTable->" + user_table);
		return "view_ms/myPageEditCheck";
	}

	// 마이페이지(전문가) 1.-> 회원정보수정 누르면 실행되는 체크화면..
	@GetMapping(value = "/view_ms/myPageEditCheck_P")
	public String checkPassword_P(User_Table user_table, Model model) {
		System.out.println("msController checkPassword_P userTable->" + user_table);
		return "view_ms/myPageEditCheck_P";
	}

	// 마이페이지(판매자) 1.-> 회원정보수정 누르면 실행되는 체크화면..
	@GetMapping(value = "/view_ms/myPageEditCheck_S")
	public String checkPassword_S(User_Table user_table, Model model) {
		System.out.println("msController checkPassword_S userTable->" + user_table);
		return "view_ms/myPageEditCheck_S";
	}

	// (구매자)비밀번호가 안맞으면 위에 1번으로, 맞게 적으면 해당 로직을 돌려서 2번으로
	@GetMapping("/view_ms/myPageEdit")
	public String pwCheck(Model model, HttpSession session) {
		User_Table user_table = (User_Table) session.getAttribute("user");
		System.out.println("mscontroller 회원수정중 user_table->"+user_table);
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller user user_id->"+user_id);
		
		if (user_table != null) { // 사용자 정보를 모델에 추가하여 뷰에서 사용
			user_table = ms.user(user_id);
			model.addAttribute("user", user_table);
			System.out.println("mscontroller 회원수정중 user_table->"+user_table);
			return "view_ms/myPageEdit"; // 회원정보 수정 페이지로 이동
		} else {
			return "redirect:/login"; // 세션에 정보가 없으면 로그인 페이지로 리다이렉트
		}
	}

	// (판매자)비밀번호가 안맞으면 위에 1번으로, 맞게 적으면 해당 로직을 돌려서 2번으로
	@GetMapping("/view_ms/myPageEdit_S")
	public String pwCheck_S(Model model, HttpSession session) {
		User_Table user_table = (User_Table) session.getAttribute("user");
		System.out.println("mscontroller 회원수정중 user_table->"+user_table);
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller user user_id->"+user_id);
		
		if (user_table != null) { 
			System.out.println("mscontroller user user_id->"+user_id);
			user_table = ms.user(user_id);
			model.addAttribute("user", user_table);
			System.out.println("mscontroller 회원수정중 user_table->"+user_table);
			return "view_ms/myPageEdit_S"; 
		} else {
			return "redirect:/login"; 
		}
	}

	// (전문가)비밀번호가 안맞으면 위에 1번으로, 맞게 적으면 해당 로직을 돌려서 2번으로
	@GetMapping("/view_ms/myPageEdit_P")
	public String pwCheck_P(Model model, HttpSession session) {
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller user user_id->"+user_id);
		if (user_table != null) { 
			user_table = ms.user(user_id);
			model.addAttribute("user", user_table);
			System.out.println("mscontroller 회원수정중 user_table->"+user_table);
			return "view_ms/myPageEdit_P"; 
		} else {
			return "redirect:/login";
		}
	}

	

	// 마이페이지 2.-> 회원정보 수정시 두 비밀번호체크 로직 (ajax로 갔다가 돌아오는 거임)
	@ResponseBody
	@GetMapping(value = "/view_ms/pwChk")
	public int checkPassword(String input_pw, HttpSession session, Model model) {
		int result = 0;
		User_Table user_table = (User_Table) session.getAttribute("user");
		if (user_table != null) {
			model.addAttribute("user", user_table);
		}
		String myselfid = user_table.getUser_id();
		String dbUser_pw = ms.findByPw(myselfid);
		//입력한 비밀번호와 DB에 저장된 해시된 비밀번호를 비교
		boolean passwordMatch = passwordEncoder.matches(input_pw, dbUser_pw);
		if(passwordMatch){
			result = 1;
		} else{
		  result =	0;
		}
		return result;
	}

	// 구매자(회원정보 수정)
	@PostMapping("/myPageEdit")
	public String userUpdate(@RequestParam String user_id, 
							 @RequestParam String user_pw1, 
							 @RequestParam String user_pw2,
							 @RequestParam String user_tel, 
							 @RequestParam String user_zipcode, 
							 @RequestParam String user_addr1,
							 @RequestParam String user_addr2) {
		System.out.println("mscontroller userUpdate start...");
		System.out.println("mscontroller userUpdate user_id..." + user_id);
		User_Table user_table = new User_Table();
		user_table.setUser_id(user_id);		

		//비밀번호 해쉬화
		String password = passwordEncoder.encode(user_pw1);
		user_table.setUser_pw(password);
		
		//user_table.setUser_pw(user_pw1);
		user_table.setUser_tel(user_tel);
		user_table.setUser_zipcode(user_zipcode);
		user_table.setUser_addr1(user_addr1);
		user_table.setUser_addr2(user_addr2);
		//위처럼 담아서 호출하는 게 맞는 것 같은데 안해도 가능하네..?
		//->클래스 필드일음과 파라미터 이름이 일치해서 자동으로 설정된것.(자동데이터바인딩 덕분)
		System.out.println("user_pw1->" + user_pw1);
		System.out.println("user_pw2->" + user_pw2);
		System.out.println("user_table->" + user_table);
		ms.userUpdate(user_table);
		
		
		System.out.println("user_table->" + user_table);
		return "view_ms/userUpdate";
	}
	
	// 판매자(회원정보 수정)
	@PostMapping("/myPageEdit_S")
	public String userUpdate_S(@RequestParam String user_id, 
							 @RequestParam String user_pw1, 
							 @RequestParam String user_pw2,
							 @RequestParam String user_tel, 
							 @RequestParam String user_zipcode, 
							 @RequestParam String user_addr1,
							 @RequestParam String user_addr2) {
		System.out.println("mscontroller userUpdate start...");
		System.out.println("mscontroller userUpdate user_id..." + user_id);
		User_Table user_table = new User_Table();
		user_table.setUser_id(user_id);		

		//비밀번호 해쉬화
		String password = passwordEncoder.encode(user_pw1);
		user_table.setUser_pw(password);
		
		//user_table.setUser_pw(user_pw1);
		user_table.setUser_tel(user_tel);
		user_table.setUser_zipcode(user_zipcode);
		user_table.setUser_addr1(user_addr1);
		user_table.setUser_addr2(user_addr2);
		//위처럼 담아서 호출하는 게 맞는 것 같은데 안해도 가능하네..?
		//->클래스 필드일음과 파라미터 이름이 일치해서 자동으로 설정된것.(자동데이터바인딩 덕분)
		System.out.println("user_pw1->" + user_pw1);
		System.out.println("user_pw2->" + user_pw2);
		System.out.println("user_table->" + user_table);
		ms.userUpdate(user_table);
		System.out.println("user_table->" + user_table);
		return "view_ms/userUpdate_S";
	}

	
	// 전문가(회원정보 수정)
	@PostMapping("/myPageEdit_P")
	public String userUpdate_P(@RequestParam String user_id, 
							 @RequestParam String user_pw1, 
							 @RequestParam String user_pw2,
							 @RequestParam String user_tel, 
							 @RequestParam String user_zipcode, 
							 @RequestParam String user_addr1,
							 @RequestParam String user_addr2) {
		System.out.println("mscontroller userUpdate start...");
		System.out.println("mscontroller userUpdate user_id..." + user_id);
		User_Table user_table = new User_Table();
		user_table.setUser_id(user_id);		

		//비밀번호 해쉬화
		String password = passwordEncoder.encode(user_pw1);
		user_table.setUser_pw(password);
		
		//user_table.setUser_pw(user_pw1);
		user_table.setUser_tel(user_tel);
		user_table.setUser_zipcode(user_zipcode);
		user_table.setUser_addr1(user_addr1);
		user_table.setUser_addr2(user_addr2);
		//위처럼 담아서 호출하는 게 맞는 것 같은데 안해도 가능하네..?
		//->클래스 필드일음과 파라미터 이름이 일치해서 자동으로 설정된것.(자동데이터바인딩 덕분)
		System.out.println("user_pw1->" + user_pw1);
		System.out.println("user_pw2->" + user_pw2);
		System.out.println("user_table->" + user_table);
		ms.userUpdate(user_table);
		System.out.println("user_table->" + user_table);
		return "view_ms/userUpdate_P";
	}
	
	
	
	
	
	
	
	// 구매자(구매내역)
	@GetMapping(value = "/view_ms/buyList")
	public String buyList(Model model, HttpSession session) {
		System.out.println("mscontroller buyList start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller buyList user_id->" + user_id);

		List<Payment> buyList = null;
		buyList = ms.buyList(user_id);
		System.out.println("MsController buyList ->" + buyList);
		model.addAttribute("Payment", buyList);
		return "view_ms/buyList";
	}

	// 구매자(구매내역) -> 상세페이지
	@GetMapping(value = "/view_ms/buyListDetail")
	public String buyListDetail(Model model, HttpSession session, @RequestParam String approval_num, Payment payment) {
		System.out.println("msController buyListDetail start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller buyListDetail user_id->" + user_id);

		Payment buyList = ms.buyListDetail(approval_num, user_id);
		System.out.println("MsController buyListDetail buyList ->" + buyList);
		model.addAttribute("Payment", buyList);
		
		//이미 작성한 후기가 있는지 확인	
		boolean reviewExists = ms.reviewExists(user_id,approval_num);
		System.out.println("MsController buyListDetail reviewExists->"+reviewExists);
		model.addAttribute("reviewExists",reviewExists);		
			
		//후기말고 그냥 값으로 가져오기..
		Review review = ms.hoogiya(user_id, approval_num);
		System.out.println("mscontroller buyListDetail review->"+ review);
		model.addAttribute("hoogiya",review);
		
		return "view_ms/buyListDetail";
	}

	// 구매상세페이지 -> 후기 작성화면으로 이동 (현재 지원씨가 만들고 계씸)
	@GetMapping(value = "/view_ms/hoogi")
	public String hoogi(Model model, Payment payment) {
		System.out.println("msController hoogi start..");
		System.out.println("msController hoogi payment.getApproval_num->" + payment.getApproval_num());
		model.addAttribute("approval_num", payment.getApproval_num());
		//approval_num을 가지고 이동,, + car_general_info 정보도 뿌려주어야 함...
		
		List<Car_General_Info> car_general_info = ms.gumaeHoogi(payment.getApproval_num());
		model.addAttribute("car_general_info",car_general_info);
		return "view_ms/hoogiWrite";
	}


	// 구매상세페이지 -> 작성한 후기 저장
	@RequestMapping(value = "/view_ms/hoogiwrite")
	public String hoogiwrite( HttpServletRequest request,
							  HttpSession session, 
							  Model model,
							  RedirectAttributes redirectAttributes,
							  ReviewListInfo ri) throws IOException, ServletException {
		
		System.out.println("msController hoogiwrite start..");
		
		// 유저 정보 가져오기
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("msController user_table user_id->"+user_id);	   
	    
	    String review_title   = request.getParameter("review_title");
	    String review_content = request.getParameter("review_content");
	    String evaluationStr  = request.getParameter("evaluation");
	    String approval_num = request.getParameter("approval_num");
	    
	    // 파일이 하나라도 첨부되었을 경우에만 review 객체 생성 및 처리
		   
		// Review 객체 생성 + 저장할 후기 내용들
		Review review = new Review();
		review.setUser_id(user_id);	//유저 아이디 가져오기
		review.setApproval_num(approval_num);	//승인번호 가져오기
		review.setReview_title(review_title);
		review.setReview_content(review_content);
		review.setEvaluation(Integer.parseInt(evaluationStr)); // 문자열 숫자로 변환 
		
		System.out.println("mscontroller hoogiwrite review->"+review);
	    
		// 첨부파일 경로
	    String file_url = "/cs/review/";
		// Servlet 상속 받지 못했을 떄 realPath 불러 오는 방법
		String uploadPath = request.getSession().getServletContext().getRealPath(file_url);
		review.setFile_url(file_url);   // 후기파일경로

		// 첨부한 파일
		//--------------- image1 Start -----------------------------------------------------
		Part image1 = request.getPart("fileUpload1");
		int count = 0;
		if (image1.getSize() > 0) { // 파일이 첨부된 경우
			InputStream inputStream1 	= image1.getInputStream();
			String fileName1 			= image1.getSubmittedFileName();
			String originalName1 		= getfileName(fileName1, 1);
			String suffix1				= getfileName(fileName1, 2);
			count = 1;
			String savedName1 			= uploadFile(approval_num, count, inputStream1, uploadPath, suffix1);
			
			review.setFile_name1(savedName1); // 후기파일이름1
		 }
		//--------------- image1 End -----------------------------------------------------
	    
	    //--------------- image2 Start -----------------------------------------------------
	    Part image2 = request.getPart("fileUpload2");
	    
	    if (image2.getSize() > 0) { // 파일이 첨부된 경우
	    	
		    InputStream inputStream2 	= image2.getInputStream();
		    String fileName2 			= image2.getSubmittedFileName();
		    String originalName2 		= getfileName(fileName2, 1);
		    String suffix2 				= getfileName(fileName2, 2);
		    count = 2;
		    String savedName2 			= uploadFile(approval_num, count, inputStream2, uploadPath, suffix2);
		    
		    review.setFile_name2(savedName2); // 후기파일이름2
	    }
	  //--------------- image2 End -----------------------------------------------------
	    
	  //--------------- image3 Start -----------------------------------------------------
	    Part image3 				= request.getPart("fileUpload3");
	    
	    if (image3.getSize() > 0) { // 파일이 첨부된 경우
	    	
		    InputStream inputStream3 	= image3.getInputStream();
		    String fileName3 			= image3.getSubmittedFileName();
		    String originalName3 		= getfileName(fileName3, 1);
		    String suffix3 				= getfileName(fileName3, 2);
		    count = 3;
		    String savedName3 			= uploadFile(approval_num, count, inputStream3, uploadPath, suffix3);
		    
		    review.setFile_name3(savedName3); // 후기파일이름
		}
	  //--------------- image3 End -----------------------------------------------------

	    // 아래 private까지 다 한걸 가져와서 여기서 전부 처리
		int insertResult = ms.hoogiwrite(review);
		System.out.println("mscontroller hoogiwrite insertResult->"+insertResult);
			
		model.addAttribute("review", review);
		System.out.println("mscontroller hoogiwrite review->"+review);
		
		// FlashAttribute로 메시지를 전달
	    redirectAttributes.addFlashAttribute("message", "후기 작성이 완료되었습니다");

	    // 리다이렉트 후 상세 페이지로 이동
	    String redirectUrl = "/view_ms/reviewDetail?approval_num=" + approval_num;
	   
		return "redirect:" + redirectUrl;		
	}
	

	
	
	// 파일 확장자 구하기  
	private  String getfileName(String fileName, int gubun) {
		String rtnName = "";
	    System.out.println("fileName->"+fileName);
	   
	    // 파일명에 '.'이 없을 경우 예외 처리
	    if (!fileName.contains(".")) {
	    	
	        // 확장자가 없는 경우 기본 값 설정
	        if (gubun == 1) {
	            return fileName; // 전체 파일명을 반환
	        } else {
	            return ""; // 확장자가 없으므로 빈 문자열 반환
	        }
	        
	    }
	    
	 // 파일명에 '.'이 있는 경우 처리
	    String[] split = fileName.split("\\.");
	    if (split.length < 2) {
	        // 확장자가 없는 경우
	        if (gubun == 1) {
	            rtnName = split[0]; // 확장자 없는 파일명
	        }
	    } else {
	        // 확장자가 있는 경우
	        String originalName = split[split.length - 2];
	        String suffix = split[split.length - 1];

	        // gubun == 1 -> 파일명 반환, gubun == 2 -> 확장자 반환
	        if (gubun == 1) {
	            rtnName = originalName;
	            System.out.println("originalName->" + originalName);
	        } else if (gubun == 2) {
	            rtnName = suffix;
	            System.out.println("suffix->" + suffix);
	        }
	    }

	    System.out.println("getfileName rtnName->" + rtnName);
	    return rtnName;
	}
  
	// 첨부파일 저장 폴더 생성
	private String uploadFile(	String			approval_num,
								int				count,
					            InputStream 	inputStream, 
					            String 			uploadPath, 
					            String 			suffix) 
					            throws FileNotFoundException, IOException {

		// requestPath = requestPath + "/resources/image";
		System.out.println("uploadPath->"+uploadPath);
		// Directory 생성 
		File fileDirectory = new File(uploadPath);
		if (!fileDirectory.exists()) {
			// 신규 폴더(Directory) 생성 
			fileDirectory.mkdirs();
			System.out.println("업로드용 폴더 생성 : " + uploadPath);
		}
		
		String savedName = "review_" + approval_num + "_" + count + "." + suffix;
		log.info("savedName: " + savedName);
		// 임시파일 생성
		File tempFile = new File(uploadPath+savedName);
		
		
		// 생성된 임시파일에 요청으로 넘어온 file의 inputStream 복사
		try (FileOutputStream outputStream = new FileOutputStream(tempFile)) {
			int read;
			// 2K*K
			byte[] bytes = new byte[2048000];
			while ((read = inputStream.read(bytes)) != -1) {
				// Target File에 요청으로 넘어온 file의 inputStream 복사
				outputStream.write(bytes, 0, read);
			} 
		} finally {
				System.out.println("UpLoad The End");
		}
		
		return savedName;
	}

	// 구매상세페이지 -> 이미 작성한 후기보기
	@GetMapping(value = "/view_ms/reviewDetail")
    public String reviewDetail(HttpSession session, 
                                Model model,
                                @RequestParam(name="approval_num", required = true) String approval_num) {
        System.out.println("위의 approval_num->"+approval_num);


        System.out.println("msController reviewDetail start...");

        User_Table user_table = (User_Table) session.getAttribute("user");
        String user_id = user_table.getUser_id();
        System.out.println("msController reviewDetail user_id->" + user_id);

        ReviewListInfo ri = ms.myhoogiDetail(approval_num);
        System.out.println("mscontroller ri->"+ri);

        model.addAttribute("ri", ri);
        System.out.println("mscontroller reviewDetail ri->" + ri);
        
        
        Review review = ms.del_state(approval_num);
        System.out.println("mscontroller reviewDetail review->"+ review);

        return "view_ms/reviewDetail";
    }
	

	// 구매자(관심목록)
	@GetMapping(value = "/view_ms/myZzim")
	public String myZzim(Model model, HttpSession session) {
		System.out.println("mscontroller myZzim start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myZzim user_id->" + user_id);

		List<Zzim> ZzimList = null;
		ZzimList = ms.findZzim(user_id);
		System.out.println("MsController myZzim ZzimList->" + ZzimList);
		model.addAttribute("Zzim", ZzimList);
		return "view_ms/myZzim";
	}

	// 전문가(관심목록)
	@GetMapping(value = "/view_ms/myZzim_P")
	public String myZzim_P(Model model, HttpSession session) {
		System.out.println("mscontroller myZzim_P start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myZzim_P user_id->" + user_id);

		List<Zzim> ZzimList = null;
		ZzimList = ms.findZzim(user_id);
		System.out.println("MsController myZzim_P ZzimList->" + ZzimList);
		model.addAttribute("Zzim", ZzimList);
		return "view_ms/myZzim_P";
	}

	// 구매자(구매한 전문가리뷰 리스트)
	@GetMapping(value = "/view_ms/reviewList")
	public String reviewList(Model model, HttpSession session) {
		log.info("MsController reviewList start..");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller reviewList user_id->" + user_id);

		List<Expert_Review> expertReviews = null;
		expertReviews = ms.expertReviews(user_id);
		model.addAttribute("Expert_Review", expertReviews);
		
		
		
		
		System.out.println("mscontroller reviewList expertreviews->" + expertReviews);
		return "view_ms/reviewList";
	}

	
	
	// 구매자(구매한 전문가리뷰) -> 상세페이지(현재는 리스트 항목에 대해 클릭한 데이터를 보여주기만 할뿐 화면이X)
	@GetMapping(value = "/view_ms/reviewListDetail")
	public String reviewDetail(Model model, HttpSession session, @RequestParam String expert_review_num) {
		System.out.println("msController reviewDetail start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller reviewDetail user_id->" + user_id);

		Expert_Review expertnum = ms.reviewDetail(expert_review_num, user_id);
		System.out.println("MsController reviewDetail expertnum ->" + expertnum);
		model.addAttribute("Expert_Review", expertnum);
		return "view_ms/reviewListDetail";
	}

	// 구매자(고객센터문의내역)
	@GetMapping(value = "/view_ms/myQna")
	public String myQnaList(Model model, HttpSession session) {
		System.out.println("mscontroller myQnaList start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaList user_id->" + user_id);

		List<Qna> QnaList = null;
		QnaList = ms.QnaList(user_id);
		System.out.println("MsController myQnaList QnaList ->" + QnaList);
		model.addAttribute("Qna", QnaList);
		return "view_ms/myQna";
	}

	// 전문가(고객센터문의내역)
	@GetMapping(value = "/view_ms/myQna_P")
	public String myQnaList_P(Model model, HttpSession session) {
		System.out.println("mscontroller myQnaList_P start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaList_P user_id->" + user_id);

		List<Qna> QnaList = null;
		QnaList = ms.QnaList(user_id);
		System.out.println("MsController myQnaList_P QnaList ->" + QnaList);
		model.addAttribute("Qna", QnaList);
		return "view_ms/myQna_P";
	}

	// 판매자(고객센터문의내역)
	@GetMapping(value = "/view_ms/myQna_S")
	public String myQnaList_S(Model model, HttpSession session) {
		System.out.println("mscontroller myQnaList_S start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaList_S user_id->" + user_id);

		List<Qna> QnaList = null;
		QnaList = ms.QnaList(user_id);
		System.out.println("MsController myQnaList_S QnaList ->" + QnaList);
		model.addAttribute("Qna", QnaList);
		return "view_ms/myQna_S";
	}

	// 구매자(고객센터문의내역) -> 상세페이지
	@GetMapping(value = "/view_ms/myQnaDetail")
	public String myQnaDetail(Model model, HttpSession session, @RequestParam long qna_num) {
		System.out.println("msController myQnaDetail start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaDetail user_id->" + user_id);

		Qna qnanum = ms.myQnaDetail(qna_num, session);

		System.out.println("MsController myQnaDetail qnanum ->" + qnanum);
		model.addAttribute("Qna", qnanum);
		return "view_ms/myQnaDetail";
	}

	// 전문가(고객센터문의내역) -> 상세페이지
	@GetMapping(value = "/view_ms/myQnaDetail_P")
	public String myQnaDetail_P(Model model, HttpSession session, @RequestParam long qna_num) {
		System.out.println("msController myQnaDetail_P start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaDetail_P user_id->" + user_id);

		Qna qnanum = ms.myQnaDetail(qna_num, session);

		System.out.println("MsController myQnaDetail_P qnanum ->" + qnanum);
		model.addAttribute("Qna", qnanum);
		return "view_ms/myQnaDetail_P";
	}

	// 판매자(고객센터문의내역) -> 상세페이지
	@GetMapping(value = "/view_ms/myQnaDetail_S")
	public String myQnaDetail_S(Model model, HttpSession session, @RequestParam long qna_num) {
		System.out.println("msController myQnaDetail_S start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaDetail_S user_id->" + user_id);

		Qna qnanum = ms.myQnaDetail(qna_num, session);

		System.out.println("MsController myQnaDetail_S qnanum ->" + qnanum);
		model.addAttribute("Qna", qnanum);
		return "view_ms/myQnaDetail_S";
	}

	// 구매자(문의내역) -> 선택삭제 (update로 변경완)
	@PostMapping("/myQnaDelete")
	public String deleteQna(HttpSession session, @RequestBody List<Long> Qnanum) {
		System.out.println("mscontroller deleteQna start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller deleteQna user_id->" + user_id);
		System.out.println("mscontroller deleteQna Qnanum->" + Qnanum);

		int deleteQna = ms.deleteQna(user_id, Qnanum);
		System.out.println("MsController deleteQna ->" + deleteQna);
		return "redirect:/view_ms/myQna";
	}
	


	// 전문가(문의내역) -> 선택삭제 (update로 변경완)
	@PostMapping("/myQnaDelete_P")
	public String deleteQna_P(HttpSession session, @RequestBody List<Long> Qnanum) {
		System.out.println("mscontroller deleteQna_P start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller deleteQna_P user_id->" + user_id);
		System.out.println("mscontroller deleteQna_P Qnanum->" + Qnanum);

		int deleteQna = ms.deleteQna(user_id, Qnanum);
		System.out.println("MsController deleteQna_P ->" + deleteQna);
		return "redirect:/view_ms/myQna_P";
	}

	// 판매자(문의내역) -> 선택삭제 (update로 변경완)
	@PostMapping("/myQnaDelete_S")
	public String deleteQna_S(HttpSession session, @RequestBody List<Long> Qnanum) {
		System.out.println("mscontroller deleteQna_S start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller deleteQna_S user_id->" + user_id);
		System.out.println("mscontroller deleteQna_S Qnanum->" + Qnanum);

		int deleteQna = ms.deleteQna(user_id, Qnanum);
		System.out.println("MsController deleteQna_S ->" + deleteQna);
		return "redirect:/view_ms/myQna_S";
	}
	
	// 구매자(문의상세내역) -> 보고있는 문의삭제 
	@PostMapping("/myQnaDetailDelete")
	public String myQnaDetailDelete(HttpSession session, @RequestParam Long qna_num) {
		System.out.println("mscontroller myQnaDetailDelete start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaDetailDelete user_id->" + user_id);
		System.out.println("mscontroller myQnaDetailDelete Qnanum->" + qna_num);

		int deleteQna = ms.qnaDetailDelete(user_id, qna_num);
		System.out.println("MsController myQnaDetailDelete ->" + deleteQna);
		return "redirect:/view_ms/myQna";
	}
	
	// 판매자(문의상세내역) -> 보고있는 문의삭제 
	@PostMapping("/myQnaDetailDelete_S")
	public String myQnaDetailDelete_S(HttpSession session, @RequestParam Long qna_num) {
		System.out.println("mscontroller myQnaDetailDelete_S start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaDetailDelete_S user_id->" + user_id);
		System.out.println("mscontroller myQnaDetailDelete_S Qnanum->" + qna_num);

		int deleteQna = ms.qnaDetailDelete(user_id, qna_num);
		System.out.println("MsController myQnaDetailDelete_S ->" + deleteQna);
		return "redirect:/view_ms/myQna_S";
	}
	
	// 전문가(문의상세내역) -> 보고있는 문의삭제 
	@PostMapping("/myQnaDetailDelete_P")
	public String myQnaDetailDelete_P(HttpSession session, @RequestParam Long qna_num) {
		System.out.println("mscontroller myQnaDetailDelete_P start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myQnaDetailDelete_P user_id->" + user_id);
		System.out.println("mscontroller myQnaDetailDelete_P Qnanum->" + qna_num);

		int deleteQna = ms.qnaDetailDelete(user_id, qna_num);
		System.out.println("MsController myQnaDetailDelete_P ->" + deleteQna);
		return "redirect:/view_ms/myQna_P";
	}
	
	
	//구매자(차량구매문의)
	@GetMapping("/view_ms/myNote")
	public String myNote(HttpSession session, Model model, Note note){
		System.out.println("mscontroller myNote start....");
		User_Table user_table =(User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myNote notesd->"+user_id);
		
		//내가 받은 쪽지함
		List<Note> receivedNotes = ms.ReceivedNotes(user_id);	
		model.addAttribute("Notes",receivedNotes);
		System.out.println("mscontroller myNote receivedNotes->"+receivedNotes);
		
		//내가 보낸 쪽지함
		List<Note> sendNotes = ms.SendNotes(user_id);
		model.addAttribute("SendNotes",sendNotes);
		System.out.println("mscontroller myNote sendNotes->"+sendNotes);			
		return "view_ms/myNote";	
	}
	
	//판매자(차량구매문의)
	@GetMapping("/view_ms/myNote_S")
	public String myNote_S(HttpSession session, Model model, Note note){
		System.out.println("mscontroller myNote_S start....");
		User_Table user_table =(User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myNote_S notesd->"+user_id);
		
		//내가 받은 쪽지함
		List<Note> receivedNotes = ms.ReceivedNotes(user_id);	
		model.addAttribute("Notes",receivedNotes);
		System.out.println("mscontroller myNote_S receivedNotes->"+receivedNotes);
		
		//내가 보낸 쪽지함
		List<Note> sendNotes = ms.SendNotes(user_id);
		model.addAttribute("SendNotes",sendNotes);
		System.out.println("mscontroller myNote_S sendNotes->"+sendNotes);					
		return "view_ms/myNote_S";	
	}
	
	//구매자(차량구매문의)-> 상세페이지
	@GetMapping("/view_ms/myNoteDetail")
	public String myNoteDetail(HttpSession session, Model model,@RequestParam int note_num){
		System.out.println("mscontroller myNoteDetail start....");
		User_Table user_table =(User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		session.getAttribute("user_id");
		System.out.println("mscontroller myNoteDetail note_sd->"+user_id);	
		System.out.println("mscontroller myNoteDetail note_num->"+note_num);
		
		Note noteDetail =ms.myNoteDetail(user_id, note_num);
		model.addAttribute("Note",noteDetail);
		System.out.println("mscontroller myNoteDetail myNoteList->"+noteDetail);
		return "view_ms/myNoteDetail";	
	}
	
	//판매자(차량구매문의)-> 상세페이지
	@GetMapping("/view_ms/myNoteDetail_S")
	public String myNoteDetail_S(HttpSession session, Model model,@RequestParam int note_num){
		System.out.println("mscontroller myNoteDetail_S start....");
		User_Table user_table =(User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		session.getAttribute("user_id");
		System.out.println("mscontroller myNoteDetail_S note_sd->"+user_id);	
		System.out.println("mscontroller myNoteDetail_S note_num->"+note_num);
		
		Note noteDetail =ms.myNoteDetail(user_id, note_num);
		model.addAttribute("Note",noteDetail);
		System.out.println("mscontroller myNoteDetail_S myNoteList->"+noteDetail);	
		return "view_ms/myNoteDetail_S";	
	}
	
	
	
	
	//판매자에게 보내는 쪽지양식으로 이동
    @GetMapping(value = "/view_ms/go_note_form")
    public String go_note_form() {
        System.out.println("쪽지Form으로 이동");
        return "view_ms/sending_note"; 
    }

    //판매자에게 쪽지 보내기
    @PostMapping(value = "/view_ms/sending_note")
    public String sending_note(HttpSession session, Model model,
                                @RequestParam ("sellNum") Long   sell_num,
                                @RequestParam ("id")       String note_rd,
                                @RequestParam ("title")   String note_title,
                                @RequestParam ("content") String note_content) {
        System.out.println("판매자에게 쪽지 보내기");
        User_Table user = (User_Table) session.getAttribute("user");
        String note_sd = user.getUser_id();


        System.out.println("매물번호 : " + sell_num);
        System.out.println("판매자의 id: " + note_rd);

        Note note = new Note();
        note.setSell_num(sell_num);
        note.setNote_sd(note_sd);
        note.setNote_rd(note_rd);
        note.setNote_title(note_title);
        note.setNote_content(note_content);
        int sending_note = ms.service_sending_note(note);

        if (sending_note > 0) {
            model.addAttribute("successYN", "1");
            System.out.println("MsController sending_note Success!!!");
            return "view_ms/sending_note_Success";

        // 실패시
        } else {
            System.out.println("MsController sending_note Failed...");
            return "redirect:/";
        }

    }

    
    
	
   //구매자(쪽지 답장하기 페이지)
	@GetMapping("/view_ms/myNoteDabjangWrite")
	public String myNoteDabjang(HttpSession session,
							    Model model, 
								@RequestParam int note_num,
								@RequestParam String note_rd,
								Note note) {
		System.out.println("mscontroller myNoteDabjang start..");
		System.out.println("mscontroller myNoteDabjang note_num->"+note_num);
		System.out.println("mscontroller myNoteDabjang note_rd->"+note_rd);
		model.addAttribute("note_num", note_num);
		model.addAttribute("note_rd", note_rd);
		
		User_Table user_table =(User_Table)session.getAttribute("user");
		String note_sd = user_table.getUser_id();
		System.out.println("mscontroller myNoteDetail note_sd->"+note_sd);
		
		Note noteDetail =ms.myNoteDetail(note_sd, note_num);
		model.addAttribute("Note",noteDetail);
		System.out.println("mscontroller myNoteDetail myNoteList->"+noteDetail);
		return "view_ms/myNoteDabjangWrite";
	}
	
	
	
	//판매자(쪽지 답장하기 페이지)
	@GetMapping("/view_ms/myNoteDabjangWrite_S")
	public String myNoteDabjangWrite_S(HttpSession session,
								    Model model, 
									@RequestParam int note_num,
									@RequestParam String note_rd,
									Note note) {
		System.out.println("mscontroller myNoteDabjangWrite_S start..");
		System.out.println("mscontroller myNoteDabjangWrite_S note_num->"+note_num);
		System.out.println("mscontroller myNoteDabjangWrite_S note_rd->"+note_rd);
		model.addAttribute("note_num", note_num);
		model.addAttribute("note_rd", note_rd);
			
		User_Table user_table =(User_Table)session.getAttribute("user");
		String note_sd = user_table.getUser_id();
		System.out.println("mscontroller myNoteDetail note_sd->"+note_sd);
			
		Note noteDetail =ms.myNoteDetail(note_sd, note_num);
		model.addAttribute("Note",noteDetail);
		System.out.println("mscontroller myNoteDabjangWrite_S myNoteList->"+noteDetail);
		return "view_ms/myNoteDabjangWrite_S";
	}

	
	
	
	
	
	
	
    //쪽지 답장하는 양식으로 이동
    @GetMapping(value = "/view_ms/go_noteDabjang_form")
    public String go_noteDabjang_form() {
        System.out.println("쪽지Form으로 이동");
        return "view_ms/sending_note_Dabjang"; 
    }
    
    
    //쪽지 답장하는 양식으로 이동
    @GetMapping(value = "/view_ms/go_noteDabjang_form_S")
    public String go_noteDabjang_form_S() {
        System.out.println("쪽지Form으로 이동_S");
        return "view_ms/sending_note_Dabjang_S"; 
    }
    
    
    
    
    
    
    //답장한 쪽지 저장
    @PostMapping("view_ms/myNoteDabjangWrite")
    public String myNoteDabjangWrite(HttpSession session, Note note,
                                    @RequestParam long note_num,
                                    @RequestParam String note_rd,
                                    @RequestParam String note_title,
                                    @RequestParam String note_content,
                                    @RequestParam long sell_num,
                                    Model model) {
        System.out.println("mscontroller myNoteDabjangWrite start...");
        User_Table user_table = (User_Table)session.getAttribute("user");
        String note_sd = user_table.getUser_id(); //지금 로그인 되어 있는 id (지금 보낼 사람)
        System.out.println("mscontroller myNoteDabjangWrite 받는이rd->"+note_rd); //해당 메세지를 보냈던 사람
        System.out.println("mscontroller myNoteDabjangWrite 보내는이sd->"+note_sd); //답장할사람, 나, (받는이였던 사람)
        System.out.println("mscontroller myNoteDabjangWrite note_num->"+note_num);
        System.out.println("mscontroller myNoteDabjangWrite note_title->"+note_title);
        System.out.println("mscontroller myNoteDabjangWrite note_content->"+note_content);

        Map<String, Object> params = new HashMap<>();
        params.put("note_sd", note_sd);
        params.put("note_rd", note_rd);
        params.put("note_num", note_num);
        params.put("note_title", note_title);
        params.put("note_content", note_content);
        params.put("sell_num", sell_num);

        int result = ms.noteDabjang(params);

        if (result > 0) {
            model.addAttribute("successYN", "1");
            System.out.println("MsController sending_note Success!!!");
            return "view_ms/sending_note_Dabjang_Success";

        // 실패시
        } else {
            System.out.println("MsController sending_note Failed...");
            return "redirect:/";
        }

    }
	
    //답장한 쪽지 저장
    @PostMapping("view_ms/myNoteDabjangWrite_S")
    public String myNoteDabjangWrite_S(HttpSession session, Note note,
                                    @RequestParam long note_num,
                                    @RequestParam String note_rd,
                                    @RequestParam String note_title,
                                    @RequestParam String note_content,
                                    @RequestParam long sell_num,
                                    Model model) {
        System.out.println("mscontroller myNoteDabjangWrite_S start...");
        User_Table user_table = (User_Table)session.getAttribute("user");
        String note_sd = user_table.getUser_id(); //지금 로그인 되어 있는 id (지금 보낼 사람)
        System.out.println("mscontroller myNoteDabjangWrite_S 받는이rd->"+note_rd); //해당 메세지를 보냈던 사람
        System.out.println("mscontroller myNoteDabjangWrite_S 보내는이sd->"+note_sd); //답장할사람, 나, (받는이였던 사람)
        System.out.println("mscontroller myNoteDabjangWrite_S note_num->"+note_num);
        System.out.println("mscontroller myNoteDabjangWrite_S note_title->"+note_title);
        System.out.println("mscontroller myNoteDabjangWrite_S note_content->"+note_content);

        Map<String, Object> params = new HashMap<>();
        params.put("note_sd", note_sd);
        params.put("note_rd", note_rd);
        params.put("note_num", note_num);
        params.put("note_title", note_title);
        params.put("note_content", note_content);
        params.put("sell_num", sell_num);

        int result = ms.noteDabjang(params);

        if (result > 0) {
            model.addAttribute("successYN", "1");
            System.out.println("MsController sending_note Success!!!");
            return "view_ms/sending_note_Dabjang_Success_S";

        // 실패시
        } else {
            System.out.println("MsController sending_note Failed...");
            return "redirect:/";
        }

    }
    
    
    
    
    
    
    
    
    
    
	//구매자 (쪽지 삭제)
	@PostMapping ("/myNoteDelete")
	public String deleteNote(HttpSession session, @RequestBody List<Integer> note_nums ) {
		System.out.println("mscontroller myNoteDelete start...");
		User_Table user_table = (User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontoller NoteDelete user_id->"+user_id);
		
		for(int note_num : note_nums) {
			System.out.println("mscontroller NoteDelete note_num->"+note_num);
			ms.deleteNote(note_num);
		}
		return "redirect:/view_ms/myNote"; 
	}
	
	//판매자 (쪽지 삭제)
	@PostMapping("/myNoteDelete_S")
	public String deleteNote_S(HttpSession session, @RequestBody List<Integer> note_nums ) {
		System.out.println("mscontroller deleteNote_S start...");
		User_Table user_table = (User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontoller deleteNote_S user_id->"+user_id);
		
		for(int note_num : note_nums) {
			System.out.println("mscontroller deleteNote_S note_num->"+note_num);
			ms.deleteNote(note_num);
		}
		return "redirect:/view_ms/myNote_S";
	}


	// 구매자(내가 작성한 후기 삭제) - (update 변경 완)
	@PostMapping("/myHoogiDelete")
	public String myHoogiDelete(HttpSession session, 
								@RequestParam(name = "approval_num") String approval_num) {
		System.out.println("msController myHoogiDelete start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myHoogiDelete user_id->" + user_id);
		System.out.println("mscontroller myHoogiDelete approval_num->" + approval_num);

		int hoogiDelete = ms.hoogiDelete(user_id, approval_num);
		System.out.println("mscontroller myHoogiDelete hoogiDelete->" + hoogiDelete);
		session.setAttribute("approval_num", approval_num);
		return "redirect:/view_ms/buyListDetail?approval_num="+approval_num;
	}


	// 나의 관심목록 삭제
	@PostMapping("/myZzimDelete")
	public String myZzimDelete(HttpSession session, @RequestBody List<Long> sell_num) {
		System.out.println("mscontroller myZzimDelete start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myZzimDelete user_id->" + user_id);
		System.out.println("mscontroller myZzimDelete sell_num->" + sell_num);

		int deleteZzim = ms.deleteZzim(user_id, sell_num);
		System.out.println("mscontroller myZzimDelete deleteZzim->" + deleteZzim);
		return "view_ms/myZzim";
	}

	
	// 판매자(현재 판매중, 판매완료차량 삭제) - 삭제여부 = 1로 변경
	
	@PostMapping("/sellCarDelete")
	public String sellCarDelete(HttpSession session, Model model, @RequestBody List<Long> sell_num ) {
		System.out.println("mscontroller sellCarDelete strat...");
		User_Table user_table = (User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller sellCarDelete user_id->"+user_id);
		System.out.println("msController sellCarDelete sell_num->"+sell_num);
		
		int sellcarD = ms.deletesell(user_id, sell_num);
		System.out.println("mscontroller sellCarDelete sellcarD->"+sellcarD);
		return "view_ms/sellList";	
	}
		
	// 전문가(나의 전문가 리뷰 보기 - 리스트 출력)
	@GetMapping("/view_ms/myExpertReview")
	public String myExpertReview(HttpSession session, Model model) {
		System.out.println("mscontroller myExpertReview start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myExpertReview user_id->" + user_id);

		// 리뷰 테이블에 차량기본정보의 자주 쓰이는 컬럼을 추가하지 않고 사용하기 위한 로직
		List<Car_General_Info> sellCar = null;
		sellCar = ms.sellCar(user_id);
		System.out.println("mscontroller myPage_S sellCar->" + sellCar);
		model.addAttribute("Car_General_Info", sellCar);		
		
		List<Expert_Review> expert_review = null;
		expert_review = ms.myExpertReview(user_id);
		model.addAttribute("Expert_Review", expert_review);
		return "view_ms/myExpertReview";
	}

	// 전문가(나의 전문가 리뷰 상세보기)
	@GetMapping("/view_ms/myExpertReviewDetail")
	public String myExpertReviewDetail(HttpSession session, Model model,
									   @RequestParam long expert_review_num) {
		System.out.println("mscontroller myExpertReviewDetail start...");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller myExpertReviewDetail user_id->" + user_id);
		System.out.println("mscontroller myExpertReviewDetail expert_review_num->" + expert_review_num);

		List<Expert_Review> expert_review = null;
		expert_review = ms.myExpertReviewDetail(user_id, expert_review_num);
		model.addAttribute("Expert_Review", expert_review);
		return "view_ms/myExpertReviewDetail";
	}

	// 판매자 - 나의 판매중인 차량 보기
	@GetMapping("/view_ms/sellList")
	public String mySellCar(HttpSession session, Model model) {
		System.out.println("mscontroller mySellCar start..");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller mySellCar user_id->" + user_id);

		List<Car_General_Info> mySellCar = ms.sellCar(user_id);
		model.addAttribute("Car_General_Info", mySellCar);
		System.out.println("mscontroller mySellCar mySellCar->" + mySellCar);
		return "view_ms/sellList";
	}

	// 판매자 - 나의 판매완료 차량보기
	@GetMapping("view_ms/sellWan")
	public String mySellWan(HttpSession session, Model model) {
		System.out.println("mscontroller mySellWan start..");
		User_Table user_table = (User_Table) session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller mySellWan user_id.." + user_id);

		List<Car_General_Info> sellWan = ms.sellWan(user_id);
		model.addAttribute("Car_General_Info", sellWan);
		System.out.println("mscontroller mySellWan sellWan->" + sellWan);
		return "view_ms/sellWan";
	}
	
	//판매자 - 판매완료 상세내역
	@GetMapping("view_ms/sellWanDetail")
	public String sellWanDetail(HttpSession session, Model model,@RequestParam long sell_num) {
		System.out.println("mscontroller sellWanDetail start...");
		User_Table user_table=(User_Table)session.getAttribute("user");
		String user_id = user_table.getUser_id();
		System.out.println("mscontroller sellWanDetail user_id->"+user_id);
		System.out.println("mscontroller sellWanDetail sell_num->"+sell_num);
		
		//approval_num가져오기 위한 로직
		System.out.println("mscontroller sellWanDetail approval start...");
		String approval_num = ms.approval(user_id, sell_num);	
		System.out.println("mscontroller sellWanDetail approval_num->"+approval_num);
		
		//퍈매완료한 매물에 대한 정보 가지고 올 로직
		Payment panmaeList=ms.sellListDetail(approval_num,user_id);		
		System.out.println("msService sellWanDetail panmaeList->"+panmaeList);
		model.addAttribute("Payment",panmaeList);
		return "view_ms/sellWanDetail";
	}
	
	//구매자(회원탈퇴페이지)
	@GetMapping("/view_ms/talTwae")
	public String talTwae(Model model, HttpSession session) {
		System.out.println("mscontroller talTwae start...");
		return "view_ms/talTwae";
	}
	
	//판매자(회원탈퇴페이지)
		@GetMapping("/view_ms/talTwae_S")
		public String talTwae_S(Model model, HttpSession session) {
			System.out.println("mscontroller talTwae_S start...");
			return "view_ms/talTwae_S";
		}
		
	//전문가(회원탈퇴페이지)
	@GetMapping("/view_ms/talTwae_P")
	public String talTwae_P(Model model, HttpSession session) {
		System.out.println("mscontroller talTwae_P start...");
		return "view_ms/talTwae_P";
	}

	//구매자(회원탈퇴)
	@PostMapping("/view_ms/talTwaeWan")
	public String talTwaeWan(Model model, HttpSession session, String input_pw) {
		System.out.println("mscontroller talTwaeWan start...");		
		int result = 0;
		User_Table user_table = (User_Table) session.getAttribute("user"); // 세션의 정보 가져오기

		if (user_table != null) {
			model.addAttribute("user", user_table);
		}
		String user_id = user_table.getUser_id(); // 위에서 세션의 정보를 가져왔으니 거기서 id 가져오기
		
		//비밀번호 해쉬화
		String password = passwordEncoder.encode(input_pw);
		user_table.setUser_pw(password);
				
		//user_table.setUser_pw(user_pw1);
		System.out.println("mscontroller talTwaeWan user_id..."+user_id);	
		String dbUser_pw = ms.findByPw(user_id); // id에 실제 저장되어 있는 패스워드
		
		String user_name = user_table.getUser_name();
		System.out.println("mscontroller talTwaeWan user_name..."+user_name);
		
		System.out.println("talTwaeWan 옴 input_pw-> " + input_pw); // 내가 입력한 패스워드가 무엇인가
		System.out.println("talTwaeWan 옴 dbUser_pw->" + dbUser_pw);// 실제 db 패스워드	
		if (passwordEncoder.matches(input_pw, dbUser_pw)) {
			result = 1;
			ms.taltwae(user_id);
			return "view_ms/talTwaeWan";
		} else {
			result = 0;
			return "redirect:/view_ms/talTwae";
		}
	}
	
	//판매자(회원탈퇴)
	@PostMapping("/view_ms/talTwaeWan_S")
	public String talTwaeWan_S(Model model, HttpSession session, String input_pw) {
		System.out.println("mscontroller talTwaeWan_S start...");		
		int result = 0;
		User_Table user_table = (User_Table) session.getAttribute("user"); // 세션의 정보 가져오기
		if (user_table != null) {
			model.addAttribute("user", user_table);
		}
		String user_id = user_table.getUser_id(); // 위에서 세션의 정보를 가져왔으니 거기서 id 가져오기
		
		//비밀번호 해쉬화
		String password = passwordEncoder.encode(input_pw);
		user_table.setUser_pw(password);
				
		//user_table.setUser_pw(user_pw1);
	
		System.out.println("mscontroller talTwaeWan_S user_id..."+user_id);	
		String dbUser_pw = ms.findByPw(user_id); // id에 실제 저장되어 있는 패스워드	
		String user_name = user_table.getUser_name();
		System.out.println("mscontroller talTwaeWan_S user_name..."+user_name);
		System.out.println("talTwaeWan_S 옴 input_pw-> " + input_pw); // 내가 입력한 패스워드가 무엇인가
		System.out.println("talTwaeWan_S 옴 dbUser_pw->" + dbUser_pw);// 실제 db 패스워드
		if (passwordEncoder.matches(input_pw, dbUser_pw)) {
			result = 1;
			ms.taltwae(user_id);
			return "view_ms/talTwaeWan_S";
		} else {
			result = 0;
			return "redirect:/talTwae_S";
		}		
	}
	
	//전문가(회원탈퇴)
	@PostMapping("/view_ms/talTwaeWan_P")
	public String talTwaeWan_P(Model model, HttpSession session, String input_pw) {
		System.out.println("mscontroller talTwaeWan_P start...");		
		int result = 0;
		User_Table user_table = (User_Table) session.getAttribute("user"); // 세션의 정보 가져오기
		if (user_table != null) {
			model.addAttribute("user", user_table);
		}
		String user_id = user_table.getUser_id(); // 위에서 세션의 정보를 가져왔으니 거기서 id 가져오기
		
		//비밀번호 해쉬화
		String password = passwordEncoder.encode(input_pw);
		user_table.setUser_pw(password);
				
		//user_table.setUser_pw(user_pw1);
		System.out.println("mscontroller talTwaeWan_P user_id..."+user_id);	
		String dbUser_pw = ms.findByPw(user_id); // id에 실제 저장되어 있는 패스워드	
		String user_name = user_table.getUser_name();
		System.out.println("mscontroller talTwaeWan_P user_name..."+user_name);		
		System.out.println("talTwaeWan_P 옴 input_pw-> " + input_pw); // 내가 입력한 패스워드가 무엇인가
		System.out.println("talTwaeWan_P 옴 dbUser_pw->" + dbUser_pw);// 실제 db 패스워드
		if (passwordEncoder.matches(input_pw, dbUser_pw)) {
			result = 1;
			ms.taltwae(user_id);
			return "view_ms/talTwaeWan_P";
		} else {
			result = 0;
			return "redirect:/view_ms/talTwae_P";
		}		
	}

}
