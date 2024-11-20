package com.oracle.jmAuto.service.kh;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Paging {
	private int currentPage = 1;
	private int rowPage 	= 10;
	private int pageBlock	= 10;
	private int start;
	private int end;
	private int	startPage;
	private int endPage;
	private int total;
	private int totalPage;
	
	public Paging(int total, String currentPage1) {
		
		//#dummy	18
		this.total = total;
		
		if(currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);
		}
		
		//#dummy			1				10			=	1	11
		start 		= (currentPage - 1) * rowPage + 1;
		//#dummy		1		10						=	10	20
		end			= start + rowPage - 1;
		
		totalPage	= (int)Math.ceil((double)total / rowPage);
		
		startPage	= currentPage - (currentPage - 1) % pageBlock;
		endPage		= startPage + pageBlock - 1;
		
		//# blank page exception
		if(endPage > totalPage) {
			endPage = totalPage;
		}
	}
	
}
