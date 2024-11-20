package com.oracle.jmAuto.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import jakarta.servlet.ServletException;
//세션 연결 용, javax가 없어서 내가 임의로 jakarta로 변경
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import jakarta.servlet.http.HttpServletRequest;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Expert_Review;
import com.oracle.jmAuto.dto.SessionUtils;
import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.service.mh.MhService;
import com.oracle.jmAuto.service.sh.Paging;
import com.oracle.jmAuto.service.sh.PagingA;
import com.oracle.jmAuto.service.sh.ServiceSh;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
//@RequestMapping("/jmAuto")
public class ShController {
	// 서비스 추가
	private final ServiceSh serviceSh;
	
	//(메인화면) 키워드 검색 결과 리스트 리턴 메소드 (국산+해외+수입차 기준은 못 가름 (깜빡함..))
	@GetMapping(value = "/main_search")
	public String searchList(Car_General_Info cgi,Model model,
							@RequestParam("searchType") Integer searchType,
							@RequestParam("keyword") String keyword
							) {
		//String keyword = cgi.getSearchkeyword();
		System.out.println(keyword + " 여기까지 옴");
		

		// 페이징 작업
		String currentPage = "1";
		int total = serviceSh.searchListTotal(keyword, searchType);
		System.out.println("으아아아아아아악>> "+total);
		// 서비스 호출
		Paging page = new Paging(total, currentPage);
		cgi.setStart(page.getStart());
		cgi.setEnd(page.getEnd());
		int start = cgi.getStart();
		int end = cgi.getEnd();

		List<Car_General_Info> valueList = serviceSh.searchList(keyword, start, end,searchType);
		System.out.println("ShController searchList >> " + valueList);

		String url = "/view_sh/searchList";
		
		model.addAttribute("url", url);
		model.addAttribute("keyword", keyword);
		model.addAttribute("page", page);
		model.addAttribute("total", total);
		model.addAttribute("valueList", valueList);
		
		return "view_sh/searchList";
	}

	//상세 검색 결과 리턴 메소드 (모델명+예산범위+검색키워드)
	@GetMapping(value = "/view_sh/detailSearch")
	private String detailSearch(Car_General_Info cgi, Model model) {
		String keyword = cgi.getSearchkeyword();
		String model_name = cgi.getModel_name();
		int min_price = cgi.getMin_price();
		int max_price = cgi.getMax_price();

		// 페이징 작업
		String currentPage = "1";
		int total = serviceSh.detailSearchCartot(keyword, model_name, min_price, max_price);
		// 서비스 호출
		Paging page = new Paging(total, currentPage);
		cgi.setStart(page.getStart());
		cgi.setEnd(page.getEnd());
		int start = cgi.getStart();
		int end = cgi.getEnd();

		System.out.printf("키워드=%s, 모델검색=%s, 최소값=%d, 최대값=%d \n", keyword, model_name, min_price, max_price);
		List<Car_General_Info> valueList = serviceSh.detailSearch(keyword, model_name, min_price, max_price, start,
				end);
		System.out.println("ShController detailSearch valueList >> " + valueList);

		String url = "/view_sh/detailSearch";
		
		model.addAttribute("url", url);
		model.addAttribute("page", page);
		model.addAttribute("valueList", valueList);
		model.addAttribute("total", total);
		model.addAttribute("keyword", keyword);
		model.addAttribute("model_name", model_name);
		model.addAttribute("min_price", min_price);
		model.addAttribute("max_price", max_price);

		return "view_sh/searchList";
	}

	//국산차 리스트만 리턴하는 메소드
	@GetMapping(value = "/view_sh/kCar")
	public String kCar(Car_General_Info cgi, Model model) throws UnsupportedEncodingException {
		System.out.println("ShController kCar start...");
		int car_type = 1000;
		int total = serviceSh.cartot(car_type);
		String currentPage = "1";
		// 페이징 작업
		// 서비스 호출
		Paging page = new Paging(total, currentPage);
		cgi.setStart(page.getStart());
		cgi.setEnd(page.getEnd());
		int start = cgi.getStart();
		int end = cgi.getEnd();

		List<Car_General_Info> valueList = serviceSh.car_type_Car(start, end, car_type);
		
		String url = "/view_sh/kCar";

		model.addAttribute("url", url);
		model.addAttribute("page", page);
		model.addAttribute("total", total);
		model.addAttribute("valueList", valueList);
		return "view_sh/searchList";
	}

