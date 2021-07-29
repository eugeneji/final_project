package more.stock.model;

import java.sql.Date;

public class stockDTO {
//	create table more_item_stock(
//		    item_idx number(4) not null,
//		    stock_type varchar2(40) not null,
//		    stock_unit number(5) not null,
//		    stock_unitcost number(5) not null,
//		    stock_cause varchar2(200) not null,
//		    stock_date date not null
//		)
	
	private int item_idx;
	private String stock_type;
	private int stock_unit;
	private int stock_unitcost;
	private String stock_cause;
	private String stock_date;
	public stockDTO() {
		super();
	}
	public stockDTO(int item_idx, String stock_type, int stock_unit, int stock_unitcost, String stock_cause,
			String stock_date) {
		super();
		this.item_idx = item_idx;
		this.stock_type = stock_type;
		this.stock_unit = stock_unit;
		this.stock_unitcost = stock_unitcost;
		this.stock_cause = stock_cause;
		this.stock_date = stock_date;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public String getStock_type() {
		return stock_type;
	}
	public void setStock_type(String stock_type) {
		this.stock_type = stock_type;
	}
	public int getStock_unit() {
		return stock_unit;
	}
	public void setStock_unit(int stock_unit) {
		this.stock_unit = stock_unit;
	}
	public int getStock_unitcost() {
		return stock_unitcost;
	}
	public void setStock_unitcost(int stock_unitcost) {
		this.stock_unitcost = stock_unitcost;
	}
	public String getStock_cause() {
		return stock_cause;
	}
	public void setStock_cause(String stock_cause) {
		this.stock_cause = stock_cause;
	}
	public String getStock_date() {
		return stock_date;
	}
	public void setStock_date(String stock_date) {
		this.stock_date = stock_date;
	}


	
	
}