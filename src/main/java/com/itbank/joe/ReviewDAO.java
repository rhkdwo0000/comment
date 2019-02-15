package com.itbank.joe;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository("dao")
public class ReviewDAO {

	@Autowired
	private SqlSession session;
	
	public void insert(ReviewDTO dto) {
		System.out.println(dto.getBnum());
		if (dto.getBnum() == 0) {
			if (dto.getParents() != null) {
				ReviewDTO dto2 = session.selectOne("review.pselect", dto.getParents());
				dto.setDepth(dto2.getDepth());
				dto.setBorder(dto2.getBorder()+1);
				session.selectOne("review.update", dto2);
			}else{
				System.out.println("넘어옴?");
				System.out.println(dto.getPid());
				int order = session.selectOne("review.selectMax", dto.getPid());
				
				System.out.println(order);
				dto.setBorder(order);
			}
			
			session.insert("review.insert",dto);
		}else {
			session.insert("review.insert",dto);
		}
	}
	
	
	public ReviewDTO select(int bnum) {
		return session.selectOne("review.select", bnum);
	}
	
	public List<ReviewDTO> selectParents(String parents) {
		return session.selectList("review.selectParents", parents);
	}
	
	
	
	
	public void insertInsert(ReviewDTO dto) {
		System.out.println("아이디"+dto.getPid());
		System.out.println("댓글번호"+dto.getBnum());
		System.out.println("순서"+dto.getBorder());
		System.out.println("깊이"+dto.getDepth());
		System.out.println("부모"+dto.getParents());
		System.out.println("내용"+dto.getContent());
		
		session.update("review.countUpdate",dto.getBorder());
		
		System.out.println("유주빈");
		
		session.insert("review.insertInsert", dto);
		
		System.out.println("조광재");
		
	}
	
	public int borderSelect(ReviewDTO dto) {
		return session.selectOne("review.borderSelect", dto);
	}
	
	public void update(ReviewDTO dto) {
		session.update("review.commentUpdate", dto);
	}
	
	
	public List<ReviewDTO> selectAll() {
		return session.selectList("review.selectAll");
	}
	
	
	public void delete(ReviewDTO dto) {
		session.delete("review.delete2", dto);
	}
	
	public void deleteOne(int bnum) {
		session.delete("review.delete1", bnum);
	}
	
	
	
}
