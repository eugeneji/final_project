package more.sitter.model;

import java.util.*;

public interface SitterDAO {

	public int acceptTotalCnt();
	public List sitterList();
	public SitterDTO sitterProfile(int user_idx);
	public List reviewList();
	public int sitterApply(SitterDTO sdto);
	public List adminSitterAcceptAllList(int cp, int list);
	public SitterDTO applyContent(int apply_idx);
	public int insertSitter(SitterDTO dto);
	public int isProfile(String user_idx);
	public int insertProfile(SitterDTO dto);
	public SitterDTO selectProfile(int user_idx);
	public int deleteProfile(int user_idx);
	
}