	//수입차 리스트만 리턴하는 메소드
	@GetMapping(value = "/view_sh/fCar")
	public String fCar(Car_General_Info cgi, Model model) {
		System.out.println("ShController fCar start...");
		int car_type = 2000;
		int total = serviceSh.cartot(car_type);
		String currentPage = "1";
		// 페이징 작업
		// 서비스 호출
		Paging page = new Paging(total, currentPage);
		cgi.setStart(page.getStart());
		cgi.setEnd(page.getEnd());
		int start = cgi.getStart();
		int end = cgi.getEnd();

		List<Car_General_Info> valueList = serviceSh.car_type_Car(start, end, car_type);
		String url = "/view_sh/fCar";
		
		model.addAttribute("url", url);
		model.addAttribute("page", page);
		model.addAttribute("total", total);
		model.addAttribute("valueList", valueList);
		return "view_sh/searchList";
	}

	//친환경차 리스트만 리턴하는 메소드
	@GetMapping(value = "/view_sh/ecoCar")
	public String ecoCar(Car_General_Info cgi, Model model) {
		System.out.println("ShController ecoCar start...");
		int car_type = 3000;
		int total = serviceSh.cartot(car_type);
		String currentPage = "1";
		// 페이징 작업
		// 서비스 호출
		Paging page = new Paging(total, currentPage);
		cgi.setStart(page.getStart());
		cgi.setEnd(page.getEnd());
		int start = cgi.getStart();
		int end = cgi.getEnd();
		String url = "/view_sh/ecoCar";
		
		List<Car_General_Info> valueList = serviceSh.car_type_Car(start, end, car_type);
	
		model.addAttribute("url", url);
		model.addAttribute("page", page);
		model.addAttribute("total", total);
		model.addAttribute("valueList", valueList);
		return "view_sh/searchList";
	}

	//모든 검색결과 페이지에서 페이지 이동을 하는 경우 검색 종류에 따라 페이지 정보에 맞는 리스트를 리턴하는 메소드
	@GetMapping("/view_sh/page")
	// @PathVariable = 경로 변수를 가져옴
	public String shPage(@RequestParam String url, 
						 @RequestParam int currentPage, 
						 @RequestParam int total,
						 @RequestParam(required = false) String keyword, 
						 @RequestParam(required = false) String model_name,
						 @RequestParam(required = false) Integer min_price, /* int에는 null이 들어갈 수 없어 Integer.. */
						 @RequestParam(required = false) Integer max_price, 
						 @RequestParam(required = false) Integer brand,
						 @RequestParam(required = false) String manu_date,
						 @RequestParam(required = false) String fuel,
						 HttpSession session, 
						 Car_General_Info cgi, 
						 Model model) {
		System.out.println("ShController shPage start...");
		System.out.println("URL: " + url);
		System.out.println("Current Page: " + currentPage);
		System.out.println("Keyword: " + keyword);

		Integer selectedBrand = (Integer) session.getAttribute("selectedBrand");

		// Paging작업
		Paging page = new Paging(cgi.getTotal(), cgi.getCurrentPage());
		// parameter emp >>page만 추가 세팅
		cgi.setStart(page.getStart()); // 시작시 1
		cgi.setEnd(page.getEnd()); // 시작시 10

		int start = cgi.getStart();
		int end = cgi.getEnd();
		List<Car_General_Info> valueList = null;

		switch (url) {
		case "/view_sh/kCar":
			int kCar_type = 1000;
			valueList = serviceSh.car_type_Car(start, end, kCar_type);
			break;
		case "/view_sh/fCar":
			int fCar_type = 2000;
			valueList = serviceSh.car_type_Car(start, end, fCar_type);
			break;
		case "/view_sh/ecoCar":
			int ecoCar_type = 3000;
			valueList = serviceSh.car_type_Car(start, end, ecoCar_type);
			break;
		case "/view_sh/searchList":
			valueList = serviceSh.searchList(keyword, start, end, null );
			model.addAttribute("keyword", keyword);
			break;
		case "/view_sh/detailSearch":
			valueList = serviceSh.detailSearch(keyword, model_name, min_price, max_price, start, end);
			model.addAttribute("keyword", keyword);
			model.addAttribute("model_name", model_name);
			model.addAttribute("min_price", min_price);
			model.addAttribute("max_price", max_price);
			break;
		case "brand":
			valueList = serviceSh.chkBrand(selectedBrand, start, end);
			model.addAttribute("brand", selectedBrand);
			break;
		case "/detailB":
			valueList = serviceSh.detailB(brand, manu_date, fuel, start, end);
			model.addAttribute("brand", brand);
			model.addAttribute("manu_date", manu_date);
			model.addAttribute("fuel", fuel);
			break;
		}
		
		model.addAttribute("url", url);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("total", cgi.getTotal());
		model.addAttribute("valueList", valueList);
		model.addAttribute("page", page);

		return "view_sh/searchList";
	}


