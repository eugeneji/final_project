package more.order.model;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class adminOrderDAOimple implements adminOrderDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int totalCnt(Map map) {
		
		int result = sqlMap.selectOne("orderTotalCnt", map); 
		return result;
	}

	public List<adminOrderDTO> orderListAdmin(Map map) {

		List<adminOrderDTO> list = sqlMap.selectList("adminOrderList", map);
		return list;
	}
	public int orderUpdate(Map map) {

		int result = sqlMap.update("updateOrderStateAdmin", map);
		int count;
		if(map.get("order_state").equals("배송시작")) {
			Map<String, Object> updateMap = null;
			ArrayList<Integer> idxs = (ArrayList<Integer>) map.get("idxList");
			ArrayList<Integer> units = (ArrayList<Integer>) map.get("unitList");
			ArrayList<Integer> prices = (ArrayList<Integer>) map.get("priceList");
			for(int i = 0; i<idxs.size();i++) {
				updateMap = new HashMap<String, Object>();
				updateMap.put("item_idx", idxs.get(i));
				updateMap.put("detail_unit", units.get(i));
				updateMap.put("item_price", prices.get(i));
				updateMap.put("stock_type", "out");
				updateMap.put("stock_cause", "판매");
				count = sqlMap.update("updateToSell", updateMap);
				if(count==0) {
					return 0;
				}
				count = sqlMap.update("insertStockcauseOrder", updateMap);
			}
			
		}
		return result;
	}
	
	public orderDTO orderMaster(Map map) {
		orderDTO dto = sqlMap.selectOne("orderMaster", map);
		return dto;
	}
	
	public List<orderItemDTO> orderDetail(Map map) {
		List<orderItemDTO> list = sqlMap.selectList("orderDetail", map);
		return list;
	}
	
	public int findIdx(String user_email) {

		
		return sqlMap.selectOne("findPwd", user_email);
	}
}
