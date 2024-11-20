package com.oracle.jmAuto.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Payment;
import com.oracle.jmAuto.service.jh.StatsService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping(value = "/view_jh")
public class JhController {

	private final StatsService ss;
	
	
	//판매자 통계 팝업으로 열기(처음열면 2024년 매출 그래프가 자동으로 나옴)--------------------------------------------------------------------------------
	@GetMapping(value = "/seller_Stats_MainForm")
	public String seller_Stats_MainForm(HttpSession session, Model model) {
		System.out.println("판매자 통계 팝업페이지 열림");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("session에서 가져온 user_id: " + user_id);
		
		Map<String, Object> sales_profit_results = ss.service_sales_profit_results(user_id);
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("sales_profitDataFetched", dataFetched);
		model.addAttribute("sales_profit_results", sales_profit_results);
		
		return "view_jh/seller_Stats_MainForm";
	}
	
	//관리자 통계 팝업으로 열기-------------------------------------------------------------------------------
	@GetMapping(value = "/admin_Stats_MainForm")
	public String admin_Stats_MainForm(Model model) {
		System.out.println("관리자 통계 팝업페이지 열림");
		
		Map<String, Object> admin_sales_profit_results = ss.service_admin_sales_profit_results();
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("admin_sales_profitDataFetched", dataFetched);
		model.addAttribute("admin_sales_profit_results", admin_sales_profit_results);
		return "view_jh/admin_Stats_MainForm"; 
	}
	
	
//-----------------------------------------------판매자 실적조회 -----------------------------------------------------------------
	
	
	//분기별 실적 조회--------------------------------------------------------------------------
	@GetMapping(value = "/quarterly_results")
	public String quarterly_results(HttpSession session, @RequestParam("year") int year, Model model) {
		System.out.println("분기별 실적 조회");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
        System.out.println("session에서 가져온 user_id: " + user_id);
		
		Map<String, Object> quarterly_results = ss.service_quarterly_results(year, user_id);
		System.out.println("JhController quarterly_results->" + quarterly_results.size());
		System.out.println("JhController year->" + year);
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("quarterlyDataFetched", dataFetched);
		model.addAttribute("quarterly_results", quarterly_results);
		model.addAttribute("year" , year);
		
		return "view_jh/seller_Stats_MainForm";
	}
		
	//연도별 실적 조회--------------------------------------------------------------------------
	@GetMapping(value = "/annual_performance")
	public String annual_performance(HttpSession session, Model model) {
		System.out.println("연도별 실적 조회");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("session에서 가져온 user_id: " + user_id);
		        
		Map<String, Object> annual_performance = ss.service_annual_performance(user_id);
		System.out.println("JhController annual_performance->"+annual_performance.size());
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("annualDataFetched", dataFetched);
		model.addAttribute("annual_performance", annual_performance);
		
		return "view_jh/seller_Stats_MainForm";
	}
	
	//브랜드별, 차량종류별 실적 조회--------------------------------------------------------------------------
	@GetMapping(value = "/brand_type_results")
	public String brand_type_results(HttpSession session, @RequestParam("year") int year, Model model) {
		System.out.println("브랜드별, 차량종류별 실적 조회");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("session에서 가져온 user_id: " + user_id);
		        
		//차량종류별 실적 조회
		Map<String, Object> car_type_results = ss.service_car_type_results(year, user_id);
		System.out.println("JhController car_type_results->" + car_type_results.size());
		
		//브랜드별 실적 조회
		Map<String, Object> brand_type_results = ss.service_brand_type_results(year, user_id);
		System.out.println("JhController brand_type_results->" + brand_type_results.size());
		
		System.out.println("JhController year->" + year);
		System.out.println("JhController user_id->" + user_id);
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("brand_typeDataFetched", dataFetched);
		model.addAttribute("car_type_results", car_type_results);
		model.addAttribute("brand_type_results", brand_type_results);
		model.addAttribute("year" , year);
		
		return "view_jh/seller_Stats_MainForm";
	}
	
	//재고내역 조회----------------------------------------------------------------------------
	@GetMapping(value = "/jago_list")
	public String jago_list(HttpSession session, Model model) {
		System.out.println("재고내역 조회");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("session에서 가져온 user_id: " + user_id);
		        
		Map<String, Object> jago_list = ss.service_jago_list(user_id);
		System.out.println("JhController jago_list->"+jago_list.size());
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("jagoListDataFetched", dataFetched);
		model.addAttribute("jago_list", jago_list);
		
		return "view_jh/seller_Stats_MainForm";
	}
	
