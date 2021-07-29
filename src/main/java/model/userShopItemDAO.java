package more.shopitem.model;

import java.util.List;
import java.util.Map;

import more.cart.model.wishDTO;
import more.itemandcate.model.itemandcateDTO;
import more.usershopitem.model.userShopItemDTO;

public interface userShopItemDAO {
	public userShopItemDTO selectItemDetail(int item_idx);
	public List selectItemUserView(int cate_code);
	public List itemList(Map map);
	public List<shopitemDTO> lastList(List<String> list); 
	public int insertWish(Map map);
	public boolean insertWishInDetail(Map map);
	public int deleteWish(Map map);
	public List<wishDTO> selectWishList(Map map);
}
