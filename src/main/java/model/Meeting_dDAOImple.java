package more.meeting_d.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import more.meeting_d.model.Meeting_dDTO;

@Service
public class Meeting_dDAOImple implements Meeting_dDAO {

	//리모컨
		@Autowired
		private SqlSessionTemplate sqlMap;
						
		public SqlSessionTemplate getSqlMap() {
			return sqlMap;
		}

		public void setSqlMap(SqlSessionTemplate sqlMap) {
			this.sqlMap = sqlMap;
		}
		
		
		public int meeting_d_add(Meeting_dDTO dto) {
			int count = sqlMap.update("meeting_d_add", dto);
			return count;
		}
		
}
