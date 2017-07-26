package spring.trip.model.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.trip.domain.Order;
import spring.trip.model.dao.OrderDAO;
import spring.trip.model.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDAO orderDAO;
	
	@Override
	public int orderBook(Order vo) throws Exception {
		return orderDAO.orderBook(vo);
	}

	@Override
	public Order showOrderInfo(int orderNo) throws Exception {
		return orderDAO.showOrderInfo(orderNo);
	}

	@Override
	public List<Order> getOrderListOfMember(String email) throws Exception {
		return orderDAO.getOrderListOfMember(email);
	}

	@Override
	public int cancelOrder(int orderNo) throws Exception {
		return orderDAO.cancelOrder(orderNo);
	}

}
