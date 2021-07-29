package more.eat.model;

import java.util.List;
import java.util.Map;

public interface EatDAO {
	
	public boolean eatInsert(EatDTO dto);
	public List<EatDTO> getStats(String pet_idx, int cp, String type, String date);
	public List<Map<String,String>> getTotalStats(String date, String pet_idx);
	public List<Map<String,String>> getWeekChart(String date, String pet_idx);
}
