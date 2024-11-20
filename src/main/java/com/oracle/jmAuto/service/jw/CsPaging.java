package com.oracle.jmAuto.service.jw;

import lombok.Data;

@Data
public class CsPaging {
	
	private int currentPage = 1;
	private int rowPage		= 9;
	private int pageBlock	= 5;
	
	private int start;		
	private int end;
	private int startPage;
	private int endPage;
	private int total;
	private int totalPage;
	

	public CsPaging(int total, String currentPage1) {
		this.total = total;
		System.out.println("CsPaging total Start...");

		if (currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);
			System.out.println("CsPaging if currentPage1->"+currentPage);
		}
		
		start		= (currentPage - 1) * rowPage + 1;	// 페이지 시작부분 1,11,21....
		end			= start + rowPage - 1;				// 페이지 끝부분 10,20,30...
		
		totalPage	= (int)Math.ceil((double)total / rowPage);
		startPage 	= currentPage - (currentPage - 1) % pageBlock;	//1페이지로 시작하게 만듬
		endPage		= startPage + pageBlock - 1;	// 10페이지로 끝나게 만듬
		
		if (endPage > totalPage) {
			endPage = totalPage;
			System.out.println("CsPaging if endPage...");
		}
		
		System.out.println("currentPage: " + currentPage);
	    System.out.println("startPage: " + startPage);
	    System.out.println("endPage: " + endPage);
	    System.out.println("totalPage: " + totalPage);
		
	}
	
}
