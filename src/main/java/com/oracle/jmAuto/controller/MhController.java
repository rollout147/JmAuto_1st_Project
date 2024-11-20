package com.oracle.jmAuto.controller;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oracle.jmAuto.dao.mh.Car_General_InfoDao;
import com.oracle.jmAuto.dao.mh.Expert_ReviewDao;
import com.oracle.jmAuto.dao.mh.FaqDao;
import com.oracle.jmAuto.dao.mh.Notice_TableDao;
import com.oracle.jmAuto.dao.mh.ReviewPaymentCarInfoDao;
import com.oracle.jmAuto.dao.mh.User_TableDao;
import com.oracle.jmAuto.dto.Car_Image;
import com.oracle.jmAuto.dto.Faq;
import com.oracle.jmAuto.dto.Notice_Table;
import com.oracle.jmAuto.dto.Qna;
import com.oracle.jmAuto.dto.ReviewListInfo;
import com.oracle.jmAuto.dto.User_Table;
import com.oracle.jmAuto.dto.Zzim;
import com.oracle.jmAuto.service.jw.CsService;
import com.oracle.jmAuto.service.mh.MhService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class MhController {
	private final MhService ms;
	private final CsService cs;
	
	@GetMapping(value = "/")
	public String listReviewcount(Model model){
		System.out.println("MhController listReviewcount start...");
		
		//전문가 리뷰 갯수
		int expert = ms.ReviewListCount();
		System.out.println("MhController listReview count =>>  " + expert);
		// 전문가 리뷰 리스트
		List<Expert_ReviewDao> exp_list = ms.expList();
		List<Expert_ReviewDao> list_Exp = exp_list.subList(0, Math.min(3, exp_list.size()));
		
		//그냥 리뷰
		List<Expert_ReviewDao> liview = ms.ListReview();
		System.out.println("MhController listReview liview.size() => "+ liview.size());
		
		//차량기본정보
		List<Car_General_InfoDao> carInfo = ms.CarList();
		System.out.println("MhController listReview carInfo.size() => " + carInfo.size());
		
		List<Car_General_InfoDao> carInfo2 = ms.CarList();
		Collections.shuffle(carInfo);  // 리스트를 무작위로 섞음
	    List<Car_General_InfoDao> randomCarInfo = carInfo.subList(0, Math.min(3, carInfo.size()));
	    List<Car_General_InfoDao> randomCarInfo2 = carInfo2.subList(0, Math.min(6, carInfo.size()));
		System.out.println("MhController listReview randomCarInfo.size() => " + randomCarInfo.size());

		// 리뷰 리스트 & 결제정보 & 차량정보
		List<ReviewPaymentCarInfoDao> review = ms.reviewInfoList();
		List<ReviewPaymentCarInfoDao> review3 = review.subList(0, Math.min(3, review.size()));
		System.out.println("MhController listReview review.size() => " + review.size());
		
		// 공지사항 및 약관
		List<Notice_TableDao> notList = ms.noticeList();
		List<Notice_TableDao> listNot = notList.subList(0, Math.min(5, notList.size()));
		
		model.addAttribute("listNot", listNot);
		model.addAttribute("review", review3);
		model.addAttribute("randomCarInfo", randomCarInfo);
		model.addAttribute("randomCarInfo2", randomCarInfo2);
		model.addAttribute("liview", liview);
		model.addAttribute("expert", list_Exp);
		return "main";
	}

	@RequestMapping(value = "/ajax/autocomplete.do")
	public @ResponseBody Map<String, Object> autocomplete (@RequestParam Map<String, Object> paramMap) throws Exception{
		List<Map<String, Object>> resultList = ms.autocomplete(paramMap);
		System.out.println("MhController autocomplete start...");
		System.out.println("MhController autocomplete resultList => " + resultList);
		
		Map<String, Object> responeseMap = new HashMap<>();
		responeseMap.put("resultList", resultList);
		
		return responeseMap;
	}
	
//	@RequestMapping(value = "/main_search")
//	public String carSearch(@RequestParam("keyword") String keyword, @RequestParam("searchType") Integer searchType ,Model model) {
//		List<Car_General_InfoDao> searchCarInfo = ms.SearchCarList(keyword, searchType);
//		System.out.println("MhController carSearch start...");
//		System.out.println("MhController carSearch searchCarInfo => " + searchCarInfo);
//		System.out.println("MhController carSearch searchType => " + searchType);
//		model.addAttribute("searchCarInfo", searchCarInfo);
//		
//		return "view_sh/SearchList";
//		
//	}
	
	@GetMapping(value = "/carInfo")
	public String carInfo(@RequestParam("sellNum") String sellNum,@RequestParam("id") String id, Model model, HttpSession session) {
		System.out.println("MhController carInfo start...");
		
		User_Table user = (User_Table)session.getAttribute("user");
		
		System.out.println("user --->>>>>" + user);
		System.out.println("session =>> " + session.getAttribute("user"));
		
		List<Car_General_InfoDao> carInfoList = ms.CarInfoList(sellNum);
		System.out.println("MhController carInfo  ");
		
		List<User_TableDao> userTableInfo = ms.userInfo(id);
		System.err.println("MhController carInfo userTableInfo => " + userTableInfo);
		
		List<FaqDao> faqList = ms.faqList();
		List<FaqDao> faqListSel = faqList.subList(0, Math.min(5, faqList.size()));
		
		List<Expert_ReviewDao> selexpList = ms.selExpList(sellNum);
		
		List<Car_Image> car_img = ms.selListImg(sellNum);
		System.out.println("car_img >>>>>>>>>>>>> " + car_img);
		
		
		model.addAttribute("faqListSel",faqListSel);
		model.addAttribute("ExpList", selexpList);
		model.addAttribute("userInfo", userTableInfo);
		model.addAttribute("carInfoList",carInfoList);
		model.addAttribute("car_img",car_img);
		
		return "view_mh/carInfo";
	}

	@RequestMapping(value = "/mhwishlist/add", method = RequestMethod.POST)
	public ResponseEntity<String> addTozzimList(@RequestBody Map<String, Object> reqMap){
		System.out.println("MhController addTozzimList start...");
		
		try {
			long sellNum = (long) reqMap.get("sellNum");
			String userid = (String) reqMap.get("userId");
			
			Zzim zzim = new Zzim();
			zzim.setSell_num(sellNum);
			zzim.setUser_id(userid);
			
			System.out.println("MhController addTozzimList zzim=> " +zzim);
			
			ms.zzimInsert(zzim);

			return ResponseEntity.ok("찜등록~");
		} catch (Exception e) {
			return ResponseEntity.status(500).body("찜등록 중 에러발생");
		}
		
	}
	
	@GetMapping("/manager/CS/faq")
	public String managerCSpage(Model model) {
		System.out.println("MhController managerCSpage start...");
		
		List<FaqDao> faqList = ms.faqList();
		
		model.addAttribute("faq", faqList);
		
		return "view_mh/manager_faq";
	}
	
	@GetMapping(value = "/manager/CS/gogi")
	public String managerCSgogi(Model model) {
		System.out.println("MhController managerCSgogi start...");
		List<Notice_TableDao> notList = ms.notListstate();
		
		model.addAttribute("notList", notList);
		return "view_mh/manager_gogi";
	}
	
	@GetMapping(value = "/mh/faqsel")
	public String selFaqList(@RequestParam("faqNum") Integer faqNum, Model model) {
		System.out.println("MhController managerCSpage start...");
		List<Faq> faqList = ms.selFaqList(faqNum);
		System.out.println("faqList =>>" + faqList);
		
		model.addAttribute("faq", faqList);
		return "view_mh/manager_faq_sel";
	}

	@PostMapping(value = "/mh/faqupdate")
	public String updFaqList(@ModelAttribute Faq faqlist, RedirectAttributes ra) {
		System.out.println("MhController updFaqList start...");
		System.out.println("faqlist >>>>>>>>>>>>" + faqlist);
		int updfaq = ms.updateFaq(faqlist);
		
		if(updfaq > 0) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다!");
		} else {
			ra.addFlashAttribute("message", "수정이 실패했습니다.");
			return "redirect:/manager/CS/faq";
		}
		return "redirect:/manager/CS/faq";
	}
	
	@GetMapping(value = "/mh/faqInsert")
	public String faqInsertPage(@RequestParam(value = "id", required = false) String id, HttpSession session) {
		System.out.println("MhController faqInsertPage start...");
		
		User_Table user = (User_Table)session.getAttribute("user");
		System.out.println("user >>>>>>>>>" + user);
		
		
		return "view_mh/manager_faq_insert";
	}
	
	@PostMapping(value = "/mh/faqinsertFrom")
	public String insertFaq(@ModelAttribute Faq faqInsList, RedirectAttributes ra) {
		System.out.println("MhController insertFaq start...");
		System.out.println("faqInsList >>>>" + faqInsList);
		int insertFaqList = ms.insertFaq(faqInsList);
		
		if(insertFaqList > 0) {
			ra.addFlashAttribute("message", "새로작성이 완료되었습니다.");
		} else {
			ra.addFlashAttribute("message", "작성이 실패하였습니다.");
			return "redirect:/manager/CS/faq";
		}
		
		return "redirect:/manager/CS/faq";
	}
	
	@PostMapping(value = "/mh/faqDelete")
	public String deleteFaq(@RequestBody Map<String, String> reqMap, RedirectAttributes ra) {
		System.out.println("MhController deleteFaq start...");
		String faqNum = reqMap.get("faqNum");
		System.out.println("faqNum >>>>>" + faqNum);
		int isDeleteFaq = ms.delectFaq(faqNum);	
		
		if (isDeleteFaq > 0) {
			ra.addFlashAttribute("message", "삭제되었습니다");
			return "redirect:/manager/CS/faq";
		} else {
			ra.addFlashAttribute("message", "삭제실패");
			return "redirect:/manager/CS/faq";
		}
	}
	
	@PostMapping(value = "/mh/faqExpos")
	public String exposFaq(@RequestBody Map<String, String> reqMap, RedirectAttributes ra) {
		System.out.println("MhController deleteFaq start...");
		String faqNum = reqMap.get("faqNum");
		System.out.println("faqNum >>>>>" + faqNum);
		int isDeleteFaq = ms.exposFaq(faqNum);	
		
		if (isDeleteFaq > 0) {
			ra.addFlashAttribute("message", "노출되었습니다");
			return "redirect:/manager/CS/faq";
		} else {
			ra.addFlashAttribute("message", "노출실패");
			return "redirect:/manager/CS/faq";
		}
	}
	
	@RequestMapping(value = "/mh/man_inquiry")
	public String inquiryList(@RequestParam(defaultValue = "1") int pageNum,
							  @RequestParam(required = false) String keyword,
							  @RequestParam(required = false) Integer answerStatus,
							  Model model) {
		System.out.println("MhController inquiryList start...");
		
		int pageSize = 10;
		int totalQnaCount;
		List<Qna> qnaList;
		
		int startIndex = (pageNum - 1) * pageSize;
		int endIndex = pageNum * pageSize;
		System.out.println("answerStatus >>>>>" + answerStatus);
		if (keyword == null || keyword.trim().isEmpty()) {
			if (answerStatus == null) {
				totalQnaCount = ms.qnaTotalCountS();
				qnaList = ms.qnaListPage(startIndex, endIndex, keyword);
			} else {
				totalQnaCount = ms.qnaTotalCountA(answerStatus);
				System.out.println("totalQnaCount >>>> " + totalQnaCount);
				qnaList = ms.qnaListPageA(startIndex, endIndex, answerStatus);
				System.out.println("qnaList >>>>" + qnaList);
			}
		} else {
			totalQnaCount = ms.qnaTotalCount(keyword);
			qnaList = ms.qnaListPage(startIndex, endIndex, keyword);
		}
		
		
		int totalPageCount = (int) Math.ceil((double)totalQnaCount / pageSize);
		
		model.addAttribute("qnaList", qnaList);
		model.addAttribute("currentPage", pageNum);
		model.addAttribute("totalPages", totalPageCount);
		model.addAttribute("keyword", keyword);
		model.addAttribute("answerStatus", answerStatus);
		
		return "view_mh/manager_inquiry";
	}
	
	@RequestMapping(value = "/mh/submitAnswer" , method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> submitAnswer(@RequestParam("qnaNum") int qnaNum, @RequestParam("answer") String answer) {
		System.out.println("MhController submitAnswer start...");
		
		int subAns = ms.answerSubmit(qnaNum, answer);
		
		Map<String, Object> response = new HashMap<>();
		
		if(subAns > 0) {
			int qnaUseYn = ms.getQnaUseYn(qnaNum);
			response.put("qna_useyn", qnaUseYn);
			response.put("message", "답변이 완료되었습니다.");
			return ResponseEntity.ok(response);
		} else {
			response.put("message", "답변이 정상적으로 등록되지 않았습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
		}
	}
	
	@PostMapping(value = "/mh/gogiDelete")
	public String deleteGogi(@RequestBody Map<String, String> reqMap, RedirectAttributes ra) {
		System.out.println("MhController deleteFaq start...");
		String noticeNum = reqMap.get("noticeNum");
		System.out.println("noticeNum >>>>>" + noticeNum);
		int isDeleteFaq = ms.delGogiTable(noticeNum);	
		
		if (isDeleteFaq > 0) {
			ra.addFlashAttribute("message", "삭제되었습니다");
			return "redirect:/manager/CS/gogi";
		} else {
			ra.addFlashAttribute("message", "삭제실패");
			return "redirect:/manager/CS/gogi";
		}
	}
	
	@PostMapping(value = "/mh/gogiExpos")
	public String exposGogi(@RequestBody Map<String, String> reqMap, RedirectAttributes ra) {
		System.out.println("MhController deleteFaq start...");
		String noticeNum = reqMap.get("noticeNum");
		System.out.println("noticeNum >>>>>" + noticeNum);
		int isDeleteFaq = ms.exposGogi(noticeNum);	
		
		if (isDeleteFaq > 0) {
			ra.addFlashAttribute("message", "노출되었습니다");
			return "redirect:/manager/CS/gogi";
		} else {
			ra.addFlashAttribute("message", "노출실패");
			return "redirect:/manager/CS/gogi";
		}
	}
	
	@GetMapping(value = "/mh/notsel")
	public String selGogiCorr(@RequestParam("noticeNum") Integer notNum, Model model) {
		System.out.println("MhController selGogiCorr start...");
		List<Notice_Table> notselList = ms.selNotList(notNum);
		
		model.addAttribute("notice", notselList);
		
		return "view_mh/manager_gogi_corr";
	}
	
	@PostMapping(value = "/mh/gogiupdatesel")
	public String upGogiUpdateList(@ModelAttribute Notice_Table notlist, RedirectAttributes ra) {
		System.out.println("MhController updFaqList start...");
		System.out.println("notlist >>>>>>>>>>>>" + notlist);
		int upGogiInt = ms.updateNotGogi(notlist);
		
		if(upGogiInt > 0) {
			ra.addFlashAttribute("message", "수정이 완료되었습니다!");
		} else {
			ra.addFlashAttribute("message", "수정이 실패했습니다.");
			return "redirect:/manager/CS/faq";
		}
		return "redirect:/manager/CS/gogi";
	}
	
	@GetMapping(value = "/mh/gogiInsert")
	public String gogiInsertPage(@RequestParam(value = "id", required = false) String id, HttpSession session) {
		System.out.println("MhController faqInsertPage start...");
		
		User_Table user = (User_Table)session.getAttribute("user");
		System.out.println("user >>>>>>>>>" + user);
		
		
		return "view_mh/manager_gogi_insert";
	}
	
	@PostMapping(value = "/mh/gogiinsertFrom")
	public String insertGogi(@ModelAttribute Notice_Table notInsList, RedirectAttributes ra) {
		System.out.println("MhController insertFaq start...");
		System.out.println("notInsList >>>>" + notInsList);
		int insertNotList = ms.insertNotice(notInsList);
		
		System.out.println("insertNotList >>>" + insertNotList);
		
		if(insertNotList > 0) {
			ra.addFlashAttribute("message", "새로작성이 완료되었습니다.");
		} else {
			ra.addFlashAttribute("message", "작성이 실패하였습니다.");
			return "redirect:/manager/CS/gogi";
		}
		
		return "redirect:/manager/CS/gogi";
	}
	

}
