package more.shopitem.model;
import java.sql.*;
public class shopitemDTO {
//	item_idx	NUMBER(4)	NOT NULL,
//	item_name	VARCHAR2(50)	NOT NULL,
//	cate_code	VARCHAR(30)	NOT NULL,
//	item_price	NUMBER(8)	NOT NULL,
//	item_info	VARCHAR2(3000)	NOT NULL,
//	item_mainimg	VARCHAR2(200)	NULL,
//	item_imgdir	VARCHAR2(200)	NULL,
//	item_regid	VARCHAR2(50)	NOT NULL,
//	item_regdate	DATE	NOT NULL,
//    item_tf	VARCHAR2(1)	NOT NULL
	private int item_idx;
	private String item_name;
	private String cate_code;
	private int item_price;
	private String item_info;
	private String item_mainimg;
	private int item_stock;
	private String item_regid;
	private String item_regdate;
	private String item_tf;
	public shopitemDTO() {
		super();
	}
	public shopitemDTO(int item_idx, String item_name, String cate_code, int item_price, String item_info,
			String item_mainimg, int item_stock, String item_regid, String item_regdate, String item_tf) {
		super();
		this.item_idx = item_idx;
		this.item_name = item_name;
		this.cate_code = cate_code;
		this.item_price = item_price;
		this.item_info = item_info;
		this.item_mainimg = item_mainimg;
		this.item_stock = item_stock;
		this.item_regid = item_regid;
		this.item_regdate = item_regdate;
		this.item_tf = item_tf;
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
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public String getItem_info() {
		return item_info;
	}
	public void setItem_info(String item_info) {
		this.item_info = item_info;
	}
	public String getItem_mainimg() {
		return item_mainimg;
	}
	public void setItem_mainimg(String item_mainimg) {
		this.item_mainimg = item_mainimg;
	}
	public int getItem_stock() {
		return item_stock;
	}
	public void setItem_stock(int item_stock) {
		this.item_stock = item_stock;
	}
	public String getItem_regid() {
		return item_regid;
	}
	public void setItem_regid(String item_regid) {
		this.item_regid = item_regid;
	}
	public String getItem_regdate() {
		return item_regdate;
	}
	public void setItem_regdate(String item_regdate) {
		this.item_regdate = item_regdate;
	}
	public String getItem_tf() {
		return item_tf;
	}
	public void setItem_tf(String item_tf) {
		this.item_tf = item_tf;
	}


	
}