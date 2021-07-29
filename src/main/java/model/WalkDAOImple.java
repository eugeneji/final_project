package more.walk.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WalkDAOImple implements WalkDAO {
	
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	
	public int saveWalk(WalkDTO dto) {
		
		int result = sqlMap.insert("insertWalk", dto);
		return dto.getWalk_idx();
	}
	
	public List<WalkDTO> getStats(String pet_idx, int cp, String type, String date) {
		
		int listSize = 5;
		int startnum = listSize*(cp-1)+1;
		int endnum = listSize*cp;
		
		if(type.equals("date")) {
			date = "TO_CHAR(walk_starttime,'YYYYMMDD') = '"+date+"'";
		}else if(type.equals("month")) {
			date = "TO_CHAR(walk_starttime,'YYYYMM') = '"+date+"'";
		}else if(type.equals("week")) {
			date = "TO_CHAR(walk_starttime,'YYYYMMDD') >= '"+date+"' and TO_CHAR(walk_starttime,'YYYYMMDD') <= '"+(Integer.parseInt(date)+6)+"'";
		}
		
		Map map = new HashMap<String, Integer>();
		map.put("pet_idx", pet_idx);
		map.put("startnum", startnum);
		map.put("endnum", endnum);
		map.put("date", date);
		
		
		List<WalkDTO> list = sqlMap.selectList("selectWalkStat", map);
		
		return list;
	}
	
	public WalkDTO getTotalStats(String type, String date, String pet_idx) {
		Map<String, String> map = new HashMap<String, String>();
		
		if(type.equals("date")) {
			date = "TO_CHAR(walk_starttime,'YYYYMMDD') = '"+date+"'";
		}else if(type.equals("month")) {
			date = "TO_CHAR(walk_starttime,'YYYYMM') = '"+date+"'";
		}else if(type.equals("week")) {
			date = "TO_CHAR(walk_starttime,'YYYYMMDD') >= '"+date+"' and TO_CHAR(walk_starttime,'YYYYMMDD') <= '"+(Integer.parseInt(date)+6)+"'";
		}
		map.put("walk_date", date);
		map.put("pet_idx", pet_idx);
		WalkDTO dto = sqlMap.selectOne("selectWalkTotalStat", map);
		return dto;
	}
	
	public List<Map<String, String>> getMonthHistory(String pet_idx, String date){
		Map<String, String> map = new HashMap<String, String>();
		map.put("pet_idx", pet_idx);
		map.put("date", date);
		
		List<Map<String, String>> list = sqlMap.selectList("selectWalkMonthHistory", map);
		
		return list;
	}
	
	public WalkDTO getWalkDetail(int walk_idx) {
		WalkDTO dto = sqlMap.selectOne("selectWalkDetail", walk_idx);
		return dto;
	}
	
	public String getTodayWalkTime(String date, String pet_idx) {
		Map<String,String> param = new HashMap<String, String>();
		param.put("date", date);
		param.put("pet_idx", pet_idx);
		String result = sqlMap.selectOne("selectTodayWalkTime", param);
		return result;
	}
}
