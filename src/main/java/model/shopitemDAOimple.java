package more.shopitem.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import more.itemandcate.model.itemandcateDTO;

@Service
public class shopitemDAOimple implements shopitemDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int totalCount(Map map) {
		int count = sqlMap.selectOne("totalCount", map);
		return count;
	}

	
	
	
	public List selectitemList(Map map) {
		
		List list = sqlMap.selectList("selectListForAdmin", map);
		
		return list;
	}
	
	
	public shopitemDTO updateStock(int item_idx, int item_stock) {

		Map map = new HashMap();
		map.put("item_idx", item_idx);
		map.put("item_stock", item_stock);
		return sqlMap.selectOne("updateStock", map);
	}
	
	public int insertItem(shopitemDTO dto) {
		int count = sqlMap.insert("insertItem", dto);
		int item_idx= dto.getItem_idx();
		return item_idx;
	}
	public int updateImg(shopitemDTO dto) {
		int count = sqlMap.update("updateImg", dto);
		return count;
	}
	
	public int updateItem(shopitemDTO dto) {
		
		int count = sqlMap.update("updateItem", dto);
		return count;
	}
	
	public int controllTF(Map map) {
		int count = sqlMap.update("controllTF", map);
		return count;
	}
	
	public itemandcateDTO selectItemDetail(int item_idx) {
		itemandcateDTO dto = sqlMap.selectOne("selectItemDetail", item_idx);
		return dto;
	}
	public List selectItemUserView(int cate_code) {
		
		List list = sqlMap.selectList("shopMainitem",cate_code);
		
		return list;
	}
}
