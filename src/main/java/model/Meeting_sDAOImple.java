package more.meeting_s.model;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonFormat;

@Service
public class Meeting_sDAOImple implements Meeting_sDAO {

	//리모컨
	@Autowired
	private SqlSessionTemplate sqlMap;
		
	public SqlSessionTemplate getSqlMap() {
		return sqlMap;
	}

	public void setSqlMap(SqlSessionTemplate sqlMap) {
		this.sqlMap = sqlMap;
	}
	
	public List meeting_s_bbsList(int cp, int ls) {
		int start=(cp-1)*ls+1;
		int end = cp*ls;
//		HashMap map =new HashMap();
		Map map =new HashMap();
		map.put("start",start);
		map.put("end",end);
		List arr = sqlMap.selectList("meeting_s_bbsList",map);
		return arr;
	}

	public int meeting_s_getTotalCnt() {
		int count = sqlMap.selectOne("meeting_s_bbsTotalCnt");
		return count==0?1:count; // 데이터베이스에서 반환되는 값을 dao단에서 조작해줌.
	}
	
	public Meeting_sDTO joinContent(int meeting_s_idx) {
		Meeting_sDTO dto = sqlMap.selectOne("joinContent", meeting_s_idx);
		return dto;
	}

	public int meeting_s_write_add(Meeting_sDTO dto) {
		int count = sqlMap.insert("meeting_s_write_add", dto);
		return count;
	}

	public int meeting_s_contentDel(int meeting_s_idx) {
		int count = sqlMap.delete("meeting_s_contentDel", meeting_s_idx);
		return count;
	}

	public int meeting_s_update(Meeting_sDTO dto) {
		int count = sqlMap.update("meeting_s_update", dto);
		return count;
	}

}