	//검색결과 화면 좌측에 있는 상세검색 리스트 리턴하는 메소드 (브랜드명, 연식, 연료)
	@GetMapping("/detailB")
	public String detailB(Car_General_Info cgi, Model model, int brand, String manu_date, String fuel) {
		System.out.println("ShController detailB start...");

		System.out.println(brand + "/" + manu_date + "/" + fuel);
		// 페이징 작업
		String currentPage = "1";
		int total = serviceSh.detailBTotal(brand, manu_date, fuel);
		// 서비스 호출
		Paging page = new Paging(total, currentPage);
		cgi.setStart(page.getStart());
		cgi.setEnd(page.getEnd());
		int start = cgi.getStart();
		int end = cgi.getEnd();

		List<Car_General_Info> valueList = serviceSh.detailB(brand, manu_date, fuel, start, end);
		System.out.println("버튼 디테일로 값 가져옴 >> "+valueList);
		String url = "/detailB";
		
		model.addAttribute("url", url);
		model.addAttribute("page", page);
		model.addAttribute("valueList", valueList);
		model.addAttribute("total", total);
		model.addAttribute("brand", brand);
		model.addAttribute("manu_date", manu_date);
		model.addAttribute("fuel", fuel);
//		model.addAttribute("keyword", keyword);
//		model.addAttribute("model_name", model_name);
//		model.addAttribute("min_price", min_price);
//		model.addAttribute("max_price", max_price);

		return "view_sh/searchList";
	}
	
	
	// 차량등록 사이트 이동
	@GetMapping("/sellCarInfor")
	public String sellCarInfor() {
		return "view_sh/sellCarInfor";
	}
	

	//유저정보 가져와서 유저가 판매자인 경우에만 약관 확인 페이지로 이동
	@GetMapping(value = "/view_sh/sellMyCar")
	public String sellMyCar(HttpSession session) {

	    log.info("MainController sellMyCar() is started");
	    
	    System.out.println("session user >>>> " + session.getAttribute("user"));
	    
	    String returnUrl="view_sh/sellMyCar";

	    if(!(session.getAttribute("user") == null)) {
		    // 세션에서 user 객체 가져오기
		    Object sessionUser = session.getAttribute("user");
	
	        User_Table user = (User_Table) sessionUser;
	        String type = user.getUser_type();
       
        	// user_type 값 확인 판매자, 관리자만 접근 가능
            System.out.println("User type: " + type);
            if (!"S".equals(type)&&!"A".equals(type)) {
            	returnUrl = "view_sh/sellMyCarNotSeller";
            }
        }
        else {
        	returnUrl="view_jm/login";
        }
	    
	    return returnUrl;
        
	}

