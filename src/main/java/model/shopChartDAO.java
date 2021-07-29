package more.chart.model;

import java.util.List;
import java.util.Map;

public interface shopChartDAO {

	
	public List<shopChartDTO> defaultChart();
	public List<periodChartDTO> periodChart();
	public List<areaChartDTO> areaChart();
	public Map<String, Object> totalGraph();
}
