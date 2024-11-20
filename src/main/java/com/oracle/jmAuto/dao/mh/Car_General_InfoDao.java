package com.oracle.jmAuto.dao.mh;

import java.util.List;
import java.util.Map;

import com.oracle.jmAuto.dto.Car_Image;

public interface Car_General_InfoDao {

	List<Car_General_InfoDao> CarList();

	List<Car_General_InfoDao> carSearchList(String keyword, int searchType);

	List<Car_General_InfoDao> carInfoList(String sellNum);

	List<Map<String, Object>> autocomplete(Map<String, Object> paramMap);

	List<Car_Image> selListImg(String sellNum);
	
}