	//차량 등록 화면 (판매자인 경우만 사용)
	@PostMapping("/view_sh/sellMyCarInfo")
	public String sellMyCarInfo(HttpServletRequest request, 
								Model model,
								HttpSession session
								) throws IOException, ServletException {
		System.out.println("ShController sellMyCarInfo start...");

		// 세션에서 판매자 id가져오기
	    Object sessionUser = session.getAttribute("user");
	    User_Table user = (User_Table) sessionUser;
        String userId = user.getUser_id();
        
		// form에서 enctype="multipart/form-data"를 하는 경우 dto사용 못함;;
		String car_type = request.getParameter("car_type"); // 차종
		String brand = request.getParameter("brand"); // 제조사
		String model_name = request.getParameter("model_name"); // 모델명
		String car_num = request.getParameter("car_num"); // 차번호
		String manu_yy = request.getParameter("manu_yy"); // 제조년
		String manu_mm = request.getParameter("manu_mm"); // 제조월
		String mileage = request.getParameter("mileage"); // 주행거리
		String color = request.getParameter("color"); // 색깔
		String fuel = request.getParameter("fuel"); // 연료
		String transmission = request.getParameter("transmission"); // 변속기
		String accident = request.getParameter("accident"); // 사고유무
		String repossession = request.getParameter("repossession"); // 압류유무
		String price = request.getParameter("price"); // 가격
		
		//혹시 모를 차 번호 사이 공백 제거
  		String delSpaceCarNum = car_num.replaceAll("\\s+","");
		
		//manu_date 조합 >> 사용자가 0n0n입력시 앞에 0을 붙여주기 위해 파싱함
		String manu_date = String.format("%02d%02d", Integer.parseInt(manu_yy), Integer.parseInt(manu_mm));

		// Servlet 상속 받지 못했을 떄 realPath 불러 오는 방법 (이건 webapp에 들어가는거라 넘김)
		//String uploadPath = request.getSession().getServletContext().getRealPath("/carImages/"+car_num);
		
		//static 폴더 밑에 저장하려면 paths.get을 사용해야 함
		//String uploadPath = Paths.get("src/main/resources/static/carImages/" + car_num).toAbsolutePath().toString();
		String uploadPath = Paths.get("src/main/webapp/carImages/" + car_num).toAbsolutePath().toString();
		
		System.out.println("뭐야 왜 안나오는데 >> " + uploadPath);

		
		Map<String, Object> infor = new HashMap<>();
		
		int count = 0;
		// 메인이미지 저장****************************************************
		count = 1;
		Part viewUploadFile = request.getPart("img_url_main");
		String savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		String url = cutImgUrl(uploadPath+"\\" + savedName);
		System.out.println("url이 안나와아아아아아아아아 >> "+url);
		infor.put("savedMainName", savedName);
		infor.put("mainUrl", url);
		// img_url_1 저장****************************************************
		count = 2;
		viewUploadFile = request.getPart("img_url_1");
		savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		url = cutImgUrl(uploadPath+"\\" + savedName);
		infor.put("savedImg1Name", savedName);
		infor.put("Img1Url", url);
		// img_url_2 저장****************************************************
		count = 3;
		viewUploadFile = request.getPart("img_url_2");
		savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		url = cutImgUrl(uploadPath+"\\" + savedName);
		infor.put("savedImg2Name", savedName);
		infor.put("Img2Url", url);
		// img_url_3 저장****************************************************
		count = 4;
		viewUploadFile = request.getPart("img_url_3");
		savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		url = cutImgUrl(uploadPath+"\\" + savedName);
		infor.put("savedImg3Name", savedName);
		infor.put("Img3Url", url);
		// img_url_4 저장****************************************************
		count = 5;
		viewUploadFile = request.getPart("img_url_4");
		savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		url = cutImgUrl(uploadPath+"\\" + savedName);
		infor.put("savedImg4Name", savedName);
		infor.put("Img4Url", url);

		// sell_regi 자동차 등록증 저장****************************************************
		count = 6;
		viewUploadFile = request.getPart("sell_regi");
		savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		url = cutImgUrl(uploadPath+"\\" + savedName);
		infor.put("savedSell_regiName", savedName);
		infor.put("sell_regiUrl", url);
		// sell_certi_tax 완납증명서 저장****************************************************
		count = 7;
		viewUploadFile = request.getPart("sell_certi_tax");
		savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		url = cutImgUrl(uploadPath+"\\" + savedName);
		infor.put("savedSell_certi_taxName", savedName);
		infor.put("sell_certi_taxUrl", url);
		// sell_shinbun 신분증 사본 저장****************************************************
		count = 8;
		viewUploadFile = request.getPart("sell_shinbun");
		savedName = fileInfor(viewUploadFile, car_num, count, uploadPath);
		url = cutImgUrl(uploadPath+"\\" + savedName);
		infor.put("savedSell_shinbunName", savedName);
		infor.put("sell_shinbunUrl", url);
		
		//url = uploadPath + "\\" + savedName;

		infor.put("brand", brand);
		infor.put("car_type", car_type);
		infor.put("model", model_name);
		infor.put("car_num", car_num);
		infor.put("manu_date", manu_date);
		infor.put("mileage", mileage);
		infor.put("color", color);
		infor.put("fuel", fuel);
		infor.put("transmission", transmission);
		infor.put("accident", accident);
		infor.put("repossession", repossession);
		infor.put("price", price);
		infor.put("user_id", userId);

		System.out.println("Controller sellMyCarInfo infor->"+infor);
		
		String rtnString = "view_sh/sellUploadSuccess";
		
		
		int result = serviceSh.InputCar(infor);
		if(result==0) {
			System.out.println("InputCar 업데이트 안됨");
			rtnString = "view_sh/sellCarFail";
		}
		
		System.out.println("컨트롤러: InputCar 차량등록 완료  ^///^V");
		
		return rtnString;
	}

