package spring.trip.model.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import spring.trip.domain.Order;
import spring.trip.model.dao.OrderDAO;

@Repository
public class OrderDAOImpl implements OrderDAO{
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int orderBook(Order vo) {
		int row = sqlSession.insert("orderMapper.orderBook", vo);
		System.out.println(row+" 주문을 생성하였습니다.");
		return row;
	}

	@Override
	public Order showOrderInfo(int orderNo) {
		Order rvo = sqlSession.selectOne("orderMapper.showOrderInfo", orderNo);
		System.out.println(rvo);
		return rvo;
	}

	@Override
	public List<Order> getOrderListOfMember(String email) {
		List<Order> list = sqlSession.selectList("orderMapper.getOrderListOfMember", email);
		System.out.println(list);
		return list;
	}

	@Override
	public int cancelOrder(int orderNo) {
		int row = sqlSession.delete("orderMapper.cancelOrder", orderNo);
		System.out.println(row+" 주문을 취소하였습니다.");
		return row;
	}
}




