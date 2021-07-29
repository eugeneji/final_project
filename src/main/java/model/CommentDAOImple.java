package more.comment.model;

import java.util.*;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CommentDAOImple implements CommentDAO {
	
	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int reportReBbsWrite(CommentDTO dto) {
		int count=sqlMap.insert("reportReBbsWrite", dto);
		return count;
	}
	
	public List commentList(int bbs_idx) {
		List list = sqlMap.selectList("commentList",bbs_idx);
		return list;
	}
	
}
