package more.eat.model;

import java.util.Date;

public class EatDTO {
	
	private int eat_idx;
	private int eat_pet_idx;
	private int eat_user_idx;
	private Date eat_time;
	private String eat_kind;
	private String eat_name;
	private String eat_amount;
	
	private String eat_user_name;
	
	public EatDTO() {
		// TODO Auto-generated constructor stub
	}

	public EatDTO(int eat_idx, int eat_pet_idx, int eat_user_idx, Date eat_time, String eat_kind, String eat_name,
			String eat_amount, String eat_user_name) {
		super();
		this.eat_idx = eat_idx;
		this.eat_pet_idx = eat_pet_idx;
		this.eat_user_idx = eat_user_idx;
		this.eat_time = eat_time;
		this.eat_kind = eat_kind;
		this.eat_name = eat_name;
		this.eat_amount = eat_amount;
		this.eat_user_name = eat_user_name;
	}

	public int getEat_idx() {
		return eat_idx;
	}

	public void setEat_idx(int eat_idx) {
		this.eat_idx = eat_idx;
	}

	public int getEat_pet_idx() {
		return eat_pet_idx;
	}

	public void setEat_pet_idx(int eat_pet_idx) {
		this.eat_pet_idx = eat_pet_idx;
	}

	public int getEat_user_idx() {
		return eat_user_idx;
	}

	public void setEat_user_idx(int eat_user_idx) {
		this.eat_user_idx = eat_user_idx;
	}

	public Date getEat_time() {
		return eat_time;
	}

	public void setEat_time(Date eat_time) {
		this.eat_time = eat_time;
	}

	public String getEat_kind() {
		return eat_kind;
	}

	public void setEat_kind(String eat_kind) {
		this.eat_kind = eat_kind;
	}

	public String getEat_name() {
		return eat_name;
	}

	public void setEat_name(String eat_name) {
		this.eat_name = eat_name;
	}

	public String getEat_amount() {
		return eat_amount;
	}

	public void setEat_amount(String eat_amount) {
		this.eat_amount = eat_amount;
	}

	public String getEat_user_name() {
		return eat_user_name;
	}

	public void setEat_user_name(String eat_user_name) {
		this.eat_user_name = eat_user_name;
	}
	
	
	
	
	
}
