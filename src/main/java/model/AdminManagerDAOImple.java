package more.adminManager.model;

import java.util.*;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminManagerDAOImple implements AdminManagerDAO {

	//리모컨
		@Autowired
		private SqlSessionTemplate sqlMap;
						
		public SqlSessionTemplate getSqlMap() {
			return sqlMap;
		}

		public void setSqlMap(SqlSessionTemplate sqlMap) {
			this.sqlMap = sqlMap;
		}

		public List userManager(int cp, int ls) {
			int start=(cp-1)*ls+1;
			int end = cp*ls;
			Map map = new HashMap();
			map.put("start",start);
			map.put("end",end);
			List arr = sqlMap.selectList("userManager",map);
			return arr;
		}

		public int user_getTotalCnt() {
			int count = sqlMap.selectOne("user_getTotalCnt");
			return count==0?1:count;
		}

		public AdminManagerDTO userView(int user_idx) {
			AdminManagerDTO dto = sqlMap.selectOne("userView", user_idx);
			return dto;
		}

		public int userBen(int user_idx) {
			int count = sqlMap.update("userBen", user_idx);
			return count;
		}
		
		public int userBenCancel(int user_idx) {
			int count = sqlMap.update("userBenCancel", user_idx);
			return count;
		}
		
		public int bbsManager() {
			int count = sqlMap.selectOne("bbsManager");
			return count==0?1:count;
		}
}
