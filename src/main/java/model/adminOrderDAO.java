package more.order.model;

import java.util.List;
import java.util.Map;

public interface adminOrderDAO {

	
	public int totalCnt(Map map);
	public List<adminOrderDTO> orderListAdmin(Map map);
	public int orderUpdate(Map map);
	public orderDTO orderMaster(Map map);
	public List<orderItemDTO> orderDetail(Map map);
	public int findIdx(String user_email);
}
