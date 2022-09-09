package com.finalProject.eduWorks.addressBook.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.finalProject.eduWorks.addressBook.model.service.AddressServiceImpl;
import com.finalProject.eduWorks.addressBook.model.vo.Address;
import com.finalProject.eduWorks.addressBook.model.vo.AddressOut;
import com.finalProject.eduWorks.common.model.vo.PageInfo;
import com.finalProject.eduWorks.common.template.Pagination;
import com.finalProject.eduWorks.member.model.vo.Member;

@Controller
public class AddressController {
	
	@Autowired
	private AddressServiceImpl aService;
	
	/**
	 * 1. 공용 주소록 페이지 이동
	 * @return : 공용 주소록 페이지
	 */
	@RequestMapping("publicAddress.ad")
	public ModelAndView publicAddressList(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv) {
		
		// 공용 주소록 전체 갯수 조회
		int listCount = aService.selectListCount();
		
		PageInfo pi = Pagination.getInfo(listCount, currentPage, 10, 10);
		
		// 공용 주소록 목록 조회
		ArrayList<Member> list = aService.selectAddressList(pi);
		
		mv.addObject("pi", pi);
		mv.addObject("list", list);
				
		mv.setViewName("addressBook/publicAddressBook");
		
		return mv;
		
	}
	
	/**
	 * 2. 개인 주소록 페이지 이동 (개인주소록 첫 페이지)
	 * @return : 개인 주소록 페이지
	 */
	@RequestMapping("individualAddress.ad")
	public ModelAndView individualAddressBook(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv, String memNo, HttpSession session) {
		
		// 로그인 세션! (삭제하기!)
		Member loginUser = new Member("500001", "user02", "pass02", "황재범", "D1", "J3", "010-2222-2223", "2222-2223", "aaaa1112@gmail.com", "1997-01-06", 111111, "111111", "상세주소2", "참고항목2", "2022-08-02", "2022-08-02", "N", "file");
	    session.setAttribute("loginUserN", loginUser);
		
		
		// 개인 주소록 기본('개인주소록') 번호 조회
		String basicAddNum = String.valueOf(aService.basicAddressNum(memNo));

		// 개인 주소록 기본 연락처 목록 조회
		Address a = new Address();
		a.setMemNo(memNo);
		a.setAddNo(basicAddNum);
		
		// 개인 기본 주소록에 들어가는 사람 수 조회
		int selectAddBasicCount = aService.selectAddBasicCount(a);

		// 페이징
		PageInfo pi = Pagination.getInfo(selectAddBasicCount, currentPage, 10, 10);
		
		ArrayList<Address> list = aService.selectAddIndivList(pi, a);
		
		// 개인 주소록 카테고리 목록 조회
		ArrayList<AddressOut> category = aService.selectAddCategory(a);
		
		mv.addObject("pi", pi);
		mv.addObject("list", list);
		mv.addObject("category", category);
		
		mv.setViewName("addressBook/individualAddressBook");
		
		return mv;
		
	}
		
	/**
	 * 3. 개인 주소록 그룹 추가
	 * @param ado : 로그인한 회원 번호, 추가하고자하는 그룹 명
	 * @return : 그룹 추가 성공 여부가 담긴 int형 변수 (성공 : 1 : 실패 : 0)
	 */
	@ResponseBody
	@RequestMapping("insertAddIndiv.ad")
	public String ajaxInsertAddIndiv(AddressOut ado) {
		
		int result = aService.ajaxInsertAddIndiv(ado);
		
		return result > 0 ? "success" : "fail";
		
	}
	
	@RequestMapping("indivAddressBook.ad")
	public ModelAndView individualAddressBook(@RequestParam(value="cpage", defaultValue="1") int currentPage, ModelAndView mv, Address a) {
		
		// 해당 개인주소록에 등록된 연락처 수 조회
		int listCount = aService.selectIndivNumCount(a);
		
		// 페이징
		PageInfo pi = Pagination.getInfo(listCount, currentPage, 10, 10);
		
		// 해당 개인주소록에 등록된 연락처 목록 조회
		ArrayList<Address> list = aService.selectAddIndivList(pi, a);
		
		// 개인 주소록 카테고리 목록 조회
		ArrayList<AddressOut> category = aService.selectAddCategory(a);
		
		mv.addObject("pi", pi);
		mv.addObject("list", list);
		mv.addObject("category", category);
		
		mv.setViewName("addressBook/indivAddressBookDetail");
		
		return mv;
		
	}
	
//	@RequestMapping("insertAddIndivNum.ad")
//	public String insertAddIndivNum(Address a) {
//		
//		int result = aService.insertAddIndivNum(a);
//
//		
//	}

}