	//입고내역 조회-------------------------------------------------------------------------
	@GetMapping(value = "/receiving_list")
	public String receiving_list(HttpSession session, Model model) {
		System.out.println("입고내역 조회");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("session에서 가져온 user_id: " + user_id);
		        
		List<Car_General_Info> receiving_list = ss.service_receiving_list(user_id);
		System.out.println("JhController receiving_list->" + receiving_list.size());
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("receivingListDataFetched", dataFetched);
		model.addAttribute("receiving_list", receiving_list);
		
		return "view_jh/seller_Stats_MainForm";
	}
	
	//출고내역 조회-----------------------------------------------------------------------------------
	@GetMapping(value = "/delivery_list")
	public String delivery_list(HttpSession session, Model model) {
		System.out.println("출고내역 조회");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("session에서 가져온 user_id: " + user_id);
		        
		Map<String, Object> delivery_list = ss.service_delivery_list(user_id);
		System.out.println("JhController delivery_list->" + delivery_list.size());
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("deliveryListDataFetched", dataFetched);
		model.addAttribute("delivery_list", delivery_list);
		
		return "view_jh/seller_Stats_MainForm";
	}
	
	//비용내역 조회-------------------------------------------------------------------------------
	@GetMapping(value = "/cost_list")
	public String cost_list(HttpSession session, Model model) {
		System.out.println("비용내역 조회");
		
		// 유저 ID 가져오기
		String user_id = (String) session.getAttribute("user_id");
		System.out.println("session에서 가져온 user_id: " + user_id);
		        
		Map<String, Object> cost_list = ss.service_cost_list(user_id);
		System.out.println("JhController cost_list->" + cost_list.size());
		
		boolean dataFetched = true; // 데이터가 있다면 fetch
		model.addAttribute("costListDataFetched", dataFetched);
		model.addAttribute("cost_list", cost_list);
		
		return "view_jh/seller_Stats_MainForm";
	}
//--------------------------------------------------판매자 실적조회 끝-------------------------------------------------------------

	
	
//--------------------------------------------------관리자 실적조회---------------------------------------------------------------	
	
	
	// 아이디 검색창 클릭하면 판매자 아이디가 자동완성됨 -------------------------------------------
	@GetMapping("/search/all")
	@ResponseBody
    public List<String> getAllSearchData() {
		List<String> allData = ss.getAllData();
		return allData;      
	}

    // 검색창 입력시 입력된 값에 맞게 실시간 자동 필터링 -------------------------------------------
    @GetMapping("/search/filter")
    @ResponseBody
    public List<String> getFilteredData(@RequestParam("query") String query) {
    	List<String> filteredData = ss.getFilteredData(query);
    	return filteredData;  
    }
	
    // 검색창 아이디를 클릭하면 그 아이디에 맞는 판매자 이름을 DB에서 가져옴 -------------------------------------------
    @GetMapping("/search/account")
    @ResponseBody
    public Map<String, String> getAccountName(@RequestParam("user_id") String userId) {
        String accountName = ss.getAccountNameByUserId(userId);
        Map<String, String> response = new HashMap<>();
        response.put("accountName", accountName);
        return response;
    }
        
