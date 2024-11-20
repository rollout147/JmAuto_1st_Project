package com.oracle.jmAuto.service.jh;

import java.util.List;
import java.util.Map;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Payment;


public interface StatsService {

	Map<String, Object> service_quarterly_results(int year, String user_id);

	Map<String, Object> service_annual_performance(String user_id);

	Map<String, Object> service_car_type_results(int year, String user_id);

	Map<String, Object> service_brand_type_results(int year, String user_id);

	Map<String, Object> service_jago_list(String user_id);

	List<Car_General_Info> service_receiving_list(String user_id);

	Map<String, Object> service_delivery_list(String user_id);

	Map<String, Object> service_cost_list(String user_id);

	List<String> getAllData();

	List<String> getFilteredData(String query);
	
	String getAccountNameByUserId(String userId);

	Map<String, Object> service_admin_quarter_cost_list(int year);

	Map<String, Object> service_sales_profit_results(String user_id);

	Map<String, Object> service_admin_sales_profit_results();




	
}
