package more.eat.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import more.walk.model.WalkDTO;

@Service
public class EatDAOImple implements EatDAO {
	
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public boolean eatInsert(EatDTO dto) {
		
		int result = sqlMap.insert("insertEat", dto);
	
		return result>0? true:false;
	}
	
	public List<EatDTO> getStats(String pet_idx, int cp, String type, String date) {
		
		int listSize = 5;
		int startnum = listSize*(cp-1)+1;
		int endnum = listSize*cp;
		
		System.out.println("함보자"+pet_idx+"/"+cp+""+type+""+date);
		
		if(type.equals("date")) {
			date = "TO_CHAR(eat_time,'YYYYMMDD') = '"+date+"'";
		}else if(type.equals("month")) {
			date = "TO_CHAR(eat_time,'YYYYMM') = '"+date+"'";
		}else if(type.equals("week")) {
			date = "TO_CHAR(eat_time,'YYYYMMDD') >= '"+date+"' and TO_CHAR(eat_time,'YYYYMMDD') <= '"+(Integer.parseInt(date)+6)+"'";
		}
		
		Map map = new HashMap<String, Integer>();
		map.put("pet_idx", pet_idx);
		map.put("startnum", startnum);
		map.put("endnum", endnum);
		map.put("date", date);
		
		
		List<EatDTO> list = sqlMap.selectList("selectEatStat", map);
		
		return list;
	}
	
	public List<Map<String,String>> getTotalStats(String date, String pet_idx) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("date", date);
		map.put("pet_idx", pet_idx);
		
		List<Map<String,String>> list = sqlMap.selectList("selectTotalEatStat", map);
		return list;
	}
	
	public List<Map<String,String>> getWeekChart(String date, String pet_idx){
		String start = date;
		String end = (Integer.parseInt(date)+6)+"";
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("start", start);
		map.put("end", end);
		map.put("pet_idx", pet_idx);
		
		List<Map<String,String>> list = sqlMap.selectList("selectWeekTotalEat", map);
		return list;
	}
	
}
