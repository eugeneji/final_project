package more.shopitem.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import more.cart.model.wishDTO;
import more.itemandcate.model.itemandcateDTO;
import more.usershopitem.model.userShopItemDTO;
@Service
public class userShopItemDAOimple implements userShopItemDAO {
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	
	public userShopItemDTO selectItemDetail(int item_idx) {
		userShopItemDTO dto = sqlMap.selectOne("itemDetailForUser", item_idx);
		return dto;
	}
	public List selectItemUserView(int cate_code) {

		List list = sqlMap.selectList("shopMainitem",cate_code);

		return list;
	}
	
	public List itemList(Map map) {

List list = sqlMap.selectList("itemListForUser", map);
		
		return list;
	}
public List<shopitemDTO> lastList(List<String> list) {
		
		List<Integer> inList =  new ArrayList<Integer>();
		
		for(int i = 0; i<list.size();i++) {
			inList.add(Integer.parseInt(list.get(i)));
		}
		List<shopitemDTO> lastList = sqlMap.selectList("lastList", inList);
		return lastList;
	}

public int insertWish(Map map) {
	int result = sqlMap.insert("insertWish", map);
	return result;
}

public boolean insertWishInDetail(Map map) {
	
	return sqlMap.selectOne("checkWish", map)!=null?true:false;
}

public int deleteWish(Map map) {
	int result = sqlMap.delete("deleteWish", map);
	return result;
}

public List<wishDTO> selectWishList(Map map) {
	
	return sqlMap.selectList("wishList", map);
}
}
