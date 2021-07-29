package more.bbs.model;

import java.sql.*;

import com.fasterxml.jackson.annotation.JsonFormat;
public class BbsDTO {

	private int bbs_idx;
	private String bbs_category;
	private String bbs_kind;
	private int bbs_type;
	private String bbs_name;
	private int bbs_sex;
	private String bbs_img;
	private String bbs_nickname;
	private String bbs_subject;
	private String bbs_content;
	private int bbs_readnum;
	private String bbs_find;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone="Asia/Seoul")
	private Date bbs_writedate;
	private int comment_num;
	
	public BbsDTO() {
		super();
	}

	public BbsDTO(int bbs_idx, String bbs_category, String bbs_kind, int bbs_type, String bbs_name, int bbs_sex,
			String bbs_img, String bbs_nickname, String bbs_subject, String bbs_content, int bbs_readnum,
			String bbs_find, Date bbs_writedate, int comment_num) {
		super();
		this.bbs_idx = bbs_idx;
		this.bbs_category = bbs_category;
		this.bbs_kind = bbs_kind;
		this.bbs_type = bbs_type;
		this.bbs_name = bbs_name;
		this.bbs_sex = bbs_sex;
		this.bbs_img = bbs_img;
		this.bbs_nickname = bbs_nickname;
		this.bbs_subject = bbs_subject;
		this.bbs_content = bbs_content;
		this.bbs_readnum = bbs_readnum;
		this.bbs_find = bbs_find;
		this.bbs_writedate = bbs_writedate;
		this.comment_num = comment_num;
	}

	public int getBbs_idx() {
		return bbs_idx;
	}

	public void setBbs_idx(int bbs_idx) {
		this.bbs_idx = bbs_idx;
	}

	public String getBbs_category() {
		return bbs_category;
	}

	public void setBbs_category(String bbs_category) {
		this.bbs_category = bbs_category;
	}

	public String getBbs_kind() {
		return bbs_kind;
	}

	public void setBbs_kind(String bbs_kind) {
		this.bbs_kind = bbs_kind;
	}

	public int getBbs_type() {
		return bbs_type;
	}

	public void setBbs_type(int bbs_type) {
		this.bbs_type = bbs_type;
	}

	public String getBbs_name() {
		return bbs_name;
	}

	public void setBbs_name(String bbs_name) {
		this.bbs_name = bbs_name;
	}

	public int getBbs_sex() {
		return bbs_sex;
	}

	public void setBbs_sex(int bbs_sex) {
		this.bbs_sex = bbs_sex;
	}

	public String getBbs_img() {
		return bbs_img;
	}

	public void setBbs_img(String bbs_img) {
		this.bbs_img = bbs_img;
	}

	public String getBbs_nickname() {
		return bbs_nickname;
	}

	public void setBbs_nickname(String bbs_nickname) {
		this.bbs_nickname = bbs_nickname;
	}

	public String getBbs_subject() {
		return bbs_subject;
	}

	public void setBbs_subject(String bbs_subject) {
		this.bbs_subject = bbs_subject;
	}

	public String getBbs_content() {
		return bbs_content;
	}

	public void setBbs_content(String bbs_content) {
		this.bbs_content = bbs_content;
	}

	public int getBbs_readnum() {
		return bbs_readnum;
	}

	public void setBbs_readnum(int bbs_readnum) {
		this.bbs_readnum = bbs_readnum;
	}

	public String getBbs_find() {
		return bbs_find;
	}

	public void setBbs_find(String bbs_find) {
		this.bbs_find = bbs_find;
	}

	public Date getBbs_writedate() {
		return bbs_writedate;
	}

	public void setBbs_writedate(Date bbs_writedate) {
		this.bbs_writedate = bbs_writedate;
	}

	public int getComment_num() {
		return comment_num;
	}

	public void setComment_num(int comment_num) {
		this.comment_num = comment_num;
	}
	
	
	
	
}