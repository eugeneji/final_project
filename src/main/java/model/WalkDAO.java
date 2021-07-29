package more.walk.model;

import java.util.List;
import java.util.Map;

public interface WalkDAO {
	
	public int saveWalk(WalkDTO dto);
	public List<WalkDTO> getStats(String pet_idx, int cp, String type, String date);
	public WalkDTO getTotalStats(String type, String date, String pet_idx);
	public List<Map<String, String>> getMonthHistory(String pet_idx, String date);
	public WalkDTO getWalkDetail(int walk_idx);
	public String getTodayWalkTime(String date, String pet_idx);
}