    //분기별 실적 조회--------------------------------------------------------------------------
  	@GetMapping(value = "/admin_quarterly_results")
  	public String admin_quarterly_results(@RequestParam("user_id") String user_id, @RequestParam("year") int year, Model model) {
  		System.out.println("관리자 분기별 실적 조회");
        System.out.println("admin이 요청한 user_id: " + user_id);
  		
  		Map<String, Object> quarterly_results = ss.service_quarterly_results(year, user_id);
  		System.out.println("JhController quarterly_results->" + quarterly_results.size());
  		System.out.println("JhController year->" + year);
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("quarterlyDataFetched", dataFetched);
  		model.addAttribute("quarterly_results", quarterly_results);
  		model.addAttribute("year" , year);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
  		
  	//연도별 실적 조회--------------------------------------------------------------------------
  	@GetMapping(value = "/admin_annual_performance")
  	public String admin_annual_performance(@RequestParam("user_id") String user_id, Model model) {
  		System.out.println("관리자 연도별 실적 조회");
  		System.out.println("admin이 요청한 user_id: " + user_id);
  		        
  		Map<String, Object> annual_performance = ss.service_annual_performance(user_id);
  		System.out.println("JhController annual_performance->"+annual_performance.size());
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("annualDataFetched", dataFetched);
  		model.addAttribute("annual_performance", annual_performance);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
  	
  	//브랜드별, 차량종류별 실적 조회--------------------------------------------------------------------------
  	@GetMapping(value = "/admin_brand_type_results")
  	public String admin_brand_type_results(@RequestParam("user_id") String user_id, @RequestParam("year") int year, Model model) {
  		System.out.println("관리자 브랜드별, 차량종류별 실적 조회");
  		System.out.println("admin이 요청한 user_id: " + user_id);
  		        
  		//차량종류별 실적 조회
  		Map<String, Object> car_type_results = ss.service_car_type_results(year, user_id);
  		System.out.println("JhController car_type_results->" + car_type_results.size());
  		
  		//브랜드별 실적 조회
  		Map<String, Object> brand_type_results = ss.service_brand_type_results(year, user_id);
  		System.out.println("JhController brand_type_results->" + brand_type_results.size());
  		
  		System.out.println("JhController year->" + year);
  		System.out.println("JhController user_id->" + user_id);
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("brand_typeDataFetched", dataFetched);
  		model.addAttribute("car_type_results", car_type_results);
  		model.addAttribute("brand_type_results", brand_type_results);
  		model.addAttribute("year" , year);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
  	
  	//재고내역 조회----------------------------------------------------------------------------
  	@GetMapping(value = "/admin_jago_list")
  	public String admin_jago_list(@RequestParam("user_id") String user_id, Model model) {
  		System.out.println("관리자 재고내역 조회");
  		System.out.println("admin이 요청한 user_id: " + user_id);
  		        
  		Map<String, Object> jago_list = ss.service_jago_list(user_id);
  		System.out.println("JhController jago_list->"+jago_list.size());
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("jagoListDataFetched", dataFetched);
  		model.addAttribute("jago_list", jago_list);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
  	
  	//입고내역 조회-------------------------------------------------------------------------
  	@GetMapping(value = "/admin_receiving_list")
  	public String admin_receiving_list(@RequestParam("user_id") String user_id, Model model) {
  		System.out.println("관리자 입고내역 조회");
  		System.out.println("admin이 요청한 user_id: " + user_id);
  		        
  		List<Car_General_Info> receiving_list = ss.service_receiving_list(user_id);
  		System.out.println("JhController receiving_list->" + receiving_list.size());
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("receivingListDataFetched", dataFetched);
  		model.addAttribute("receiving_list", receiving_list);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
  	
  	//출고내역 조회-----------------------------------------------------------------------------------
  	@GetMapping(value = "/admin_delivery_list")
  	public String delivery_list(@RequestParam("user_id") String user_id, Model model) {
  		System.out.println("관리자 출고내역 조회");
  		System.out.println("admin이 요청한 user_id: " + user_id);
  		        
  		Map<String, Object> delivery_list = ss.service_delivery_list(user_id);
  		System.out.println("JhController delivery_list->" + delivery_list.size());
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("deliveryListDataFetched", dataFetched);
  		model.addAttribute("delivery_list", delivery_list);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
  	
  	//기업별 지불내역 조회-------------------------------------------------------------------------------
  	@GetMapping(value = "/admin_cost_list")
  	public String cost_list(@RequestParam("user_id") String user_id, Model model) {
  		System.out.println("관리자 기업별 지불내역 조회");
  		System.out.println("admin이 요청한 user_id: " + user_id);
  		        
  		Map<String, Object> cost_list = ss.service_cost_list(user_id);
  		System.out.println("JhController cost_list->" + cost_list.size());
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("costListDataFetched", dataFetched);
  		model.addAttribute("cost_list", cost_list);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
    
  	//분기별 지불내역 조회-------------------------------------------------------------------------------
  	@GetMapping(value = "/admin_quarter_cost_list")
  	public String admin_quarter_cost_list(@RequestParam("year") int year, Model model) {
  		System.out.println("관리자 분기별 지불내역 조회");
  		System.out.println("admin이 선택한 연도 ->" + year);  
  		
  		Map<String, Object> admin_quarter_cost_list = ss.service_admin_quarter_cost_list(year);
  		System.out.println("JhController admin_quarter_cost_list->" + admin_quarter_cost_list.size());
  		
  		boolean dataFetched = true; // 데이터가 있다면 fetch
  		model.addAttribute("adminQuarterCostListDataFetched", dataFetched);
  		model.addAttribute("admin_quarter_cost_list", admin_quarter_cost_list);
  		model.addAttribute("year" , year);
  		
  		return "view_jh/admin_Stats_MainForm";
  	}
    
    
  	
}


