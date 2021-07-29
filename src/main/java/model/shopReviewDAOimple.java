package more.shopreview.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class shopReviewDAOimple implements shopReviewDAO {
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	
	public int insertReview(shopReviewDTO dto) {
		System.out.println("들어와??");
		int result = sqlMap.insert("insertShopReview", dto);
		String cate_code = sqlMap.selectOne("selectReviewCate", dto);
		dto.setCate_code(cate_code);
		System.out.println(dto.getReview_idx());
		System.out.println(dto.getStar_score());
		
		if(result>0) {
			result = sqlMap.insert("insertStar", dto);
		}
		
		return dto.getReview_idx();
	}

	public List<itemReviewListDTO> itemReviewList(Map map) {

		List<itemReviewListDTO> list = sqlMap.selectList("itemReviewList", map);
		return list;
	}

}
