package com.oracle.jmAuto.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Faq;
import com.oracle.jmAuto.dto.Notice_Table;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.Review;
import com.oracle.jmAuto.dto.ReviewListInfo;

import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.service.jw.CsPaging;
import com.oracle.jmAuto.service.jw.CsService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class JwController {
	private final CsService cs;
	
	// 1. 메인페이지에서 CS 메인으로 이동되었을때
	@GetMapping(value = "/view_jw/csMain")
	public String csMain() {
		System.out.println("JwController csMain Start...");
		
		return "view_jw/csMain";
	}
	
	// 2. 자주묻는질문: 카테고리별 내용 가져오기
	@GetMapping(value = "/view_jw/csFaq")
	public String listFaqCategory(@RequestParam(value = "faqCls", required = false) 
									String faqCls, Model model) {
		System.out.println("JwController listFaqCategory Start...");
		System.out.println("JwController listFaqCategory faqCls->"+faqCls);
		
		List<Faq> listFaq = cs.listFaq();
		System.out.println("JwController listFaqCategory listFaq.size->"+listFaq.size());
		
		model.addAttribute("listFaq", listFaq);
		model.addAttribute("selectCls", faqCls);	//선택된 카테고리 값
		
		return "view_jw/csFaq";
	}		
	
	// 3. 신고·문의·민원
	
	// 3-1. 로그인 안한 비회원을 로그인하는 새 창으로 유도
	@RequestMapping(value = "/view_jw/csNotLogin")
	public String notLogin() {
		System.out.println("JwController notLogin Start...");
		
		return "view_jw/csNotLogin";
	}
	
	
	// 3-2. 로그인 한 회원에게 팝업창 뜸
	@RequestMapping(value = "/view_jw/csQna")
	public String openPop(HttpSession session, Model model) {
		System.out.println("JwController openPop Start...");
		
		// 유저 정보 가져오기
		User_Table user = (User_Table) session.getAttribute("user");
		String user_id = user.getUser_id();
		System.out.println("JwController openPop user_id->"+user_id);
		
		// 팝업창 띄우기
		List<Qna> qnaCls = cs.popOpen();
		System.out.println("JwController openPop qnaCls.size()->"+qnaCls.size());
		
		model.addAttribute("qnaClsList", qnaCls);		
		
		return "view_jw/csQna";
	}
	
	// 3-3. QnA 팝업창 내용작성
	@RequestMapping(value = "/view_jw/writeQna")
	public String writeQna(	HttpServletRequest request,
							HttpSession session, 
							Model model,
							@RequestParam ("qna_cls")		String qna_cls,
							@RequestParam ("qna_title")		String qna_title,
							@RequestParam ("qna_content")	String qna_content,
							@RequestParam (value = "file01", required = false) MultipartFile file) 
							throws IOException, ServletException {

		System.out.println("JwController writeQna Start...");
		
		// 유저 정보 가져오기
		User_Table user = (User_Table) session.getAttribute("user");
		String user_id = user.getUser_id();
		System.out.println("JwController writeQna user_id->"+user_id);
		
		// QnA 객체 생성
		Qna qna = new Qna(); 
	    qna.setQna_cls(qna_cls);
	    qna.setQna_title(qna_title);
	    qna.setQna_content(qna_content);
	    qna.setUser_id(user_id);	// 유저 아이디 가져오기
		System.out.println("JwController writeQna qna->"+qna);

        //  QnA 데이터 먼저 저장해서 QNA_NUM을 가져오기 
		// ↳ (데이터가 저장되어야 QNA_NUM이 생성됨)
		int insertResult = cs.insertQna(qna);
		
		System.out.println("JwController writeQna insertResult->"+insertResult);
		
		// 성공시 팝업을 닫고, 다른 새 창으로 이동
		if (insertResult > 0) {	
			// but! 만약 첨부파일이 존재할시, 파일 로직 작동
			// 생성된 QNA_NUM 가져오기
			int qna_num = qna.getQna_num();
			System.out.println("JwController writeQna maked qna_num->"+qna_num);
			
			if (file != null && !file.isEmpty()) {
				
				// View에 넣을 파일정보
				Part viewUploadFile = request.getPart("file01");
				System.out.println("JwController uploadFile viewUploadFile->"+viewUploadFile);
				
				// 이용자가 입력한 파일 날짜에서 데이터 가져오기
				String qna_date = new SimpleDateFormat("yyyyMMdd").format(new Date());
				System.out.println("today qna_date->"+qna_date);
				
				// 파일 경로 지정: Servlet을 상속 받지 못했을 때 realPath를 불러오는 방법
				String upload = "/cs/qna/";
				String uploadPath = request.getSession().getServletContext().getRealPath(upload);				
				System.out.println("JwController uploadFile uploadPath->"+uploadPath);

				// 원래 파일 . 기준으로 파일명과 확장자로 나누기
					// InputStream이란?: 바이트 데이터가 들어오는 통로의 역할이 기술된 추상 클래스
				InputStream inputStream = viewUploadFile.getInputStream();
				String file_name = viewUploadFile.getSubmittedFileName();
				String[] split = file_name.split("\\.");
				System.out.println("divide file_name->"+file_name);
				
				String suffix = split[split.length - 1];
				System.out.println("divide suffix->"+suffix);	// 원 파일에서 확장자명
				
				
				// 새로 저장할 파일정보(문의날짜, 문의PK, realPath, 확장자)
				String savedName = uploadFile(qna_date, qna_num, inputStream, uploadPath, suffix);
				
				// ↑---------↓
				// 다시 아래에서 만들어진 saveNamed을 가지고와서 Service 작동
				// QnA 객체 생성
				qna.setFile_name(savedName);
				qna.setFile_url(upload);
				System.out.println("JwController writeQna qna->"+qna);

				
				// 3-4. QnA 파일명, url
				int result = cs.updateFile(qna);
				// 파일 입력 실패시
				if(result == 0) {
					System.out.println("파일 업데이트 실패. 다시 확인해주세요.");
					return "forward:csQna";	
				}	
		
				// 파일 입력까지 성공시
				model.addAttribute("savedName", savedName);
				System.out.println("JwController uploadFile savedName->"+savedName);
				
			}
			// 파일 유무 포함 전부 성공시 작동
			model.addAttribute("successYN", "1");
			System.out.println("JwController writeQna Success...");
			
			return "view_jw/csQnaSuccess";
		
		// 전송 실패시
		} else {
			model.addAttribute("msg", "작성 실패. 내용을 확인해주세요.");
			System.out.println("JwController writeQna Failed...");
			
			return "forward:csQna";
		}
        
	}

	// String savedName = uploadFile(qna_date, qna_num, inputStream, uploadPath, suffix);
	// uploadFile에서 create된 private
	private String uploadFile(String qna_date, 
							int qna_num,  
							InputStream inputStream,
							String uploadPath, 
							String suffix) throws IOException {
		
		System.out.println("private uploadFile Start...");
		
		// 1.위의 로직을 기반으로 한 새로 저장될 파일명 세팅!
		String savedName = "qna" + "_" + qna_date + "_" + qna_num + "." + suffix;
		System.out.println("private uploadFile savedName->"+savedName);
		
		// 2. 업로드할 파일을 저장할 폴더 생성 + RealPath 사용
		// 만약 저장할 폴더가 존재하지 않을시, 신규 폴더(Directory) 생성
		File fileDirectory = new File(uploadPath);
		
		if (!fileDirectory.exists()) {
			try {
				fileDirectory.mkdirs();
				System.out.println("새 폴더 생성 완료!->"+fileDirectory);
				System.out.println("폴더 경로"+uploadPath);
				
			} catch (Exception e) {
				System.out.println("폴더 생성 실패->"+e.getMessage());
			}
			
		}
		
		// 3. 임시파일 생성
		File tempFile = new File(uploadPath+savedName);
		
		// 4. 생성된 임시파일에 inputStream 복사해서 업로드하기
			// outputStream이란?: 바이트 데이터가 나가는 통로의 역할이 기술된 추상 클래스
		try (FileOutputStream outputStream = new FileOutputStream(tempFile)) {
			System.out.println("private outputStream Start...");
			
			int read;
			byte[] bytes = new byte[2048000];
				// 더 큰 용량의 파일을 올리려면 yml에서 설정 변경하기
			while ((read = inputStream.read(bytes)) != -1) {
					// -1: 파일이 끝날때까지 요청
				// Target File의 요청으로 넘어온 file의 inputStream 복사
				outputStream.write(bytes, 0, read);
			}
		} catch (IOException e) {
			System.out.println("private outputStream Exception->"+e.getMessage());
	
		} finally {
			System.out.println("private tempFile UpLoad The End->"+tempFile);
		}

		return savedName;
		// 여기까지 끝나면 다시 위로 올라가서 service에 넘기는 로직부터 시작
	}

	// 3-5. 확인버튼 눌렀을 때 이동되는 창
	@GetMapping(value = "/view_jw/csQnaSuccess")
	public String confirmQna() {
		System.out.println("JwController confirmQna Start...");
	
		return "view_jw/csQnaSuccess";
	}
	
	// 4-1. 공지사항 및 약관: 카테고리별 내용 가져오기
	@GetMapping(value = "/view_jw/csNotice")
	public String listNoticeQna(@RequestParam(value = "noticeCls", required = false)
								String noticeCls, Model model) {
		System.out.println("JwController listNoticeQna Start...");
		System.out.println("JwController listNoticeQna noticeCls->"+noticeCls);
		
		List<Notice_Table> listNotice = cs.listNotice();
		System.out.println("JwController listNoticeQna listNoticeQna.size->"+listNotice.size());
		System.out.println("JwController listNoticeQna listNotice->"+listNotice);
		
		model.addAttribute("listNotice", listNotice);
		System.out.println("model listNotice->"+listNotice);
		
		// 분류 선택
		model.addAttribute("selNoticeCls", noticeCls);
		System.out.println("model noticeCls->"+noticeCls);

		return "view_jw/csNotice";
	}
	
	// 4-2. 공지사항 및 약관: 제목 누르면 나오는 상세페이지
	@RequestMapping(value = "/view_jw/csNoticeSelect") 
	public String detailNotice(Notice_Table notice_table1, Model model) {
		System.out.println("JwController detailNotice Start...");
		System.out.println("JwController detailNotice notice_table1->"+notice_table1);
		
		Notice_Table notice_table = cs.detailNotice(notice_table1.getNotice_num());
		System.out.println("JwController detailNotice notice_table->"+notice_table);
		
		model.addAttribute("notice_table", notice_table);
		System.out.println("model notice_table->"+notice_table);
	
		return "view_jw/csNoticeSelect";
	}
	
	// 5-1. 고객후기 페이지 작업
	@RequestMapping(value = "/view_jw/csReview")
	public String listReview(ReviewListInfo ri, Model model) {
		System.out.println("JwController listReview Start...");
		
		// 1. 페이징 작업
		int totalReviewPage = cs.totalReviewPage();
		System.out.println("JwController listReview totalReviewPage->"+totalReviewPage);
		
		String currentPage = "1";
		System.out.println("JwController listReview currentPage->"+currentPage);
		// 여기서 Paging.class로 이동함 ==>>>>
		
		// ==>>>> Paging.class에서 작업한거 가져옴
		CsPaging page = new CsPaging(totalReviewPage, ri.getCurrentPage());
		System.out.println("JwController listReview page->"+page);
			
		ri.setStart(page.getStart()); //시작시 1
		System.out.println("JwController listReview ri setStart->"+ri);
		
		ri.setEnd(page.getEnd()); // 끝날시 
		System.out.println("JwController listReview ri setEnd->"+ri);
		
		// 2. 차량 정보, 리뷰, 결제정보, 이미지 뽑아오기
		List<ReviewListInfo> reviewListInfo = cs.listReview(ri);
		System.out.println("JwController listReview reviewListInfo.size()->"+reviewListInfo.size());
		
		model.addAttribute("totalReviewPage", totalReviewPage);
		System.out.println("model totalReviewPage->"+totalReviewPage);

		model.addAttribute("page", page);
		System.out.println("model page->"+page);
		
		model.addAttribute("reviewListInfo", reviewListInfo);	
		System.out.println("model reviewListInfo->"+reviewListInfo);
		
 
		return "view_jw/csReview";
	}
	
	// 5-2. 고객후기 팝업창
	@GetMapping(value = "/csReviewDetail")
	public String detailReview(ReviewListInfo reviewListInfo, Model model) {
		System.out.println("JwController detailReview Start...");
		System.out.println("JwController detailReview reviewListInfo ->" + reviewListInfo);
		
		Car_General_Info carDetail  = cs.getCarDetail(reviewListInfo.getSell_num());
		System.out.println("JwController carDetail Start");
		
		Car_Image carImage 			= cs.getCarImage(reviewListInfo.getSell_num());
		System.out.println("JwController carImage Start");
		
		Review reviewDetail			= cs.getReviewDetail(reviewListInfo.getApproval_num());
		System.out.println("JwController reviewDetail Start");
		
		Payment payment				= cs.getPayment(reviewListInfo.getUser_id());
		System.out.println("JwController payment Start");
		
		
		ReviewListInfo newReviewListInfo = new ReviewListInfo();
		
		// REVIEW 테이블
		newReviewListInfo.setApproval_num(reviewDetail.getApproval_num());
		newReviewListInfo.setReview_title(reviewDetail.getReview_title());
		newReviewListInfo.setReview_content(reviewDetail.getReview_content());
		newReviewListInfo.setReview_date(reviewDetail.getReview_date());
		newReviewListInfo.setEvaluation(reviewDetail.getEvaluation());
		newReviewListInfo.setFile_url(reviewDetail.getFile_url());
		newReviewListInfo.setFile_name1(reviewDetail.getFile_name1());
		newReviewListInfo.setFile_name2(reviewDetail.getFile_name2());
		newReviewListInfo.setFile_name3(reviewDetail.getFile_name3());
		
		// CAR_GENERAL_INFO
		newReviewListInfo.setSell_num(carDetail.getSell_num());
		newReviewListInfo.setCar_type(carDetail.getCar_type());
		newReviewListInfo.setFuel(carDetail.getFuel());
		newReviewListInfo.setBrand(carDetail.getBrand());
		newReviewListInfo.setModel(carDetail.getModel());
		newReviewListInfo.setMileage(carDetail.getMileage());

		// PAYMENT: 결제 정보 
		newReviewListInfo.setUser_id(payment.getUser_id());
		
		// CAR_IMAGE: 차량정보
		//newReviewListInfo.setImg_num(carImage.getImg_num());
		//newReviewListInfo.setImg_name(carImage.getImg_name());
		newReviewListInfo.setImg_url(carImage.getImg_url());
		
		
		model.addAttribute("newReviewListInfo", newReviewListInfo);
		
		return "view_jw/csReviewDetail";
		
	}
	
	
}
