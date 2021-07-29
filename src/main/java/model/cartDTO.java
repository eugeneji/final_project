package more.cart.model;

import java.sql.Date;

public class cartDTO {
	
	private int cart_idx;
	private int user_idx;
	private int item_idx;
	private int cart_unit;
	private String cart_date;
	public cartDTO() {
		super();
	}
	public cartDTO(int cart_idx, int user_idx, int item_idx, int cart_unit, String cart_date) {
		super();
		this.cart_idx = cart_idx;
		this.user_idx = user_idx;
		this.item_idx = item_idx;
		this.cart_unit = cart_unit;
		this.cart_date = cart_date;
	}
	public int getCart_idx() {
		return cart_idx;
	}
	public void setCart_idx(int cart_idx) {
		this.cart_idx = cart_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public int getCart_unit() {
		return cart_unit;
	}
	public void setCart_unit(int cart_unit) {
		this.cart_unit = cart_unit;
	}
	public String getCart_date() {
		return cart_date;
	}
	public void setCart_date(String cart_date) {
		this.cart_date = cart_date;
	}


	
}
