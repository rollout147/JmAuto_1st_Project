package com.oracle.jmAuto.service.jh;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.oracle.jmAuto.dao.jh.StatsDao;
import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Payment;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class StatsServiceImpl implements StatsService{

	private final StatsDao sd;

	@Override
	public Map<String, Object> service_quarterly_results(int year, String user_id) {
		Map<String, Object> quarterly_results = null;
		quarterly_results = sd.dao_quarterly_results(year, user_id);
		return quarterly_results;
	}

	@Override
	public Map<String, Object> service_annual_performance(String user_id) {
		Map<String, Object> annual_performance = null;
		annual_performance = sd.dao_annual_performance(user_id);
		return annual_performance;
	}

	@Override
	public Map<String, Object> service_car_type_results(int year, String user_id) {
		Map<String, Object> car_type_results = null;
		car_type_results = sd.dao_car_type_results(year, user_id);
		return car_type_results;
	}

	@Override
	public Map<String, Object> service_brand_type_results(int year, String user_id) {
		Map<String, Object> brand_type_results = null;
		brand_type_results = sd.dao_brand_type_results(year, user_id);
		return brand_type_results;
	}

	@Override
	public Map<String, Object> service_jago_list(String user_id) {
		Map<String, Object> jago_list = null;
		jago_list = sd.dao_jago_list(user_id);
		return jago_list;
	}

	@Override
	public List<Car_General_Info> service_receiving_list(String user_id) {
		List<Car_General_Info> receiving_list = null;
		receiving_list = sd.dao_receiving_list(user_id);
		return receiving_list;
	}

	@Override
	public Map<String, Object> service_delivery_list(String user_id) {
		Map<String, Object> delivery_list = null;
		delivery_list = sd.dao_delivery_list(user_id);
		return delivery_list;
	}

	@Override
	public Map<String, Object> service_cost_list(String user_id) {
		Map<String, Object> cost_list = null;
		cost_list = sd.dao_cost_list(user_id);
		return cost_list;
	}

	/* ---------------------------------------------------------여기서부터 관리자------------------------------------------------------------------- */
	
	@Override
	public List<String> getAllData() {
		return sd.findAllData();
	}

	@Override
	public List<String> getFilteredData(String query) {
		return sd.findFilteredData(query);
	}
	
	@Override
	public String getAccountNameByUserId(String userId) {
		return sd.findAccountNameByUserId(userId);
	}

	@Override
	public Map<String, Object> service_admin_quarter_cost_list(int year) {
		Map<String, Object> admin_quarter_cost_list = null;
		admin_quarter_cost_list = sd.dao_admin_quarter_cost_list(year);
		return admin_quarter_cost_list;
	}

	@Override
	public Map<String, Object> service_sales_profit_results(String user_id) {
		Map<String, Object> sales_profit_results = null;
		sales_profit_results = sd.dao_sales_profit_results(user_id);
		return sales_profit_results;
	}

	@Override
	public Map<String, Object> service_admin_sales_profit_results() {
		Map<String, Object> admin_sales_profit_results = null;
		admin_sales_profit_results = sd.dao_admin_sales_profit_results();
		return admin_sales_profit_results;
	}


}

