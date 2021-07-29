package more.bbs.model;

import java.util.*;
public interface BbsDAO {

	public int reportBbsWrite(BbsDTO dto);
	public List reportBbsList(int cp, int ls);
	public BbsDTO reportBbsContent(int bbs_idx);
	public int reportBbsEdit(BbsDTO dto);
	public int reportBbsDel(int bbs_idx);
	public int getTotalCnt(int bbs_category);
	public int findBbsWrite(BbsDTO dto);
	public List findBbsList(int cp, int ls);
	public BbsDTO findBbsContent(int bbs_idx);
	public int findBbsEdit(BbsDTO dto);
	public int findBbsDel(int bbs_idx);
	public int reportBbsReadnum(int bbs_idx);
	public int findBbsReadnum(int bbs_idx);
}
