package com.itbank.joe;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ReviewController {

	@Autowired
	ReviewDAO dao;
	
	@RequestMapping("review")
	public void review(ReviewDTO reviewDTO , Model model) {
		
		dao.insert(reviewDTO);
		List<ReviewDTO> list = dao.selectAll();
		model.addAttribute("list", list);
	}
	
	
	@RequestMapping("reviewAll")
	public String reviewAll( Model model) {
		
		List<ReviewDTO> list = dao.selectAll();
		model.addAttribute("list", list);
		
		return "review";
	}
	
	@RequestMapping("review2")
	public String reviewReview(@RequestParam("input") String bnum,ReviewDTO reviewDTO,Model model) {
		
	System.out.println("컨트롤러왔다");
		
		ReviewDTO dto = dao.select(Integer.parseInt(bnum));
		
		reviewDTO.setParents(dto.getParents());
		reviewDTO.setDepth(dto.getDepth()+1);
		reviewDTO.setBorder(dao.borderSelect(dto));
		
		System.out.println("순서"+dao.borderSelect(dto));
		
		dao.insertInsert(reviewDTO);
		
		List<ReviewDTO> list = dao.selectAll();
		model.addAttribute("list", list);
		
		return "review";
	}
	
	
	@RequestMapping("reviewUpdate")
	public String reviewUpdate(@RequestParam("input2") String bnum ,@RequestParam("content") String content,Model model ) {
		
		ReviewDTO dto = new ReviewDTO();
		System.out.println("번호 : "+bnum);
		System.out.println("내용 : "+content);
		dto.setBnum(Integer.parseInt(bnum));
		dto.setContent(content);
		
		dao.update(dto);
		
		List<ReviewDTO> list = dao.selectAll();
		model.addAttribute("list", list);
		
		return "review";
		
	}
	
	@RequestMapping("reviewDelete")
	public String reviewDelete(@RequestParam("bnum") String bnum,@RequestParam("parents") String parents,Model model) {
		
		ReviewDTO dto = new ReviewDTO();
		dto.setParents(parents);
		dto.setBnum(Integer.parseInt(bnum));
		
		
		if (dao.selectParents(parents).size() >1) {
			dao.delete(dto);
		}else{
			dao.deleteOne(Integer.parseInt(bnum));
		}
		
		List<ReviewDTO> list = dao.selectAll();
		model.addAttribute("list", list);
		
		
		return "review";
	}
	
	
	
	
	
	
	
	
	
}
