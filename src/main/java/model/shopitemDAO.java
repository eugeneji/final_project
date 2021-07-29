package more.shopitem.model;

import java.util.List;
import java.util.Map;

import more.itemandcate.model.itemandcateDTO;

public interface shopitemDAO {

	public int totalCount(Map map);
	public List selectitemList(Map map);
	public shopitemDTO updateStock(int item_idx,int item_stock);
	public int insertItem(shopitemDTO dto);
	public int updateImg(shopitemDTO dto);
	public int updateItem(shopitemDTO dto);
	public int controllTF(Map map);
	public itemandcateDTO selectItemDetail(int item_idx);
	public List selectItemUserView(int cate_code);
}
