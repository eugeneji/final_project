package more.chat.model;

import java.util.Date;

import com.google.gson.Gson;

public class MessageDTO {
	
	private String message_type;
	private int message_idx;
	private String message_from;
	private String message_to;
	private String message_content;
	private String message_sendTime;
	private Date message_readTime;
	private String user_name;
	private String user_img;
	private String room_idx;
	private int unread;
	private String user_idx;
	private String room_name;
	private int room_type;
	public MessageDTO() {
		super();
	}

	
	public String getRoom_name() {
		return room_name;
	}


	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}


	public int getRoom_type() {
		return room_type;
	}


	public void setRoom_type(int room_type) {
		this.room_type = room_type;
	}


	public String getUser_idx() {
		return user_idx;
	}


	public void setUser_idx(String user_idx) {
		this.user_idx = user_idx;
	}


	public String getMessage_type() {
		return message_type;
	}

	public void setMessage_type(String message_type) {
		this.message_type = message_type;
	}

	public int getMessage_idx() {
		return message_idx;
	}

	public void setMessage_idx(int message_idx) {
		this.message_idx = message_idx;
	}

	public String getMessage_from() {
		return message_from;
	}

	public void setMessage_from(String message_from) {
		this.message_from = message_from;
	}

	public String getMessage_to() {
		return message_to;
	}

	public void setMessage_to(String message_to) {
		this.message_to = message_to;
	}

	public String getMessage_content() {
		return message_content;
	}

	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}

	public String getMessage_sendTime() {
		return message_sendTime;
	}

	public void setMessage_sendTime(String message_sendTime) {
		this.message_sendTime = message_sendTime;
	}

	public Date getMessage_readTime() {
		return message_readTime;
	}

	public void setMessage_readTime(Date message_readTime) {
		this.message_readTime = message_readTime;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}

	public String getRoom_idx() {
		return room_idx;
	}

	public void setRoom_idx(String room_idx) {
		this.room_idx = room_idx;
	}

	public int getUnread() {
		return unread;
	}

	public void setUnread(int unread) {
		this.unread = unread;
	}

	

	@Override
	public String toString() {
		return "MessageDTO [message_type=" + message_type + ", message_idx=" + message_idx + ", message_from="
				+ message_from + ", message_to=" + message_to + ", message_content=" + message_content
				+ ", message_sendTime=" + message_sendTime + ", message_readTime=" + message_readTime + ", user_name="
				+ user_name + ", user_img=" + user_img + ", room_idx=" + room_idx + ", unread=" + unread + ", user_idx="
				+ user_idx + ", room_name=" + room_name + ", room_type=" + room_type + "]";
	}


	public static MessageDTO convertMessage(String source) {
		
		MessageDTO message = new MessageDTO();
		Gson gson = new Gson();
		message = gson.fromJson(source,  MessageDTO.class);
		return message;
	}
	
}