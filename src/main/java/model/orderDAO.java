package more.order.model;

import java.util.List;
import java.util.Map;

public interface orderDAO {

	public int insertOrderMaster(orderDTO dto);
	public int insertOrderDetail(Map map);
	public List<userOrderListDTO> selectOrderList(Map<String, String> map);
	public int updateOrder(Map map);
	public List<reviewOrderDTO> selectOrderItem(Map map);
}
