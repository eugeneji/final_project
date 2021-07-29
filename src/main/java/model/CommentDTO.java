package more.comment.model;

import java.sql.*;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CommentDTO {
	
	private int bbs_idx;
	private int user_idx;
	private int comment_ref;
	private String comment_content;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone="Asia/Seoul")
	private Date comment_writedate;
	private String comment_writer;
	
	public CommentDTO() {
		super();
	}

	public CommentDTO(int bbs_idx, int user_idx, int comment_ref, String comment_content, Date comment_writedate,
			String comment_writer) {
		super();
		this.bbs_idx = bbs_idx;
		this.user_idx = user_idx;
		this.comment_ref = comment_ref;
		this.comment_content = comment_content;
		this.comment_writedate = comment_writedate;
		this.comment_writer = comment_writer;
	}

	public int getBbs_idx() {
		return bbs_idx;
	}

	public void setBbs_idx(int bbs_idx) {
		this.bbs_idx = bbs_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getComment_ref() {
		return comment_ref;
	}

	public void setComment_ref(int comment_ref) {
		this.comment_ref = comment_ref;
	}

	public String getComment_content() {
		return comment_content;
	}

	public void setComment_content(String comment_content) {
		this.comment_content = comment_content;
	}

	public Date getComment_writedate() {
		return comment_writedate;
	}

	public void setComment_writedate(Date comment_writedate) {
		this.comment_writedate = comment_writedate;
	}

	public String getComment_writer() {
		return comment_writer;
	}

	public void setComment_writer(String comment_writer) {
		this.comment_writer = comment_writer;
	}
}