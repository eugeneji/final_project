package more.meeting_m.model;

import java.util.*;

import more.meeting_m.model.Meeting_mDTO;

public interface Meeting_mDAO {

	public List meeting_m_bbsList(int cp, int ls, int user_idx);
	public List meeting_m_bbsList_my(int cp, int ls, int user_idx);
	public int meeting_m_getTotalCnt();
	public int meeting_m_count(int meeting_m_idx);
	public Meeting_mDTO before_m_add(int user_idx);
	public int meeting_m_addContent(Meeting_mDTO dto);
	public Meeting_mDTO meeting_m_content(int meeting_m_idx);
	public List meeting_j(int meeting_m_idx);
	public int yes(int user_idx,int meeting_m_idx);
	public int no(Meeting_mDTO dto);
	public List meeting_allList(int cp, int ls);
	public int meeting_m_push(int meeting_m_idx, int user_idx);
	public Meeting_mDTO meeting_j_my(int meeting_m_idx, int user_idx);
	public List meeting_d_list(int meeting_m_idx);
	public int meeting_d_count(int meeting_m_idx);
	public int meeting_d_del(Meeting_mDTO dto);
	public int meeting_d_update(Meeting_mDTO dto);
	public int getRoomIdx(int meeting_m_idx);
	
}