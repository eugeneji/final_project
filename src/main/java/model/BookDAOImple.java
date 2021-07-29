package more.book.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import more.sitter.model.SitterDTO;

@Service
public class BookDAOImple implements BookDAO {

	@Autowired
	private SqlSessionTemplate sqlMap;
	
	public int bookApply(BookDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.insert("bookApply", dto);
	}
	
	public List bookList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("bookList", map);
	}
	public List bookSitterList(Map<String, String> map) {
		// TODO Auto-generated method stub
		return sqlMap.selectList("bookSitterList",map);
	}
	
	public BookDTO showDetail(int book_idx) {
		// TODO Auto-generated method stub
		return sqlMap.selectOne("showDetail", book_idx);
	}
	
	public int cardSave(int user_idx) {
		// TODO Auto-generated method stub
		return sqlMap.insert("cardSave", user_idx);
	}
	
	public int bookUpdate(BookDTO dto) {
		// TODO Auto-generated method stub
		return sqlMap.update("bookUpdate", dto);
	}
}
