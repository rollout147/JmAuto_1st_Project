package com.oracle.jmAuto.dao.mh;

import java.util.List;

import com.oracle.jmAuto.dto.Faq;

public interface FaqDao {

	List<FaqDao> allFaqList();

	List<Faq> selFaqList(Integer faqNum);

	int updateFaq(Faq faqlist);

	int instFaqList(Faq faqInsList);

	int delFaq(String faqNum);

	int exposFaq(String faqNum);

}
