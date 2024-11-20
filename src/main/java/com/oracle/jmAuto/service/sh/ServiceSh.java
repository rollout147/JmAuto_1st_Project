package com.oracle.jmAuto.service.sh;

import java.util.List;
import java.util.Map;

import com.oracle.jmAuto.dto.Car_General_Info;
import com.oracle.jmAuto.dto.Expert_Review;

public interface ServiceSh {

	List<Car_General_Info> searchList(String keyword, int start, int end, Integer searchType);

	List<Car_General_Info> car_type_Car(int start, int end, int car_type);

	List<Car_General_Info> detailSearch(String keyword, String model_name, int min_price, int max_price, int start, int end);

	int detailSearchCartot(String keyword, String model_name, int min_price, int max_price);

	int searchListTotal(String keyword, Integer searchType);

	int cartot(int car_type);

	List<Car_General_Info> chkBrand(int brand, int start, int end);

	int brandCarTot(int brand);

	int detailBTotal(int brand, String manu_date, String fuel);

	List<Car_General_Info> detailB(int brand, String manu_date, String fuel, int start, int end);

	int InputCar(Map<String, Object> infor);

	int carNumChk(String car_num);

	List<Car_General_Info> getCarNum();

	int insertImgUrl(Map<String, Object> insertMap);

	List<Car_General_Info> allCar(int start, int end);

	int carTotal();

	List<Car_General_Info> Asearch(String keyword, int start, int end);

	int carDeactive(String sellNum);

	int carActive(String sellNum);

	int reviewTotal();

	List<Expert_Review> allReview(int start, int end);

	List<Expert_Review> reviewSearch(String keyword, int start, int end);

	int reviewDeactive(String review_num);

	int reviewActive(String review_num);

	int AsearchTot(String keyword);

	int keywordReviewTotal(String keyword);


	


}