package com.oracle.jmAuto.dao.mh;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.jmAuto.dto.Car_Image;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class Car_General_InfoDaoImpl implements Car_General_InfoDao {
	private final SqlSession session;

	@Override
	public List<Car_General_InfoDao> CarList() {
		System.out.println("Car_General_InfoImpl CarList start...");
		List<Car_General_InfoDao> carList = null;
		
		try {
			carList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.CarList");
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return carList;
	}

	@Override
	public List<Car_General_InfoDao> carSearchList(String keyword, int searchType) {
		System.out.println("Car_General_InfoImpl carSearchList start...");
		List<Car_General_InfoDao> listCarInfo = null;
		
		try {
			Map<String, Object> params = new HashMap<>();
			params.put("keyword", keyword);
			params.put("searchType", searchType);
			
			listCarInfo = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.CarSearchList",params);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return listCarInfo;
	}

	@Override
	public List<Car_General_InfoDao> carInfoList(String sellNum) {
		System.out.println("Car_General_InfoImpl carInfoList start...");
		List<Car_General_InfoDao> carInfoList = null;
		
		try {
			carInfoList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.findSelectOneList", sellNum);
			System.out.println("Car_General_InfoImpl carInfoList carInfoList => " + carInfoList);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return carInfoList;
	}

	@Override
	public List<Map<String, Object>> autocomplete(Map<String, Object> paramMap) {
		List<Map<String, Object>> autoList = null;
		System.out.println("Car_General_InfoImpl autocomplete start...");
		
		try {
			autoList = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.autocomplete", paramMap);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return autoList;
	}

	@Override
	public List<Car_Image> selListImg(String sellNum) {
		List<Car_Image> carImg = null;
		System.out.println("Car_General_InfoImpl selListImg start...");
		
		try {
			carImg = session.selectList("com.oracle.jmAuto.dto.Mapper.mh.selImgList",sellNum);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return carImg;
	}


	
	
}
