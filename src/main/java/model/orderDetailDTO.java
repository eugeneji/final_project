package more.order.model;

public class orderDetailDTO {
	
	private int detail_idx;
	private int order_idx;
	private int item_idx;
	private int detail_unit;
	public orderDetailDTO() {
		super();
	}
	public orderDetailDTO(int detail_idx, int order_idx, int item_idx, int detail_unit) {
		super();
		this.detail_idx = detail_idx;
		this.order_idx = order_idx;
		this.item_idx = item_idx;
		this.detail_unit = detail_unit;
	}
	public int getDetail_idx() {
		return detail_idx;
	}
	public void setDetail_idx(int detail_idx) {
		this.detail_idx = detail_idx;
	}
	public int getOrder_idx() {
		return order_idx;
	}
	public void setOrder_idx(int order_idx) {
		this.order_idx = order_idx;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public int getDetail_unit() {
		return detail_unit;
	}
	public void setDetail_unit(int detail_unit) {
		this.detail_unit = detail_unit;
	}
	
}
