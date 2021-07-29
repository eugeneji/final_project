package more.cart.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface cartDAO {
	public int insertCart(Map map);
	public List<showCartDTO> showCartList(Map<String, Integer> map);
	public int deleteCartList(ArrayList<Integer> list);
	public int updateCartUnit(Map<String, Integer> map);
	public List<showCartDTO> showPaymentCarts(Map map);
}
