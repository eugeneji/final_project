package more.review.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.*;

@Service
public class ReviewDAOImple implements ReviewDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int insertReview(ReviewDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.insert("insertReview", dto);
	}
	
	public List reviewList(int cp, int listN) {
		
		Map map = new HashMap<String, Integer>();
		map.put("start", (cp-1)*listN+1);
		map.put("end", cp*listN);
		return sqlMap.selectList("reviewList", map);
	}
	
	public List sitterReview(int user_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("sitterReview", user_idx);
	}
	
}
