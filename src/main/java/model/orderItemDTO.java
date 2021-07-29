package more.order.model;

public class orderItemDTO {

	private int item_idx;
	private String item_name;
	private int item_price;
	private int item_stock;
	private String item_mainimg;
	private String item_tf;
	private int order_idx;
	private int detail_idx;
	private int detail_unit;
	public orderItemDTO(int item_idx, String item_name, int item_price, int item_stock, String item_mainimg,
			String item_tf, int order_idx, int detail_idx, int detail_unit) {
		super();
		this.item_idx = item_idx;
		this.item_name = item_name;
		this.item_price = item_price;
		this.item_stock = item_stock;
		this.item_mainimg = item_mainimg;
		this.item_tf = item_tf;
		this.order_idx = order_idx;
		this.detail_idx = detail_idx;
		this.detail_unit = detail_unit;
	}
	public orderItemDTO() {
		super();
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
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public int getItem_stock() {
		return item_stock;
	}
	public void setItem_stock(int item_stock) {
		this.item_stock = item_stock;
	}
	public String getItem_mainimg() {
		return item_mainimg;
	}
	public void setItem_mainimg(String item_mainimg) {
		this.item_mainimg = item_mainimg;
	}
	public String getItem_tf() {
		return item_tf;
	}
	public void setItem_tf(String item_tf) {
		this.item_tf = item_tf;
	}
	public int getOrder_idx() {
		return order_idx;
	}
	public void setOrder_idx(int order_idx) {
		this.order_idx = order_idx;
	}
	public int getDetail_idx() {
		return detail_idx;
	}
	public void setDetail_idx(int detail_idx) {
		this.detail_idx = detail_idx;
	}
	public int getDetail_unit() {
		return detail_unit;
	}
	public void setDetail_unit(int detail_unit) {
		this.detail_unit = detail_unit;
	}


	
}
