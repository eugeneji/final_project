package more.cate.model;

public class cateDTO {
//	cate_code	VARCHAR(20)	NOT NULL,
//	cate_name	VARCHAR2(30)	NOT NULL,
//	cate_parent VARCHAR2(20)
	private String cate_code;
	private String cate_name;
	private String cate_parent;
	private int level;
	public cateDTO() {
		super();
	}
	public cateDTO(String cate_name, String cate_code, String cate_parent, int level) {
		super();
		this.cate_name = cate_name;
		this.cate_code = cate_code;
		this.cate_parent = cate_parent;
		this.level = level;
	}
	
	public String getCate_name() {
		return cate_name;
	}
	public void setCate_name(String cate_name) {
		this.cate_name = cate_name;
	}
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	public String getCate_parent() {
		return cate_parent;
	}
	public void setCate_parent(String cate_parent) {
		this.cate_parent = cate_parent;
	}
	public int getLevel() {
		return level;
	}
	public void setLevel(int level) {
		this.level = level;
	}
	
}
