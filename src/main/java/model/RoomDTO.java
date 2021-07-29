package more.chat.model;

import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class RoomDTO {

	private int room_idx;
	private int room_type;
	private int meeting_m_idx;
	private String room_name;
	private String user_idx;
	private String join_date;
	private String first_join;
	private String to_idx;
	private String img_name;
	private MultipartFile upload;
	private MultipartFile[] uploads;
	
	public RoomDTO() {
		super();
	}

	
	public int getMeeting_m_idx() {
		return meeting_m_idx;
	}


	public void setMeeting_m_idx(int meeting_m_idx) {
		this.meeting_m_idx = meeting_m_idx;
	}


	public int getRoom_idx() {
		return room_idx;
	}

	public void setRoom_idx(int room_idx) {
		this.room_idx = room_idx;
	}

	public int getRoom_type() {
		return room_type;
	}

	public void setRoom_type(int room_type) {
		this.room_type = room_type;
	}

	public String getRoom_name() {
		return room_name;
	}

	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}

	public String getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(String user_idx) {
		this.user_idx = user_idx;
	}

	public String getJoin_date() {
		return join_date;
	}

	public void setJoin_date(String join_date) {
		this.join_date = join_date;
	}

	public String getTo_idx() {
		return to_idx;
	}

	public void setTo_idx(String to_idx) {
		this.to_idx = to_idx;
	}

	public String getFirst_join() {
		return first_join;
	}

	public void setFirst_join(String first_join) {
		this.first_join = first_join;
	}

	
	public String getImg_name() {
		return img_name;
	}


	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}


	public MultipartFile getUpload() {
		return upload;
	}


	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}


	public MultipartFile[] getUploads() {
		return uploads;
	}


	public void setUploads(MultipartFile[] uploads) {
		this.uploads = uploads;
	}


	@Override
	public String toString() {
		return "RoomDTO [room_idx=" + room_idx + ", room_type=" + room_type + ", meeting_m_idx=" + meeting_m_idx
				+ ", room_name=" + room_name + ", user_idx=" + user_idx + ", join_date=" + join_date + ", first_join="
				+ first_join + ", to_idx=" + to_idx + ", img_name=" + img_name + ", upload=" + upload + ", uploads="
				+ Arrays.toString(uploads) + "]";
	}


}
	
	