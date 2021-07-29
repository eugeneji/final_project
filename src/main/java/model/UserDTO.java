package more.user.model;

import java.sql.*;

public class UserDTO {

	int user_idx;
	String user_name;
	int user_sex;
	String user_nickname;
	String user_email;
	String user_pwd;
	String user_tel;
	String user_img;
	String user_grade;
	Date user_joindate;
	double user_x;
	double user_y;
	String user_addr;
	String user_addr_detail;
	public UserDTO() {
		super();
	}
	public UserDTO(int user_idx, String user_name, int user_sex, String user_nickname, String user_email,
			String user_pwd, String user_tel, String user_img, String user_grade, Date user_joindate, double user_x,
			double user_y, String user_addr, String user_addr_detail) {
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
}