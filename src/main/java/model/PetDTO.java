package more.pet.model;

import java.sql.Date;

public class PetDTO {
	private int pet_idx;
	private String pet_name;
	private String pet_type;
	private String pet_kind;
	private double pet_weight;
	private Date pet_birth;
	private String pet_sex;
	private String pet_neuter;
	
	public PetDTO() {
		// TODO Auto-generated constructor stub
	}

	public PetDTO(int pet_idx, String pet_name, String pet_type, String pet_kind, double pet_weight, Date pet_birth,
			String pet_sex, String pet_neuter) {
		super();
		this.pet_idx = pet_idx;
		this.pet_name = pet_name;
		this.pet_type = pet_type;
		this.pet_kind = pet_kind;
		this.pet_weight = pet_weight;
		this.pet_birth = pet_birth;
		this.pet_sex = pet_sex;
		this.pet_neuter = pet_neuter;
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

	public String getPet_type() {
		return pet_type;
	}

	public void setPet_type(String pet_type) {
		this.pet_type = pet_type;
	}

	public String getPet_kind() {
		return pet_kind;
	}

	public void setPet_kind(String pet_kind) {
		this.pet_kind = pet_kind;
	}

	public double getPet_weight() {
		return pet_weight;
	}

	public void setPet_weight(double pet_weight) {
		this.pet_weight = pet_weight;
	}

	public Date getPet_birth() {
		return pet_birth;
	}

	public void setPet_birth(Date pet_birth) {
		this.pet_birth = pet_birth;
	}

	public String getPet_sex() {
		return pet_sex;
	}

	public void setPet_sex(String pet_sex) {
		this.pet_sex = pet_sex;
	}

	public String getPet_neuter() {
		return pet_neuter;
	}

	public void setPet_neuter(String pet_neuter) {
		this.pet_neuter = pet_neuter;
	}

	
	
	
	
}
