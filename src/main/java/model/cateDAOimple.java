package more.cate.model;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class cateDAOimple implements cateDao {
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public List loadCategory() throws Exception {
		List list = sqlMap.selectList("shopcate");
		return list;
	}

}
