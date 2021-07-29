package more.order.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import more.cart.model.showCartDTO;


@Service
public class orderDAOimple implements orderDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int insertOrderMaster(orderDTO dto) {
		int count = sqlMap.insert("insertOrderMaster", dto);
		Integer order_idx = dto.getOrder_idx();
		return order_idx;
	}

	public int insertOrderDetail(Map map) {

		int order_idx = (Integer) map.get("order_idx");
		int item_idx;
		int cart_idx;
		int cart_unit;
		int result;
		int count = 0;
		ArrayList<showCartDTO> cartDTOs = (ArrayList<showCartDTO>) map.get("dtos");
		orderDetailDTO dto = null;
		
		for(int i=0;i<cartDTOs.size();i++) {
			item_idx = cartDTOs.get(i).getItem_idx();
			cart_idx = cartDTOs.get(i).getCart_idx();
			cart_unit = cartDTOs.get(i).getCart_unit();
			dto = new orderDetailDTO();
			dto.setOrder_idx(order_idx);
			dto.setItem_idx(item_idx);
			dto.setDetail_unit(cart_unit);
			result = sqlMap.insert("insertOrderDetail", dto);
			count = sqlMap.delete("puttedOrder", cart_idx);
		}
		
		return count;
	}

	
	public List<userOrderListDTO> selectOrderList(Map<String, String> map) {
		
		List<userOrderListDTO> list = sqlMap.selectList("selectOrderMaster", map);
		return list;
	}
	
	public int updateOrder(Map map) {
		
		int result = sqlMap.update("updateOrderState", map);
		return result;
	}
	public List<reviewOrderDTO> selectOrderItem(Map map) {
	List<reviewOrderDTO> list = sqlMap.selectList("selectReviewItem", map);
		return list;
	}
}
