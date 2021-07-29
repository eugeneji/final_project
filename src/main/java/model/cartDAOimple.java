package more.cart.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class cartDAOimple implements cartDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int insertCart(Map map) {
		
		
		Integer cart_idx = sqlMap.selectOne("selectUserCart", map);
		int result;

		if(cart_idx==null||cart_idx<1) {
			result = sqlMap.insert("insertCart", map);
		}else {
			map.put("cart_idx", cart_idx);
			result = sqlMap.update("updateCartUnit", map);
		}
		
		
		return result;
	}
	
	public List<showCartDTO> showCartList(Map<String, Integer> map) {
		List<showCartDTO> list= sqlMap.selectList("showCartList", map);
		
		return list;
	}
	
	public int deleteCartList(ArrayList<Integer> list) {
			
		int result = sqlMap.delete("deleteCartList", list);
		System.out.println("dao : "+result);
		return result;
	}
	
	public int updateCartUnit(Map<String, Integer> map) {
		
		int result = sqlMap.update("updateUnit", map);
			
		return result;
	}
	
	public List<showCartDTO> showPaymentCarts(Map map) {
		List<showCartDTO> cartList = sqlMap.selectList("selectPaymentForm", map);
		return cartList;
	}

}
