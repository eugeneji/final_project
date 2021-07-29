package more.comment.model;

import java.util.*;
public interface CommentDAO {

	public int reportReBbsWrite(CommentDTO dto);
	public List commentList(int bbs_idx);
}