	// 파일 정보 가져와서 세팅하는 메소드
	private String fileInfor(Part viewUploadFile, String car_num, int count, String uploadPath) throws IOException {
		InputStream inputStream = viewUploadFile.getInputStream();
		// 파일 확장자 구하기
		String fileName = viewUploadFile.getSubmittedFileName();
		/* 파일 이름, 확장자 가져오는 메소드 호출 */
		String originalName = getFileName(fileName, 1);
		String suffix = getFileName(fileName, 2);
		/* 파일 정보 가져와서 업로드 */
		String savedName = uploadFile(originalName, inputStream, car_num, count, uploadPath, suffix);
		return savedName;
	}

	
	/* 파일 이름, 확장자 가져오는 메소드 */
	private String getFileName(String fileName, int gubun) {
		String rtnImgName = "";
		String[] split = fileName.split("\\.");
		String originalName = split[split.length - 2];
		String suffix = split[split.length - 1];

		// gubun == 1 -> File 명, 2면 확장자명
		if (gubun == 1) {
			rtnImgName = originalName;
			System.out.println("originalName->" + originalName);
		} else if (gubun == 2) {
			rtnImgName = suffix;
			System.out.println("suffix->" + suffix);
		}

		System.out.println("getfileName rtnName->" + rtnImgName);

		return rtnImgName;
	}

	
	// 저장할 파일 경로 설정 및 파일 저장 메소드
	private String uploadFile(String originalName, InputStream inputStream, String car_num, int count,
			String uploadPath, String suffix) {

		System.out.println("uploadPath->" + uploadPath);

		/* 파일을 저장할 폴더가 없는 경우 새로 생성 */
		/* String path = "C:\\car_img_save_test\\" + car_num; */
		/* File 메소드 선언 */
		File dir = new File(uploadPath);
		if (!dir.exists()) {
			try {
				// 폴더 생성
				dir.mkdir();
				System.out.println(uploadPath + " 폴더 생성");
			} catch (Exception e) {
				System.out.println("mkDir exception >> " + e);
			}
		}
		
		// 저장할 파일 이름 설정
		String savedName = "";
		if(count==6) {
			savedName = car_num + "_" + "자동차등록증" + "." + suffix;
		}
		else if(count==7) {
			savedName = car_num + "_" + "세금완납증명서" + "." + suffix;
		}
		else if(count==8) {
			savedName = car_num + "_" + "신분증사본" + "." + suffix;
		}
		else {
			savedName = car_num + "_" + count + "." + suffix;
		}
		
		log.info("savedName: " + savedName);

		// 임시파일 생성
		File tempFile = new File(uploadPath + "\\" + savedName);

		// 이미지 업로드
		try (FileOutputStream outputStream = new FileOutputStream(tempFile)) {
			int read;
			// 2K*K
			byte[] bytes = new byte[2048000];
			while ((read = inputStream.read(bytes)) != -1) {
				// 이미지 저장
				outputStream.write(bytes, 0, read);
			}
		} catch (IOException e) {
			System.out.println("이미지 업로드 실패 >> " + e);
			e.printStackTrace();
		} finally {
			System.out.println("UpLoad The End");
		}

		return savedName;
	}
	
	
	//이미지 url을 원하는대로 잘라서 세팅해주는 메소드
	public String cutImgUrl(String ImgUrl) {
	    String resultPath = "";

	    // 경로에서 모든 백슬래시를 슬래시로 변환
	    String normalizedPath = ImgUrl.replace("\\", "/");

	    // "/upload"의 위치 찾기
	    String keyword = "/carImages";
	    int index = normalizedPath.indexOf(keyword);

	    // "/upload" 이후부터 문자열을 자름
	    if (index != -1) { // "/upload"가 경로에 있는지 확인
	        resultPath = normalizedPath.substring(index);
	        //System.out.println("잘린 문자열 >> " + resultPath); // "/webapp/WEB-INF/carImages/44444444/44444444_1.jpg"
	    } else {
	        System.out.println("Keyword '/carImages' not found in the path.");
	    }

	    return resultPath;
	}
	
	
	//차량 등록할 때 ajax에서 호출하는 차량번호 중복 확인 메소드
	@ResponseBody
	@PostMapping("/carNumChk")
	public Integer carNumChk(String car_num) {
		System.out.println("ShController carNumChk start... >> "+car_num);
		//혹시 모를 차 번호 사이 공백 제거
		String delSpaceCarNum = car_num.replaceAll("\\s+","");
		Integer result = serviceSh.carNumChk(delSpaceCarNum);
		
		System.out.println("ShController carNumChk result >> "+result);
		
		return result;
	}
	
	
	//**저장되어 있는 이미지 경로 한 번에 불러와서 url 편집 후 DB에 넣을 용도로 작성한 메소드(DB에 이미지 테이블 정보 집어넣기 용)*****
	@GetMapping("/getCarNum")
	public void DBImgUrl(){
		
		List<Car_General_Info> car_num = serviceSh.getCarNum();
		for(int i = 0; i < car_num.size(); i++) {
			Car_General_Info carInfo = car_num.get(i);
			
			//폴더별로 저장되어 있는 경로에 있는 파일을 가져오기 위해 경로 설정
			//String path = "C:\\Users\\admin\\Downloads\\jmAuto\\jmAuto\\src\\main\\webapp\\upload\\"+carInfo.getCar_num();
			String path = Paths.get("src/main/webapp/carImages/" + carInfo.getCar_num()).toAbsolutePath().toString();
			//System.out.println("path >> "+path);
			
			File directory = new File(path);
			File[] files = directory.listFiles();
			
			List<String> filePath = new ArrayList<>();
			
			Map<String, Object> insertMap = new HashMap<>();
			
			//이미지 경로
			if(files != null) {
				// files안에 있는 파일수만큼 for문을 돌려 file에 저장
				for(File file : files) {
					// file 안에 있는 것이 파일이라면
					if(file.isFile()) {
						//System.out.println(file.getAbsolutePath());
						
						//가져온 파일 이미지의 경로에서 /carImages 앞쪽을 다 자르는 동작
						String ImgUrl = cutImgUrl(file.getAbsolutePath());
						
						//System.out.println("url입니다 >> "+ImgUrl);
						//매물번호 가져옴
						long sell_num = carInfo.getSell_num();
						
						//System.out.println("매물번호입니다 >> "+sell_num);
						
						//파일 이름 가져옴
						String fileName = file.getName();
						//System.out.println("파일이름입니다 >> "+fileName);
						
						insertMap.put("url", ImgUrl);
						insertMap.put("sell_num", sell_num);
						insertMap.put("fileName", fileName);
						
						System.out.println(insertMap);
						
						int reslt = serviceSh.insertImgUrl(insertMap);
						
					}
				}
			}
			else {
				System.out.println();
			}
			
			//매물번호 한 번에 출력
//			if(files != null) {
//				for(File file : files) {
//					if(file.isFile()) {
//						System.out.println(carInfo.getSell_num());
//					}
//				}
//			}
//			else {
//				System.out.println();
//			}
			
		}
	}
	
