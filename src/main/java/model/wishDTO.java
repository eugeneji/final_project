package more.cart.model;

public class wishDTO {
	private int item_idx;
	private String item_name;
	private String item_mainimg;
	private int item_price;
	public wishDTO() {
		super();
	}
	public wishDTO(int item_idx, String item_name, String item_mainimg, int item_price) {
		super();
		this.item_idx = item_idx;
		this.item_name = item_name;
		this.item_mainimg = item_mainimg;
		this.item_price = item_price;
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
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	
	
	
}
