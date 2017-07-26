package spring.trip.model.dao;

import java.util.List;

import spring.trip.domain.Order;

public interface OrderDAO {
	public int orderBook(Order vo) throws Exception;
	public Order showOrderInfo(int orderNo) throws Exception;
	public List<Order> getOrderListOfMember(String email) throws Exception;
	public int cancelOrder(int orderNo) throws Exception;
}
