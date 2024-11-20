package com.oracle.jmAuto.dao.jh;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Payment;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class StatsDaoImpl  implements StatsDao{

	private final SqlSession session;

	
	// -------------------------------------------- 판매자 실적조회 ------------------------------------------------------------------------
	
	@Override
	public Map<String, Object> dao_quarterly_results(int year, String user_id) {
		Map<String, Object> quarterly_results = null;
		try {
			 Map<String, Object> params = new HashMap<>();
		        params.put("year", year);
		        params.put("user_id", user_id);
			
			quarterly_results  = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.quarterly_results", params, "QUARTER");
			System.out.println("StatsDaoImpl quarterly_results->"+ quarterly_results.size());
		} catch (Exception e) {
			System.out.println("StatsDaoImpl quarterly_results Exception->"+e.getMessage());
		  }
		return quarterly_results;
	}

	@Override
	public Map<String, Object> dao_annual_performance(String user_id) {
	    Map<String, Object> annual_performance = null;
	    try {
	        annual_performance = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.annual_performance", user_id, "YEAR");
	        Map<String, Object> sortedMap = new TreeMap<>(annual_performance);
	        System.out.println("StatsDaoImpl annual_performance->" + sortedMap.size());
	        return sortedMap;
	    } catch (Exception e) {
	        System.out.println("StatsDaoImpl annual_performance Exception->" + e.getMessage());
	      }
	    return annual_performance;
	}

	@Override
	public Map<String, Object> dao_car_type_results(int year, String user_id) {
		Map<String, Object> car_type_results = null;
		try {
			 Map<String, Object> params = new HashMap<>();
		        params.put("year", year);
		        params.put("user_id", user_id);
			
			car_type_results  = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.car_type_results", params, "CAR_TYPE");
			System.out.println("StatsDaoImpl car_type_results->"+car_type_results.size());
		} catch (Exception e) {
			System.out.println("StatsDaoImpl brand_type_results Exception->"+e.getMessage());
		  }
		return car_type_results;
	}

	@Override
	public Map<String, Object> dao_brand_type_results(int year, String user_id) {
		Map<String, Object> brand_type_results = null;
		try {
			Map<String, Object> params = new HashMap<>();
		        params.put("year", year);
		        params.put("user_id", user_id);
	        
			brand_type_results  = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.brand_type_results", params, "BRAND");
			System.out.println("StatsDaoImpl brand_type_results->"+brand_type_results.size());
		} catch (Exception e) {
			System.out.println("StatsDaoImpl brand_type_results Exception->"+e.getMessage());
		  }
		return brand_type_results;
	}

	@Override
	public Map<String, Object> dao_jago_list(String user_id) {
		Map<String, Object> jago_list = null;
	    try {
	    	jago_list = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.jago_list", user_id, "매물번호");
	        System.out.println("StatsDaoImpl jago_list->" + jago_list.size());
	    } catch (Exception e) {
	        System.out.println("StatsDaoImpl annual_performance Exception->" + e.getMessage());
	      }
	    return jago_list;
	}

	@Override
	public List<Car_General_Info> dao_receiving_list(String user_id) {
		List<Car_General_Info> receiving_list = null;
		try {
			receiving_list = session.selectList("com.oracle.jmAuto.Stats_Mapper.jh.receiving_list", user_id);
			System.out.println("StatsDaoImpl receiving_list->"+receiving_list.size());
		} catch (Exception e) {
			System.out.println("StatsDaoImpl annual_performance Exception->" + e.getMessage());
		  }
		return receiving_list;
	}

	@Override
	public Map<String, Object> dao_delivery_list(String user_id) {
		Map<String, Object> delivery_list = null;
	    try {
	    	delivery_list = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.delivery_list", user_id, "SELL_NUM");
	        System.out.println("StatsDaoImpl delivery_list->" + delivery_list.size());
	    } catch (Exception e) {
	        System.out.println("StatsDaoImpl annual_performance Exception->" + e.getMessage());
	      }
	    return delivery_list;
	}

	@Override
	public Map<String, Object> dao_cost_list(String user_id) {
		Map<String, Object> cost_list = null;
	    try {
	    	cost_list = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.cost_list", user_id, "SELL_NUM");
	        System.out.println("StatsDaoImpl cost_list->" + cost_list.size());
	    } catch (Exception e) {
	        System.out.println("StatsDaoImpl annual_performance Exception->" + e.getMessage());
	      } 
	    return cost_list; 
	}

	/* ---------------------------------------------------------여기서부터 관리자------------------------------------------------------------------- */
	
	@Override
	public List<String> findAllData() {
		return session.selectList("com.oracle.jmAuto.Stats_Mapper.jh.findAllData");
	}

	@Override
	public List<String> findFilteredData(String query) {
		return session.selectList("com.oracle.jmAuto.Stats_Mapper.jh.findFilteredData", query);
	}
	
	@Override
	public String findAccountNameByUserId(String userId) {
		return session.selectOne("com.oracle.jmAuto.Stats_Mapper.jh.findAccountNameByUserId", userId);
    }

	@Override
	public Map<String, Object> dao_admin_quarter_cost_list(int year) {
		Map<String, Object> admin_quarter_cost_list = null;
		try {
			admin_quarter_cost_list = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.admin_quarter_cost_list", year, "QUARTER");
			System.out.println("StatsDaoImpl receiving_list->"+admin_quarter_cost_list.size());
		} catch (Exception e) {
			System.out.println("StatsDaoImpl annual_performance Exception->" + e.getMessage());
		  }
		return admin_quarter_cost_list;
	}

	@Override
	public Map<String, Object> dao_sales_profit_results(String user_id) {
		Map<String, Object> sales_profit_results = null;
		try {
			sales_profit_results = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.sales_profit_results", user_id, "QUARTER");
			System.out.println("StatsDaoImpl sales_profit_results->"+sales_profit_results.size());
		} catch (Exception e) {
			System.out.println("StatsDaoImpl sales_profit_results Exception->" + e.getMessage());
		  }
		return sales_profit_results;
	}

	@Override
	public Map<String, Object> dao_admin_sales_profit_results() {
		Map<String, Object> admin_sales_profit_results = null;
		try {
			admin_sales_profit_results = session.selectMap("com.oracle.jmAuto.Stats_Mapper.jh.admin_sales_profit_results", "QUARTER");
			System.out.println("StatsDaoImpl admin_sales_profit_results->"+admin_sales_profit_results.size());
		} catch (Exception e) {
			System.out.println("StatsDaoImpl admin_sales_profit_results Exception->" + e.getMessage());
		  }
		return admin_sales_profit_results;
	}


}

