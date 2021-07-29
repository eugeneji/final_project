package more.book.model;

import java.sql.Date;

public class BookDTO {
	
	private int book_idx;
	private int user_idx;
	private int sitter_idx;
	private String book_from;
	private String book_to;
	private String pet_idx;
	private String book_req;
	private int book_price;
	private Date book_writedate;
	private int book_accept;
	private String subject;
	private String user_name;
	private String user_addr;
	public BookDTO() {
		super();
	}

	public int getBook_idx() {
		return book_idx;
	}

	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getSitter_idx() {
		return sitter_idx;
	}

	public void setSitter_idx(int sitter_idx) {
		this.sitter_idx = sitter_idx;
	}

	public String getBook_from() {
		return book_from;
	}

	public void setBook_from(String book_from) {
		this.book_from = book_from;
	}

	public String getBook_to() {
		return book_to;
	}

	public void setBook_to(String book_to) {
		this.book_to = book_to;
	}

	public String getPet_idx() {
		return pet_idx;
	}

	public void setPet_idx(String pet_idx) {
		this.pet_idx = pet_idx;
	}

	public String getBook_req() {
		return book_req;
	}

	public void setBook_req(String book_req) {
		this.book_req = book_req;
	}

	public int getBook_price() {
		return book_price;
	}

	public void setBook_price(int book_price) {
		this.book_price = book_price;
	}

	public Date getBook_writedate() {
		return book_writedate;
	}

	public void setBook_writedate(Date book_writedate) {
		this.book_writedate = book_writedate;
	}

	public int getBook_accept() {
		return book_accept;
	}

	public void setBook_accept(int book_accept) {
		this.book_accept = book_accept;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_addr() {
		return user_addr;
	}

	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	@Override
	public String toString() {
		return "BookDTO [book_idx=" + book_idx + ", user_idx=" + user_idx + ", sitter_idx=" + sitter_idx
				+ ", book_from=" + book_from + ", book_to=" + book_to + ", pet_idx=" + pet_idx + ", book_req="
				+ book_req + ", book_price=" + book_price + ", book_writedate=" + book_writedate + ", book_accept="
				+ book_accept + ", subject=" + subject + ", user_name=" + user_name + ", user_addr=" + user_addr + "]";
	}

	
	
}
