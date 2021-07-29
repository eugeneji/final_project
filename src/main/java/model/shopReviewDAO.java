package more.shopreview.model;

import java.util.List;
import java.util.Map;

public interface shopReviewDAO {
	
	public int insertReview(shopReviewDTO dto);
	public List<itemReviewListDTO> itemReviewList(Map map);
}
