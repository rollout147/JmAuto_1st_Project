package com.oracle.jmAuto.dao.sh;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Expert_Review;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.val;

@Repository
@RequiredArgsConstructor
public class DaoShImpl implements DaoSh {
	
	private final SqlSession session;

	public List<Car_General_Info> searchList(String keyword, int start, int end, Integer searchType) {
		System.out.println("DaoShImpl searchList start...");
		List<Car_General_Info> valueList = null;
		Map<String, Object> page = new HashMap<>();
		page.put("keyword", keyword);
		page.put("start",start);
		page.put("end",end);
		page.put("searchType", searchType);
		try {
			valueList = session.selectList("com.oracle.jmAuto.dto.mapper.sh.keywordSearch",page);
			System.out.println(valueList);
		} catch (Exception e) {
			System.out.println("DaoShImpl searchList exception >> "+e.getMessage());
		}
		return valueList;
		
	}

	public List<Car_General_Info> car_type_Car(int start, int end, int car_type) {
		System.out.println("DaoShImpl kCar start...");
		
		List<Car_General_Info> valueList = null;
		Map<String, Object> page = new HashMap<>();
		page.put("car_type", car_type);
		page.put("start",start);
		page.put("end",end);
		try {
			valueList = session.selectList("com.oracle.jmAuto.dto.mapper.sh.car_type_Car", page);
			System.out.println(valueList);
		} catch (Exception e) {
			System.out.println("DaoShImpl kCar exception >> "+e.getMessage());
		}
		return valueList;
	}

	@Override
	public List<Car_General_Info> detailSearch(String keyword, String model_name, int min_price, int max_price, int start, int end) {
		System.out.println("DaoShImpl detailSearch start...");
		List<Car_General_Info> valueList = null;
		Map<String, Object> detailKeyword = new HashMap<>();
		detailKeyword.put("keyword", keyword);
		detailKeyword.put("model_name", model_name);
		detailKeyword.put("min_price", min_price);
		detailKeyword.put("max_price", max_price);
		detailKeyword.put("start", start);
		detailKeyword.put("end", end);
		System.out.println("DaoShImpl detailSearch detailKeyword >> "+detailKeyword);
		
		try {
			valueList = session.selectList("com.oracle.jmAuto.dto.mapper.sh.detailSearch",detailKeyword);
			System.out.println(valueList);
		} catch (Exception e) {
			System.out.println("DaoShImpl detailSearch exception >> "+e.getMessage());
		}
		return valueList;
		
	}

