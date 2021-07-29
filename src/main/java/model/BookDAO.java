package more.book.model;

import java.util.*;

import more.sitter.model.SitterDTO;

public interface BookDAO {

	public int bookApply(BookDTO dto);
	public List bookList(Map<String, String> map);
	public BookDTO showDetail(int book_idx);
	public int cardSave(int user_idx);
	public List bookSitterList(Map<String, String> map);
	public int bookUpdate(BookDTO dto);
	
}
