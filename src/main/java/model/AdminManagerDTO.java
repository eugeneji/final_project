package more.adminManager.model;

import java.sql.Date;

public class AdminManagerDTO {

	//유저정보
	private int user_idx;
	private String user_name;
	private int user_sex;
	private String user_nickname;
	private String user_email;
	private String user_pwd;
	private String user_tel;
	private String user_img;
	private String user_grade;
	private Date user_joindate;
	private double user_x;
	private double user_y;
	private String user_addr;
	private String user_addr_detail;
	
	//모임정보
	private int meeting_m_idx;
	private int meeting_m_total;
	private String meeting_m_location;
	private String meeting_m_detail;
	private double meeting_m_x;
	private double meeting_m_y;
	private String meeting_m_subject;
	private String meeting_m_content;
	private String meeting_m_file;
	private Date meeting_m_writedate;
	
	//추후 유진이 게시판 정보 추가
	
	public AdminManagerDTO() {
		// TODO Auto-generated constructor stub
	}

	public AdminManagerDTO(int user_idx, String user_name, int user_sex, String user_nickname, String user_email,
			String user_pwd, String user_tel, String user_img, String user_grade, Date user_joindate, double user_x,
			double user_y, String user_addr, String user_addr_detail, int meeting_m_idx, int meeting_m_total,
			String meeting_m_location, String meeting_m_detail, double meeting_m_x, double meeting_m_y,
			String meeting_m_subject, String meeting_m_content, String meeting_m_file, Date meeting_m_writedate) {
		super();
		this.user_idx = user_idx;
		this.user_name = user_name;
		this.user_sex = user_sex;
		this.user_nickname = user_nickname;
		this.user_email = user_email;
		this.user_pwd = user_pwd;
		this.user_tel = user_tel;
		this.user_img = user_img;
		this.user_grade = user_grade;
		this.user_joindate = user_joindate;
		this.user_x = user_x;
		this.user_y = user_y;
		this.user_addr = user_addr;
		this.user_addr_detail = user_addr_detail;
		this.meeting_m_idx = meeting_m_idx;
		this.meeting_m_total = meeting_m_total;
		this.meeting_m_location = meeting_m_location;
		this.meeting_m_detail = meeting_m_detail;
		this.meeting_m_x = meeting_m_x;
		this.meeting_m_y = meeting_m_y;
		this.meeting_m_subject = meeting_m_subject;
		this.meeting_m_content = meeting_m_content;
		this.meeting_m_file = meeting_m_file;
		this.meeting_m_writedate = meeting_m_writedate;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
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

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public String getUser_pwd() {
		return user_pwd;
	}

	public void setUser_pwd(String user_pwd) {
		this.user_pwd = user_pwd;
	}

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}

	public String getUser_grade() {
		return user_grade;
	}

	public void setUser_grade(String user_grade) {
		this.user_grade = user_grade;
	}

	public Date getUser_joindate() {
		return user_joindate;
	}

	public void setUser_joindate(Date user_joindate) {
		this.user_joindate = user_joindate;
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

	public String getUser_addr_detail() {
		return user_addr_detail;
	}

	public void setUser_addr_detail(String user_addr_detail) {
		this.user_addr_detail = user_addr_detail;
	}

	public int getMeeting_m_idx() {
		return meeting_m_idx;
	}

	public void setMeeting_m_idx(int meeting_m_idx) {
		this.meeting_m_idx = meeting_m_idx;
	}

	public int getMeeting_m_total() {
		return meeting_m_total;
	}

	public void setMeeting_m_total(int meeting_m_total) {
		this.meeting_m_total = meeting_m_total;
	}

	public String getMeeting_m_location() {
		return meeting_m_location;
	}

	public void setMeeting_m_location(String meeting_m_location) {
		this.meeting_m_location = meeting_m_location;
	}

	public String getMeeting_m_detail() {
		return meeting_m_detail;
	}

	public void setMeeting_m_detail(String meeting_m_detail) {
		this.meeting_m_detail = meeting_m_detail;
	}

	public double getMeeting_m_x() {
		return meeting_m_x;
	}

	public void setMeeting_m_x(double meeting_m_x) {
		this.meeting_m_x = meeting_m_x;
	}

	public double getMeeting_m_y() {
		return meeting_m_y;
	}

	public void setMeeting_m_y(double meeting_m_y) {
		this.meeting_m_y = meeting_m_y;
	}

	public String getMeeting_m_subject() {
		return meeting_m_subject;
	}

	public void setMeeting_m_subject(String meeting_m_subject) {
		this.meeting_m_subject = meeting_m_subject;
	}

	public String getMeeting_m_content() {
		return meeting_m_content;
	}

	public void setMeeting_m_content(String meeting_m_content) {
		this.meeting_m_content = meeting_m_content;
	}

	public String getMeeting_m_file() {
		return meeting_m_file;
	}

	public void setMeeting_m_file(String meeting_m_file) {
		this.meeting_m_file = meeting_m_file;
	}

	public Date getMeeting_m_writedate() {
		return meeting_m_writedate;
	}

	public void setMeeting_m_writedate(Date meeting_m_writedate) {
		this.meeting_m_writedate = meeting_m_writedate;
	}
	
	
	
}
