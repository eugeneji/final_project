package more.meeting_m.model;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


@Service
public class Meeting_mDAOImple implements Meeting_mDAO {

	//리모컨
	@Autowired
	private SqlSessionTemplate sqlMap;
					
	public SqlSessionTemplate getSqlMap() {
		return sqlMap;
	}

	public void setSqlMap(SqlSessionTemplate sqlMap) {
		this.sqlMap = sqlMap;
	}
	
	public List meeting_m_bbsList(int cp, int ls, int user_idx) {
		int idx = user_idx;
		int start=(cp-1)*ls+1;
		int end = cp*ls;
//		HashMap map =new HashMap();
		Map map =new HashMap();
		map.put("start",start);
		map.put("end",end);
		map.put("idx",idx);
		List arr = sqlMap.selectList("meeting_m_bbsList",map);
		return arr;
	}
	
	public List meeting_m_bbsList_my(int cp, int ls, int user_idx) {
		int idx = user_idx;
		int start=(cp-1)*ls+1;
		int end = cp*ls;
//		HashMap map =new HashMap();
		Map map =new HashMap();
		map.put("start",start);
		map.put("end",end);
		map.put("idx",idx);
		List arr_my = sqlMap.selectList("meeting_m_bbsList_my",map);
		return arr_my;
	}

	public int meeting_m_getTotalCnt() {
		int count = sqlMap.selectOne("meeting_m_getTotalCnt");
		return count==0?1:count; // 데이터베이스에서 반환되는 값을 dao단에서 조작해줌.
	}
	
	public int meeting_m_count(int meeting_m_idx) {
		int idx = meeting_m_idx;
		int count = sqlMap.selectOne("meeting_m_count", idx);
		return count;
	}

	public Meeting_mDTO before_m_add(int user_idx) {
		Meeting_mDTO dto = sqlMap.selectOne("before_m_add", user_idx);
		return dto;
	}

	public int meeting_m_addContent(Meeting_mDTO dto) {
		int count = sqlMap.insert("meeting_m_addContent", dto);
		
		return dto.getMeeting_m_idx();
	}

	public Meeting_mDTO meeting_m_content(int meeting_m_idx) {
		Meeting_mDTO  dto = sqlMap.selectOne("meeting_m_content", meeting_m_idx);
		return dto;
	}

	public List meeting_j(int meeting_m_idx) {
		
		int idx = meeting_m_idx;
		Map map =new HashMap();
		map.put("idx",idx);
		List list_j = sqlMap.selectList("meeting_j",map);
		return list_j;
	}
	
	public Meeting_mDTO meeting_j_my(int meeting_m_idx, int user_idx) {
		
		int m_idx = meeting_m_idx;
		int u_idx = user_idx;
		Map map =new HashMap();
		map.put("m_idx",m_idx);
		map.put("u_idx",u_idx);
		Meeting_mDTO  dto = sqlMap.selectOne("meeting_j_my",map);
		return dto;
	}

	public int yes(int user_idx,int meeting_m_idx) {
		int u_idx = user_idx;
		int m_idx = meeting_m_idx;
		Map map =new HashMap();
		map.put("u_idx",u_idx);
		map.put("m_idx",m_idx);
		int count = sqlMap.update("yes", map);
		return count;
	}

	public int no(Meeting_mDTO dto) {
		int count = sqlMap.delete("no", dto);
		return count;
	}
	
	public List meeting_allList(int cp, int ls) {
		int start=(cp-1)*ls+1;
		int end = cp*ls;
//		HashMap map =new HashMap();
		Map map =new HashMap();
		map.put("start",start);
		map.put("end",end);
		List arr = sqlMap.selectList("meeting_allList",map);
		return arr;
	}

	public int meeting_m_push(int meeting_m_idx, int user_idx) {
		int m_idx = meeting_m_idx;
		int u_idx = user_idx;
		Map map =new HashMap();
		map.put("m_idx",m_idx);
		map.put("u_idx",u_idx);
		int count = sqlMap.insert("meeting_m_push", map);
		return count;
	}
	
	public List meeting_d_list(int meeting_m_idx) {
		int idx = meeting_m_idx;
//		HashMap map =new HashMap();
		Map map =new HashMap();
		map.put("idx",idx);
		List arr = sqlMap.selectList("meeting_d_list",map);
		return arr;
	}
	
	public int meeting_d_count(int meeting_m_idx) {
		int idx = meeting_m_idx;
		int count = sqlMap.selectOne("meeting_d_count", idx);
		return count;
	}
	
	public int meeting_d_del(Meeting_mDTO dto) {
		int count = sqlMap.delete("meeting_d_del", dto);
		return count;
	}
	
	public int meeting_d_update(Meeting_mDTO dto) {
		int count = sqlMap.update("meeting_d_update", dto);
		return count;
	}
	
	public int getRoomIdx(int meeting_m_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectOne("getRoomIdx", meeting_m_idx);
	}
}
