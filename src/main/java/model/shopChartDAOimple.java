package more.chart.model;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class shopChartDAOimple implements shopChartDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public List<shopChartDTO> defaultChart() {

		List<shopChartDTO> list =  sqlMap.selectList("selectDefault");
		return list;
	}
	
	public List<periodChartDTO> periodChart() {
		
		List<periodChartDTO> list = sqlMap.selectList("periodChart");
		return list;
	}
	
public Map<String, Object> totalGraph() {
	
		Map<String, Object> map = new HashMap<String, Object>();
		bestUserChartDTO bestuserdto = sqlMap.selectOne("bestUser");
		totalChartDTO totalchartdto = sqlMap.selectOne("totalChart");
		map.put("bestUser", bestuserdto);
		map.put("totalChart", totalchartdto);
	return map;
}

public List<areaChartDTO> areaChart() {
List<areaChartDTO> list = sqlMap.selectList("areaChart");
	
	return list;
}
}
