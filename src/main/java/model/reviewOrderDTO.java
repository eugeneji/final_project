package more.order.model;

public class reviewOrderDTO {

	private int item_idx;
	private String item_name;
	private String item_mainimg;
	private String cate_code;
	public reviewOrderDTO() {
		super();
	}
	public reviewOrderDTO(int item_idx, String item_name, String item_mainimg, String cate_code) {
		super();
		this.item_idx = item_idx;
		this.item_name = item_name;
		this.item_mainimg = item_mainimg;
		this.cate_code = cate_code;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_mainimg() {
		return item_mainimg;
	}
	public void setItem_mainimg(String item_mainimg) {
		this.item_mainimg = item_mainimg;
	}
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	
	
	
}