	@Override
	public int cartot(int car_type) {
		int total = 0;
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.CarTot", car_type);
		} catch (Exception e) {
			System.out.println("DaoShImpl kcartot exception >> "+e.getMessage());
		}
		return total;
	}

	@Override
	public int detailSearchCartot(String keyword, String model_name, int min_price, int max_price) {
		int total = 0;
		Map<String, Object> detailKeyword = new HashMap<>();
		detailKeyword.put("keyword", keyword);
		detailKeyword.put("model_name", model_name);
		detailKeyword.put("min_price", min_price);
		detailKeyword.put("max_price", max_price);
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.detailSearchCartot", detailKeyword);
		} catch (Exception e) {
			System.out.println("DaoShImpl detailSearchCartot exception >> "+e.getMessage());
		}
		return total;
	}

	@Override
	public int searchListTotal(String keyword,Integer searchType) {
		int total = 0;
		Map<String, Object> value = new HashMap<>();
		value.put("keyword", keyword);
		value.put("searchType", searchType);
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.searchListTotal",value);
		} catch (Exception e) {
			System.out.println("DaoShImpl searchListTotal exception >> "+e.getMessage());
		}
		return total;
		
	}

	@Override
	public List<Car_General_Info> chkBrand(int brand, int start, int end) {
		List<Car_General_Info> carList = null;
		Map<String, Object> map = new HashMap<>();
		map.put("brand", brand);
		map.put("start", start);
		map.put("end", end);
		try {
			carList = session.selectList("com.oracle.jmAuto.dto.mapper.sh.chkBrand", map);
			System.out.println("DaoShImpl chkBrand >> "+carList);
		} catch (Exception e) {
			System.out.println("DaoShImpl kCar exception >> "+e.getMessage());
		}
		return carList;
	}

	@Override
	public int brandCarTot(int brand) {
		int total = 0;
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.chkBrandTotal", brand);
			System.out.println("DaoShImpl brandCarTot >> "+total);
		} catch (Exception e) {
			System.out.println("DaoShImpl kCar exception >> "+e.getMessage());
		}
		return total;
	}

	@Override
	public int detailBTotal(int brand, int manu_date1, int manu_date2, String fuel) {
		int total = 0;
		Map<String, Object> detailB = new HashMap<>();
		detailB.put("brand", brand);
		detailB.put("manu_date1", manu_date1);
		detailB.put("manu_date2", manu_date2);
		detailB.put("fuel",fuel);
		
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.detailBTotal", detailB);
		} catch (Exception e) {
			System.out.println("DaoShImpl kcartot exception >> "+e.getMessage());
		}
		return total;
	}

	@Override
	public List<Car_General_Info> detailB(int brand, int manu_date1, int manu_date2, String fuel, int start, int end) {
		System.out.println("DaoShImpl detailB start...");
		List<Car_General_Info> valueList = null;
		Map<String, Object> detailKeyword = new HashMap<>();
		detailKeyword.put("brand", brand);
		detailKeyword.put("manu_date1", manu_date1);
		detailKeyword.put("manu_date2", manu_date2);
		detailKeyword.put("fuel", fuel);
		detailKeyword.put("start", start);
		detailKeyword.put("end", end);
		
		System.out.println(detailKeyword);
		
		try {
			valueList = session.selectList("com.oracle.jmAuto.dto.mapper.sh.detailB",detailKeyword);
			System.out.println(valueList);
		} catch (Exception e) {
			System.out.println("DaoShImpl detailSearch exception >> "+e.getMessage());
		}
		return valueList;
		
	}

	@Transactional
	@Override
	public int InputCar(Map<String, Object> infor) {
		System.out.println("DaoShImpl InputCar start...");
		System.out.println("DaoShImpl infor >> "+infor);
		
		int result = 0;
		try {
			//차량 기본정보 저장
			result = session.insert("com.oracle.jmAuto.dto.mapper.sh.InputCar",infor);
			System.out.println("DaoShImpl InputCar result >> "+result);
			result=0;
			//메인이미지 저장
			result = session.insert("com.oracle.jmAuto.dto.mapper.sh.InputCarMainImg",infor);
			System.out.println("DaoShImpl InputCarMainImg result >> "+result);
			result=0;
			
			//이미지1 저장
			result = session.insert("com.oracle.jmAuto.dto.mapper.sh.InputCarImg_1",infor);
			System.out.println("DaoShImpl InputCarImg_1 result >> "+result);
			result=0;
			//이미지2 저장
			result = session.insert("com.oracle.jmAuto.dto.mapper.sh.InputCarImg_2",infor);
			System.out.println("DaoShImpl InputCarImg_2 result >> "+result);
			result=0;
			//이미지3 저장
			result = session.insert("com.oracle.jmAuto.dto.mapper.sh.InputCarImg_3",infor);
			System.out.println("DaoShImpl InputCarImg_3 result >> "+result);
			result=0;
			//이미지4 저장
			result = session.insert("com.oracle.jmAuto.dto.mapper.sh.InputCarImg_4",infor);
			System.out.println("DaoShImpl InputCarImg_4 result >> "+result);
		} catch (Exception e) {
			System.out.println("DaoShImpl InputCar exception >> "+e.getMessage());
		}
		
		return result;
	}

	@Override
	public int carNumChk(String car_num) {
		System.out.println("DaoShImpl carNumChk car_num >> "+car_num);
		int result = 0;
		
		try {
			result = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.carNumChk", car_num);
			System.out.println("DaoShImpl carNumChk result >> "+result);
		} catch (Exception e) {
			System.out.println("DaoShImpl carNumChk exception >>" + e.getMessage());
		}
		return result;
	}

	@Override
	public List<Car_General_Info> getCarNum() {
		List<Car_General_Info> car_num = null;
		
		car_num = session.selectList("com.oracle.jmAuto.dto.mapper.sh.getCarNum");
		return car_num;
	}

	@Override
	public int insertImgUrl(Map<String, Object> insertMap) {
		int result = 0; 
		try {
			result = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.insertImgUrl", insertMap);
		} catch (Exception e) {
			System.out.println("DaoShImpl insertImgUrl exception >>" + e.getMessage());
		}
		return result;
	}

	@Override
	public List<Car_General_Info> allCar(int start, int end) {
		
		System.out.println("DaoShImpl allCar Start...");
		List<Car_General_Info> allCar = null;
		Map<String, Object> page = new HashMap<>();
		page.put("start", start);
		page.put("end", end);
		
		try {
			allCar = session.selectList("com.oracle.jmAuto.dto.mapper.sh.allCar",page);
		} catch (Exception e) {
			System.out.println("DaoShImpl allCar exception >>" + e.getMessage());
		}
		return allCar;
	}

	@Override
	public int carTotal() {
		
		int total = 0;
		
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.allCarTotal");
		} catch (Exception e) {
			System.out.println("DaoShImpl carTotal exception >>" + e.getMessage());
		}
		
		return total;
	}

	@Override
	public List<Car_General_Info> Asearch(String keyword, int start, int end) {
		System.out.println("DaoShImpl Asearch Start...");
		
		List<Car_General_Info> Alist = null;
		Map<String, Object> value = new HashMap<>();
		value.put("keyword", keyword);
		value.put("start", start);
		value.put("end", end);
		System.out.println(value);
		
		try {
			Alist = session.selectList("com.oracle.jmAuto.dto.mapper.sh.Asearch",value);
			System.out.println(" kk 검색된 리스트 >> "+Alist);
		} catch (Exception e) {
			System.out.println("DaoShImpl Asearch exception >>" + e.getMessage());
		}
		return Alist;
	}

	@Override
	public int carDeactive(String sellNum) {
		System.out.println("DaoShImpl carDeactive Start...");
		System.out.println("DaoShImpl carDeactive sellNum >> "+sellNum);
		int result = 0;
		try {
			result = session.update("com.oracle.jmAuto.dto.mapper.sh.carDeactive",sellNum);
			System.out.println("DaoShImpl carDeactive result >> "+result);
		} catch (Exception e) {
			System.out.println("DaoShImpl carDeactive exception >>" + e.getMessage());
		}
		return result;
	}

	@Override
	public int carActive(String sellNum) {
		System.out.println("DaoShImpl carActive Start...");
		int result = 0;
		try {
			result = session.update("com.oracle.jmAuto.dto.mapper.sh.carActive",sellNum);
		} catch (Exception e) {
			System.out.println("DaoShImpl carActive exception >>" + e.getMessage());
		}
		return result;
	}

	@Override
	public int reviewTotal() {
		int total = 0;
		
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.reviewTotal");
		} catch (Exception e) {
			System.out.println("DaoShImpl reviewTotal exception >>" + e.getMessage());
		}
		
		return total;
	}

	@Override
	public List<Expert_Review> allReview(int start, int end) {
		System.out.println("DaoShImpl allReview Start...");
		List<Expert_Review> allReview = null;
		Map<String, Object> page = new HashMap<>();
		page.put("start", start);
		page.put("end", end);
		
		try {
			allReview = session.selectList("com.oracle.jmAuto.dto.mapper.sh.allReview",page);
		} catch (Exception e) {
			System.out.println("DaoShImpl allCar exception >>" + e.getMessage());
		}
		return allReview;
	}

	@Override
	public List<Expert_Review> reviewSearch(String keyword, int start, int end) {
		System.out.println("DaoShImpl reviewSearch Start...");
		
		List<Expert_Review> reviewList = null;
		Map<String, Object> value = new HashMap<>();
		value.put("keyword", keyword);
		value.put("start", start);
		value.put("end", end);
		
		try {
			System.out.println("keyword >> "+keyword + " start >> "+start+" end >> "+end);
			System.out.println("value >> "+value);
			reviewList = session.selectList("com.oracle.jmAuto.dto.mapper.sh.reviewSearch",value);
			System.out.println("검색된 리스트 >> "+reviewList);
		} catch (Exception e) {
			System.out.println("DaoShImpl Asearch exception >>" + e.getMessage());
		}
		return reviewList;
	}

	@Override
	public int reviewDeactive(String review_num) {
		System.out.println("DaoShImpl reviewDeactive Start...");
		int result = 0;
		try {
			result = session.update("com.oracle.jmAuto.dto.mapper.sh.reviewDeactive",review_num);
		} catch (Exception e) {
			System.out.println("DaoShImpl reviewDeactive exception >>" + e.getMessage());
		}
		return result;
	}

	@Override
	public int reviewActive(String review_num) {
		System.out.println("DaoShImpl reviewActive Start...");
		int result = 0;
		try {
			result = session.update("com.oracle.jmAuto.dto.mapper.sh.reviewActive",review_num);
		} catch (Exception e) {
			System.out.println("DaoShImpl reviewActive exception >>" + e.getMessage());
		}
		return result;
	}

	@Override
	public int AsearchTot(String keyword) {
		System.out.println("DaoShImpl AsearchTot Start...");
		
		int total = 0;
		
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.AsearchTot",keyword);
		} catch (Exception e) {
			System.out.println("DaoShImpl AsearchTot exception >>" + e.getMessage());
		}
		return total;
	}

	@Override
	public int keywordReviewTotal(String keyword) {
		
		int total = 0;
		
		try {
			total = session.selectOne("com.oracle.jmAuto.dto.mapper.sh.keywordReviewTotal",keyword);
		} catch (Exception e) {
			System.out.println("DaoShImpl keywordReviewTotal exception >>" + e.getMessage());
		}
		return total;
	}

}