	//*************************************************************************
	
	//유저정보 가져와서 유저가 판매자인 경우에만 약관 확인 페이지로 이동
//		@GetMapping(value = "/view_sh/sellMyCar")
//		public String sellMyCar(HttpSession session) {
//
//		    log.info("MainController sellMyCar() is started");
//		    
//		    System.out.println("session user >>>> " + session.getAttribute("user"));
//
//		    if(!(session.getAttribute("user") == null)) {
//			    // 세션에서 user 객체 가져오기
//			    Object sessionUser = session.getAttribute("user");
//		
//		        User_Table user = (User_Table) sessionUser;
//		        String type = user.getUser_type();
//	       
//	        	// user_type 값 확인
//	            System.out.println("User type: " + type);
//	            if ("S".equals(type)) {
//	                return "view_sh/sellMyCar";
//	            } else {
//	                return "view_sh/sellMyCarNotSeller";
//	            }
//	        }
//	        else {
//	        	return "view_jm/login";
//	        }
//	        
//		}
	
	
	// 관리자 차량 재고 관리
	@GetMapping("view_sh/manager_car")
	public String manager_carAll(Car_General_Info cgi, Model model, 
	                      @RequestParam(defaultValue = "1") String currentPage) {
	    
	    int total = serviceSh.carTotal();
	    
	    // 관리자용 페이징 서비스 (10개씩 가져오기 위함)
	    PagingA page = new PagingA(total, currentPage);
	    
	    // 페이징에 따라 조회 범위 설정
	    cgi.setStart(page.getStart());
	    cgi.setEnd(page.getEnd());
	    
	    // 차량 정보 조회
	    List<Car_General_Info> allCar = serviceSh.allCar(cgi.getStart(), cgi.getEnd());
	    
	    // 모델에 데이터 추가
	    model.addAttribute("total", total);
	    model.addAttribute("allCar", allCar);
	    model.addAttribute("page", page);
	    
	    return "view_sh/manager_car";
	}
	
