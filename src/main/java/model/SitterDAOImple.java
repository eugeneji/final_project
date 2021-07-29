package more.sitter.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SitterDAOImple implements SitterDAO {
	
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	
	public List sitterList() {
		List list = sqlMap.selectList("sitterList");
		return list;
	}
	
	public SitterDTO sitterProfile(int user_idx) {
		return sqlMap.selectOne("sitterProfile", user_idx);
	}
	
	public List reviewList() {
		// TODO Auto-generated method stub
		return null;
	}
	
	public int sitterApply(SitterDTO sdto) {
		
		return sqlMap.insert("sitterApply", sdto);
	}
	
	public int acceptTotalCnt() {
		int totalCnt=sqlMap.selectOne("acceptTotalCnt");
		return totalCnt==0?1:totalCnt;
	}
	
	public List adminSitterAcceptAllList(int cp, int list) {
		Map map = new HashMap<String, Integer>();
		map.put("start", (cp-1)*list+1);
		map.put("end", cp*list);
		return sqlMap.selectList("adminSitterAcceptAllList", map);
	}
	
	public SitterDTO applyContent(int apply_idx) {
		return sqlMap.selectOne("applyContent", apply_idx);
	}
	
	public int insertSitter(SitterDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.update("insertSitter", dto);
	}
	
	public int isProfile(String user_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectOne("isProfile", user_idx);
	}
	
	public int insertProfile(SitterDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.insert("insertProfile", dto);
	}
	
	public SitterDTO selectProfile(int user_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectOne("selectProfile", user_idx);
	}
	
	public int deleteProfile(int user_idx) {
		// TODO Auto-generated method stub
		return sqlMap.delete("deleteProfile", user_idx);
	}
}
