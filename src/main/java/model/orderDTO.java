package more.order.model;

public class orderDTO {

	private int order_idx;
	private String user_name;
	private String user_email;
	private String user_addr;
	private String user_addr_detail;
	private String user_tel;
	private int user_totalpay;
	private String order_date;
	private String order_state;
	public orderDTO() {
		super();
	}
	public orderDTO(int order_idx, String user_name, String user_email, String user_addr, String user_addr_detail,
			String user_tel, int user_totalpay, String order_date, String order_state) {
		super();
		this.order_idx = order_idx;
		this.user_name = user_name;
		this.user_email = user_email;
		this.user_addr = user_addr;
		this.user_addr_detail = user_addr_detail;
		this.user_tel = user_tel;
		this.user_totalpay = user_totalpay;
		this.order_date = order_date;
		this.order_state = order_state;
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
	
	
}
