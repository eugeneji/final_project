package more.review.model;

import java.sql.*;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class ReviewDTO {
	
	private int review_idx;
	private int user_idx;
	private int book_idx;
	private String user_name;
	private int sitter_idx;
	private String review_content;
	private Date review_writedate;
	private String review_img;
	private int star;
	private MultipartFile[] uploads; 
	private String subject;
	private String sitter_name;
	private String sitter_addr;
	private String pet_name;
	
	public ReviewDTO() {
		super();
	}
	
	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getSitter_name() {
		return sitter_name;
	}
	public void setSitter_name(String sitter_name) {
		this.sitter_name = sitter_name;
	}
	public String getSitter_addr() {
		return sitter_addr;
	}
	public void setSitter_addr(String sitter_addr) {
		this.sitter_addr = sitter_addr;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getBook_idx() {
		return book_idx;
	}
	public void setBook_idx(int book_idx) {
		this.book_idx = book_idx;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public Date getReview_writedate() {
		return review_writedate;
	}
	public void setReview_writedate(Date review_writedate) {
		this.review_writedate = review_writedate;
	}
	public String getReview_img() {
		return review_img;
	}
	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}

	public MultipartFile[] getUploads() {
		return uploads;
	}

	public void setUploads(MultipartFile[] uploads) {
		this.uploads = uploads;
	}
	
	public int getStar() {
		return star;
	}

	public void setStar(int star) {
		this.star = star;
	}

	public int getSitter_idx() {
		return sitter_idx;
	}

	public void setSitter_idx(int sitter_idx) {
		this.sitter_idx = sitter_idx;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	@Override
	public String toString() {
		return "ReviewDTO [review_idx=" + review_idx + ", user_idx=" + user_idx + ", book_idx=" + book_idx
				+ ", user_name=" + user_name + ", sitter_idx=" + sitter_idx + ", review_content=" + review_content
				+ ", review_writedate=" + review_writedate + ", review_img=" + review_img + ", star=" + star
				+ ", uploads=" + Arrays.toString(uploads) + ", subject=" + subject + ", sitter_name=" + sitter_name
				+ ", sitter_addr=" + sitter_addr + ", pet_name=" + pet_name + "]";
	}

	
}
