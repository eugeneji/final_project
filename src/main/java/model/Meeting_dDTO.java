package more.meeting_d.model;

import java.sql.Date;

public class Meeting_dDTO {

	private int meeting_d_idx;
	private int user_idx;
	private String meeting_d_content;
	private int meeting_d_ref;
	private int meeting_d_lev;
	private Date meeting_d_writedate;
	
	//user
		private int user_sex;
		private String user_nickname;
		private String user_img;
		private double user_x;
		private double user_y;
		private String user_addr;
		private String user_detail;
		
	//dec count
	private int count;
	
	public Meeting_dDTO() {
		// TODO Auto-generated constructor stub
	}

	public Meeting_dDTO(int meeting_d_idx, int user_idx, String meeting_d_content, int meeting_d_ref,
			int meeting_d_lev, Date meeting_d_writedate, int user_sex, String user_nickname, String user_img,
			double user_x, double user_y, String user_addr, String user_detail, int count) {
		super();
		this.meeting_d_idx = meeting_d_idx;
		this.user_idx = user_idx;
		this.meeting_d_content = meeting_d_content;
		this.meeting_d_ref = meeting_d_ref;
		this.meeting_d_lev = meeting_d_lev;
		this.meeting_d_writedate = meeting_d_writedate;
		this.user_sex = user_sex;
		this.user_nickname = user_nickname;
		this.user_img = user_img;
		this.user_x = user_x;
		this.user_y = user_y;
		this.user_addr = user_addr;
		this.user_detail = user_detail;
		this.count = count;
	}

	public int getMeeting_d_idx() {
		return meeting_d_idx;
	}

	public void setMeeting_d_idx(int meeting_d_idx) {
		this.meeting_d_idx = meeting_d_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getMeeting_d_content() {
		return meeting_d_content;
	}

	public void setMeeting_d_content(String meeting_d_content) {
		this.meeting_d_content = meeting_d_content;
	}

	public int getMeeting_d_ref() {
		return meeting_d_ref;
	}

	public void setMeeting_d_ref(int meeting_d_ref) {
		this.meeting_d_ref = meeting_d_ref;
	}

	public int getMeeting_d_lev() {
		return meeting_d_lev;
	}

	public void setMeeting_d_lev(int meeting_d_lev) {
		this.meeting_d_lev = meeting_d_lev;
	}

	public Date getMeeting_d_writedate() {
		return meeting_d_writedate;
	}

	public void setMeeting_d_writedate(Date meeting_d_writedate) {
		this.meeting_d_writedate = meeting_d_writedate;
	}

	public int getUser_sex() {
		return user_sex;
	}

	public void setUser_sex(int user_sex) {
		this.user_sex = user_sex;
	}

	public String getUser_nickname() {
		return user_nickname;
	}

	public void setUser_nickname(String user_nickname) {
		this.user_nickname = user_nickname;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}

	public double getUser_x() {
		return user_x;
	}

	public void setUser_x(double user_x) {
		this.user_x = user_x;
	}

	public double getUser_y() {
		return user_y;
	}

	public void setUser_y(double user_y) {
		this.user_y = user_y;
	}

	public String getUser_addr() {
		return user_addr;
	}

	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	public String getUser_detail() {
		return user_detail;
	}

	public void setUser_detail(String user_detail) {
		this.user_detail = user_detail;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

			
}