	//검색어
    @GetMapping(value = "/getListSearch")
    public String getBoardListSearch(Car_General_Info cgi,
    								 Model model,
									 @RequestParam(defaultValue = "1") String currentPage,
									 @RequestParam(value = "keyword", required = false) 
										String keyword) throws JsonProcessingException {
        System.out.println("글 목록 검색 처리");
        System.out.println("searchKeyword >> " + keyword);
        
        List<Car_General_Info> allCar = null;
	    PagingA page = null;
	    int total = 0;
	    //검색키워드가 null이거나 비어져 있는 경우
	    if (keyword == null || keyword.trim().isEmpty()) {
	    	cgi.setTotal(serviceSh.carTotal());
	    	total = cgi.getTotal();
	    	// 관리자용 페이징 서비스 (10개씩 가져오기 위함)
	    	page = new PagingA(total, currentPage);
	    	// 페이징에 따라 조회 범위 설정
		    cgi.setStart(page.getStart());
		    cgi.setEnd(page.getEnd());
		    int start= cgi.getStart();
		    int end = cgi.getEnd();
		    allCar = serviceSh.allCar(start, end);
        } else {
        	cgi.setTotal(serviceSh.AsearchTot(keyword));
        	total = cgi.getTotal();
	    	// 관리자용 페이징 서비스 (10개씩 가져오기 위함)
	    	page = new PagingA(total, currentPage);
	    	// 페이징에 따라 조회 범위 설정
		    cgi.setStart(page.getStart());
		    cgi.setEnd(page.getEnd());
		    int start= cgi.getStart();
		    int end = cgi.getEnd();
		    allCar = serviceSh.Asearch(keyword, start, end);
        } 
        
        System.out.println("allCar >> " + allCar);
        
        // 모델에 데이터 추가
        model.addAttribute("keyword", keyword);
	    model.addAttribute("total", total);
	    model.addAttribute("allCar", allCar);
	    model.addAttribute("page", page);
	    
	    return "view_sh/manager_car";
    }
	
    
    // NOTE : 판매차량 비활성화
    @GetMapping("/carDeactive")
    @ResponseBody
    public int userDeactive(@RequestParam("sellNum") String sellNum){
    System.out.println("ShController.userDel() start...");
    System.out.println("ShController.userDel() sellNum ....>>"+ sellNum);

    int result = serviceSh.carDeactive(sellNum);

    return result;
    }
    
    // NOTE : 판매차량 활성화
    @GetMapping("/carActive")
    @ResponseBody
    public int userActive(@RequestParam("sellNum") String sellNum){
    System.out.println("ShController.userDel() start...");
    System.out.println("ShController.userDel() sellNum ....>>"+ sellNum);

    int result = serviceSh.carActive(sellNum);

    return result;
    }
    
