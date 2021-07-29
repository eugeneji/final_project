package more.walk.model;

import java.util.Date;

public class WalkDTO {
	private int walk_idx;
	private int walk_user_idx;
	private int walk_pet_idx;
	private Date walk_startTime;
	private Date walk_endTime;
	private int walk_time;
	private int walk_distance;
	
	private String walk_user_name;
	
	
	public WalkDTO() {
		// TODO Auto-generated constructor stub
	}



	public WalkDTO(int walk_idx, int walk_user_idx, int walk_pet_idx, Date walk_startTime, Date walk_endTime,
			int walk_time, int walk_distance, String walk_user_name) {
		super();
		this.walk_idx = walk_idx;
		this.walk_user_idx = walk_user_idx;
		this.walk_pet_idx = walk_pet_idx;
		this.walk_startTime = walk_startTime;
		this.walk_endTime = walk_endTime;
		this.walk_time = walk_time;
		this.walk_distance = walk_distance;
		this.walk_user_name = walk_user_name;
	}





	public int getWalk_idx() {
		return walk_idx;
	}


	public void setWalk_idx(int walk_idx) {
		this.walk_idx = walk_idx;
	}


	public int getWalk_user_idx() {
		return walk_user_idx;
	}


	public void setWalk_user_idx(int walk_user_idx) {
		this.walk_user_idx = walk_user_idx;
	}


	public int getWalk_pet_idx() {
		return walk_pet_idx;
	}


	public void setWalk_pet_idx(int walk_pet_idx) {
		this.walk_pet_idx = walk_pet_idx;
	}


	public Date getWalk_startTime() {
		return walk_startTime;
	}


	public void setWalk_startTime(Date walk_startTime) {
		this.walk_startTime = walk_startTime;
	}


	public Date getWalk_endTime() {
		return walk_endTime;
	}


	public void setWalk_endTime(Date walk_endTime) {
		this.walk_endTime = walk_endTime;
	}


	public int getWalk_time() {
		return walk_time;
	}


	public void setWalk_time(int walk_time) {
		this.walk_time = walk_time;
	}


	public int getWalk_distance() {
		return walk_distance;
	}


	public void setWalk_distance(int walk_distance) {
		this.walk_distance = walk_distance;
	}


	public String getWalk_user_name() {
		return walk_user_name;
	}


	public void setWalk_user_name(String walk_user_name) {
		this.walk_user_name = walk_user_name;
	}
	
	
	
	
}
