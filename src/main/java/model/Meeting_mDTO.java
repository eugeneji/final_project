package more.meeting_m.model;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Meeting_mDTO {

	private int meeting_m_idx;
	private int user_idx;
	private int meeting_m_total;
	private String meeting_m_location;
	private String meeting_m_detail;
	private Double meeting_m_x;
	private Double meeting_m_y;
	private String meeting_m_subject;
	private String meeting_m_content;
	private String meeting_m_file;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone="Asia/Seoul")
	private Date meeting_m_writedate;
	
	//user
	private int user_sex;
	private String user_nickname;
	private String user_img;
	private double user_x;
	private double user_y;
	private String user_addr;
	private String user_detail;
	
	//pet
	private int pet_idx;
	private String pet_name;
	private int pet_type;
	private String pet_kind;
	private String pet_birth;
	private int pet_sex;
	private int health_neuter;
	
	//meeting_j
	private int yes_or_no;
	
	//time
	private int day;
	private int hour;
	private int minute;
		
	//dec
	private int meeting_d_idx;
	private String meeting_d_content;
	private int meeting_d_ref;
	private int meeting_d_lev;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone="Asia/Seoul")
	private Date meeting_d_writedate;
	
	//chat
	private int room_idx;
	
	
	
	public Meeting_mDTO() {
		// TODO Auto-generated constructor stub
	}
	
	

	public Meeting_mDTO(int meeting_m_idx, int user_idx, int meeting_m_total, String meeting_m_location,
			String meeting_m_detail, Double meeting_m_x, Double meeting_m_y, String meeting_m_subject,
			String meeting_m_content, String meeting_m_file, Date meeting_m_writedate, int user_sex,
			String user_nickname, String user_img, double user_x, double user_y, String user_addr, String user_detail,
			int pet_idx, String pet_name, int pet_type, String pet_kind, String pet_birth, int pet_sex,
			int health_neuter, int yes_or_no, int day, int hour, int minute, int meeting_d_idx,
			String meeting_d_content, int meeting_d_ref, int meeting_d_lev, Date meeting_d_writedate, int room_idx) {
		super();
		this.meeting_m_idx = meeting_m_idx;
		this.user_idx = user_idx;
		this.meeting_m_total = meeting_m_total;
		this.meeting_m_location = meeting_m_location;
		this.meeting_m_detail = meeting_m_detail;
		this.meeting_m_x = meeting_m_x;
		this.meeting_m_y = meeting_m_y;
		this.meeting_m_subject = meeting_m_subject;
		this.meeting_m_content = meeting_m_content;
		this.meeting_m_file = meeting_m_file;
		this.meeting_m_writedate = meeting_m_writedate;
		this.user_sex = user_sex;
		this.user_nickname = user_nickname;
		this.user_img = user_img;
		this.user_x = user_x;
		this.user_y = user_y;
		this.user_addr = user_addr;
		this.user_detail = user_detail;
		this.pet_idx = pet_idx;
		this.pet_name = pet_name;
		this.pet_type = pet_type;
		this.pet_kind = pet_kind;
		this.pet_birth = pet_birth;
		this.pet_sex = pet_sex;
		this.health_neuter = health_neuter;
		this.yes_or_no = yes_or_no;
		this.day = day;
		this.hour = hour;
		this.minute = minute;
		this.meeting_d_idx = meeting_d_idx;
		this.meeting_d_content = meeting_d_content;
		this.meeting_d_ref = meeting_d_ref;
		this.meeting_d_lev = meeting_d_lev;
		this.meeting_d_writedate = meeting_d_writedate;
		this.room_idx = room_idx;
	}



	public int getMeeting_m_idx() {
		return meeting_m_idx;
	}
	public void setMeeting_m_idx(int meeting_m_idx) {
		this.meeting_m_idx = meeting_m_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
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
	public Double getMeeting_m_x() {
		return meeting_m_x;
	}
	public void setMeeting_m_x(Double meeting_m_x) {
		this.meeting_m_x = meeting_m_x;
	}
	public Double getMeeting_m_y() {
		return meeting_m_y;
	}
	public void setMeeting_m_y(Double meeting_m_y) {
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
	public int getPet_idx() {
		return pet_idx;
	}
	public void setPet_idx(int pet_idx) {
		this.pet_idx = pet_idx;
	}
	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}
	public int getPet_type() {
		return pet_type;
	}
	public void setPet_type(int pet_type) {
		this.pet_type = pet_type;
	}
	public String getPet_kind() {
		return pet_kind;
	}
	public void setPet_kind(String pet_kind) {
		this.pet_kind = pet_kind;
	}
	public String getPet_birth() {
		return pet_birth;
	}
	public void setPet_birth(String pet_birth) {
		this.pet_birth = pet_birth;
	}
	public int getPet_sex() {
		return pet_sex;
	}
	public void setPet_sex(int pet_sex) {
		this.pet_sex = pet_sex;
	}
	public int getHealth_neuter() {
		return health_neuter;
	}
	public void setHealth_neuter(int health_neuter) {
		this.health_neuter = health_neuter;
	}
	public int getYes_or_no() {
		return yes_or_no;
	}
	public void setYes_or_no(int yes_or_no) {
		this.yes_or_no = yes_or_no;
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
	public int getMeeting_d_idx() {
		return meeting_d_idx;
	}
	public void setMeeting_d_idx(int meeting_d_idx) {
		this.meeting_d_idx = meeting_d_idx;
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

	

	public int getRoom_idx() {
		return room_idx;
	}



	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}



	@Override
	public String toString() {
		return "Meeting_mDTO [meeting_m_idx=" + meeting_m_idx + ", user_idx=" + user_idx + ", meeting_m_total="
				+ meeting_m_total + ", meeting_m_location=" + meeting_m_location + ", meeting_m_detail="
				+ meeting_m_detail + ", meeting_m_x=" + meeting_m_x + ", meeting_m_y=" + meeting_m_y
				+ ", meeting_m_subject=" + meeting_m_subject + ", meeting_m_content=" + meeting_m_content
				+ ", meeting_m_file=" + meeting_m_file + ", meeting_m_writedate=" + meeting_m_writedate + ", user_sex="
				+ user_sex + ", user_nickname=" + user_nickname + ", user_img=" + user_img + ", user_x=" + user_x
				+ ", user_y=" + user_y + ", user_addr=" + user_addr + ", user_detail=" + user_detail + ", pet_idx="
				+ pet_idx + ", pet_name=" + pet_name + ", pet_type=" + pet_type + ", pet_kind=" + pet_kind
				+ ", pet_birth=" + pet_birth + ", pet_sex=" + pet_sex + ", health_neuter=" + health_neuter
				+ ", yes_or_no=" + yes_or_no + ", day=" + day + ", hour=" + hour + ", minute=" + minute
				+ ", meeting_d_idx=" + meeting_d_idx + ", meeting_d_content=" + meeting_d_content + ", meeting_d_ref="
				+ meeting_d_ref + ", meeting_d_lev=" + meeting_d_lev + ", meeting_d_writedate=" + meeting_d_writedate
				+ ", room_idx=" + room_idx + "]";
	}
	
	
	
					
}
