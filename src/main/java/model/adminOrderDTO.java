package more.order.model;

public class adminOrderDTO {
	
	private int rnum;
	private int order_idx;
	private String user_name;
	private String user_email;
	private String user_addr;
	private String user_addr_detail;
	private String user_tel;
	private int user_totalpay;
	private String order_date;
	private String order_state;
	private int item_idx;
	private String item_name;
	private String item_mainimg;
	private int item_price;
	private int order_item_count;
	public adminOrderDTO() {
		super();
	}
	public adminOrderDTO(int rnum, int order_idx, String user_name, String user_email, String user_addr,
			String user_addr_detail, String user_tel, int user_totalpay, String order_date, String order_state,
			int item_idx, String item_name, String item_mainimg, int item_price, int order_item_count) {
		super();
		this.rnum = rnum;
		this.order_idx = order_idx;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_addr = user_addr;
		this.user_addr_detail = user_addr_detail;
		this.user_tel = user_tel;
		this.user_totalpay = user_totalpay;
		this.order_date = order_date;
		this.order_state = order_state;
		this.item_idx = item_idx;
		this.item_name = item_name;
		this.item_mainimg = item_mainimg;
		this.item_price = item_price;
		this.order_item_count = order_item_count;
	}
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getOrder_idx() {
		return order_idx;
	}
	public void setOrder_idx(int order_idx) {
		this.order_idx = order_idx;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_addr() {
		return user_addr;
	}
	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}
	public String getUser_addr_detail() {
		return user_addr_detail;
	}
	public void setUser_addr_detail(String user_addr_detail) {
		this.user_addr_detail = user_addr_detail;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public int getUser_totalpay() {
		return user_totalpay;
	}
	public void setUser_totalpay(int user_totalpay) {
		this.user_totalpay = user_totalpay;
	}
	public String getOrder_date() {
		return order_date;
	}
	public void setOrder_date(String order_date) {
		this.order_date = order_date;
	}
	public String getOrder_state() {
		return order_state;
	}
	public void setOrder_state(String order_state) {
		this.order_state = order_state;
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
	public int getOrder_item_count() {
		return order_item_count;
	}
	public void setOrder_item_count(int order_item_count) {
		this.order_item_count = order_item_count;
	}


	
	
}
