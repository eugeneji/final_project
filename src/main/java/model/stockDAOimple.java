package more.stock.model;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class stockDAOimple implements stockDAO {
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int insertStock(stockDTO dto) {
		
		return sqlMap.insert("insertStock", dto);
		
	}

}