    //전문가 리뷰 리스트
    @GetMapping("/view_sh/manager_review")
    public String manager_reviewList(Expert_Review er, Model model, 
    						  @RequestParam(defaultValue = "1") String currentPage) {
	    
	    int total = serviceSh.reviewTotal();
	    
	    // 관리자용 페이징 서비스 (10개씩 가져오기 위함)
	    PagingA page = new PagingA(total, currentPage);
	    
	    // 페이징에 따라 조회 범위 설정
	    er.setStart(page.getStart());
	    er.setEnd(page.getEnd());
	    
	    //저문가리뷰 정보 조회
	    List<Expert_Review> allReview = serviceSh.allReview(er.getStart(), er.getEnd());
	    
	    
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    List<String> formattedDates = new ArrayList<>();

	    for (Expert_Review review : allReview) {
	        String formattedDate = sdf.format(review.getWrite_date()); // 날짜 포맷
	        formattedDates.add(formattedDate); // 리스트에 추가
	    }
	    
	    // 모델에 데이터 추가
	    model.addAttribute("formattedDates", formattedDates);
	    model.addAttribute("total", total);
	    model.addAttribute("reviewlist", allReview);
	    model.addAttribute("page", page);
	    
	    return "view_sh/manager_review";
	}
    
    // 전문가리뷰 검색어
    @GetMapping(value = "/getReviewListSearch")
    public String getReviewListSearch(Model model,
    								  Expert_Review er,
									  @RequestParam(defaultValue = "1") String currentPage,
									  @RequestParam(value = "keyword", required = false) 
										 String keyword) throws JsonProcessingException {
        System.out.println("searchKeyword >> " + keyword);
        
        List<Expert_Review> reviewlist = null;
	    PagingA page = null;
	    int total = 0;
	    
	    //검색키워드가 null이거나 비어져 있는 경우
	    if (keyword == null || keyword.trim().isEmpty()) {
	    	er.setTotal(serviceSh.reviewTotal());
	    	total = er.getTotal();
	    	// 관리자용 페이징 서비스 (10개씩 가져오기 위함)
	    	page = new PagingA(total, currentPage);
	    	// 페이징에 따라 조회 범위 설정
		    er.setStart(page.getStart());
		    er.setEnd(page.getEnd());
		    int start= er.getStart();
		    int end = er.getEnd();
		    reviewlist = serviceSh.allReview(start, end);
        } else {
        	er.setTotal(serviceSh.keywordReviewTotal(keyword));
        	total = er.getTotal();
	    	// 관리자용 페이징 서비스 (10개씩 가져오기 위함)
	    	page = new PagingA(total, currentPage);
	    	// 페이징에 따라 조회 범위 설정
		    er.setStart(page.getStart());
		    er.setEnd(page.getEnd());
		    int start= er.getStart();
		    int end = er.getEnd();
		    reviewlist = serviceSh.reviewSearch(keyword, start, end);
        }
	    
        
        System.out.println("reviewList >> " + reviewlist);
        System.out.println("keyword >> "+keyword );
        System.out.println("total >> "+total );
        System.out.println("reviewlist >> "+reviewlist );
        System.out.println("page >> "+page );
        
        // 모델에 데이터 추가
        model.addAttribute("keyword", keyword);
	    model.addAttribute("total", total);
	    model.addAttribute("reviewlist", reviewlist);
	    model.addAttribute("page", page);
        
        return "view_sh/manager_review";
    }
    
    
    // NOTE : 판매 전문가리뷰 비활성화
    @GetMapping("/reviewDeactive")
    @ResponseBody
    public int reviewDeactive(@RequestParam("reviewNum") String reviewNum){
    System.out.println("ShController.reviewDeactive() start...");
    System.out.println("ShController.reviewDeactive() reviewNum ....>>"+ reviewNum);

    int result = serviceSh.reviewDeactive(reviewNum);

    return result;
    }
    
    // NOTE : 비활성화 전문가리뷰 활성화
    @GetMapping("/reviewActive")
    @ResponseBody
    public int reviewActive(@RequestParam("reviewNum") String reviewNum){
    System.out.println("ShController.reviewActive() start...");
    System.out.println("ShController.reviewActive() reviewNum ....>>"+ reviewNum);

    int result = serviceSh.reviewActive(reviewNum);

    return result;
    }
    
	
	
	

}
