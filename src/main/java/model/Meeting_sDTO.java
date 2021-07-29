package more.meeting_s.model;

import java.sql.Date;
import java.time.LocalDate;

import org.codehaus.jackson.map.ext.JodaDeserializers.LocalDateDeserializer;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonDeserialize;
import com.sun.istack.internal.NotNull;



public class Meeting_sDTO {

	//모임 테이블
	@NotNull
	private int meeting_s_idx;
	private int user_idx;
	private String meeting_s_content;
	private String meeting_s_img;
	
	@JsonFormat(pattern = "yyyy-MM-dd", timezone="Asia/Seoul")
	private Date meeting_s_writedate;
	private int meeting_s_num;
	//유저 테이블
	private String user_name;
	private int user_sex;
	private String user_nickname;
	private String user_img;
	private String user_grade;
	private Double user_x;
	private Double user_y;
	private String user_addr;
	private String user_addr_detail;
	
	//time
	private int day;
	private int hour;
	private int minute;
	
	//기본 생성자
	public Meeting_sDTO() {
		// TODO Auto-generated constructor stub
	}

	public Meeting_sDTO(int meeting_s_idx, int user_idx, String meeting_s_content, String meeting_s_img,
			Date meeting_s_writedate, int meeting_s_num, String user_name, int user_sex, String user_nickname,
			String user_img, String user_grade, Double user_x, Double user_y, String user_addr, String user_addr_detail,
			int day, int hour, int minute) {
		super();
		this.meeting_s_idx = meeting_s_idx;
		this.user_idx = user_idx;
		this.meeting_s_content = meeting_s_content;
		this.meeting_s_img = meeting_s_img;
		this.meeting_s_writedate = meeting_s_writedate;
		this.meeting_s_num = meeting_s_num;
		this.user_name = user_name;
		this.user_sex = user_sex;
		this.user_nickname = user_nickname;
		this.user_img = user_img;
		this.user_grade = user_grade;
		this.user_x = user_x;
		this.user_y = user_y;
		this.user_addr = user_addr;
		this.user_addr_detail = user_addr_detail;
		this.day = day;
		this.hour = hour;
		this.minute = minute;
	}

	
	
	public Meeting_sDTO(int meeting_s_idx, int user_idx, String user_nickname, String user_img, Double user_x,
			Double user_y, String meeting_s_content, String meeting_s_img,
			Date meeting_s_writedate, int meeting_s_num ) {
		super();
		this.meeting_s_idx = meeting_s_idx;
		this.user_idx = user_idx;
		this.user_nickname = user_nickname;
		this.user_img = user_img;
		this.user_x = user_x;
		this.user_y = user_y;
		this.meeting_s_content = meeting_s_content;
		this.meeting_s_img = meeting_s_img;
		this.meeting_s_writedate = meeting_s_writedate;
		this.meeting_s_num = meeting_s_num;
		
	}

	public int getMeeting_s_idx() {
		return meeting_s_idx;
	}

	public void setMeeting_s_idx(int meeting_s_idx) {
		this.meeting_s_idx = meeting_s_idx;
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public String getMeeting_s_content() {
		return meeting_s_content;
	}

	public void setMeeting_s_content(String meeting_s_content) {
		this.meeting_s_content = meeting_s_content;
	}

	public String getMeeting_s_img() {
		return meeting_s_img;
	}

	public void setMeeting_s_img(String meeting_s_img) {
		this.meeting_s_img = meeting_s_img;
	}

	public Date getMeeting_s_writedate() {
		return meeting_s_writedate;
	}

	public void setMeeting_s_writedate(Date meeting_s_writedate) {
		this.meeting_s_writedate = meeting_s_writedate;
	}

	public int getMeeting_s_num() {
		return meeting_s_num;
	}

	public void setMeeting_s_num(int meeting_s_num) {
		this.meeting_s_num = meeting_s_num;
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

	public Double getUser_x() {
		return user_x;
	}

	public void setUser_x(Double user_x) {
		this.user_x = user_x;
	}

	public Double getUser_y() {
		return user_y;
	}

	public void setUser_y(Double user_y) {
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

	public int getDay() {
		return day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getHour() {
		return hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public int getMinute() {
		return minute;
	}

	public void setMinute(int minute) {
		this.minute = minute;
	}

	
	
	}
