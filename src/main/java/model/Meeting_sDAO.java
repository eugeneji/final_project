package more.meeting_s.model;

import java.util.*;

public interface Meeting_sDAO {
	
	public List meeting_s_bbsList(int cp,int ls);
	public int meeting_s_getTotalCnt();
	public Meeting_sDTO joinContent(int meeting_s_idx);
	public int meeting_s_write_add(Meeting_sDTO dto);
	public int meeting_s_contentDel(int meeting_s_idx);
	public int meeting_s_update(Meeting_sDTO dto);
}
