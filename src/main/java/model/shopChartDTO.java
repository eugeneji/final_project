package more.chart.model;

public class shopChartDTO {

	private int item_idx;
	private String item_name;
	private int cate_code;
	private int item_price;
	private String item_regdate;
	private int total_in;
	private int total_incost;
	private int total_out;
	private int total_outcost;
	private int total_earn;
	private int likenum;
	private int total_order;
	public shopChartDTO() {
		super();
	}
	public shopChartDTO(int item_idx, String item_name, int cate_code, int item_price, String item_regdate,
			int total_in, int total_incost, int total_out, int total_outcost, int total_earn, int likenum,
			int total_order) {
		super();
		this.item_idx = item_idx;
		this.item_name = item_name;
		this.cate_code = cate_code;
		this.item_price = item_price;
		this.item_regdate = item_regdate;
		this.total_in = total_in;
		this.total_incost = total_incost;
		this.total_out = total_out;
		this.total_outcost = total_outcost;
		this.total_earn = total_earn;
		this.likenum = likenum;
		this.total_order = total_order;
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
	public int getCate_code() {
		return cate_code;
	}
	public void setCate_code(int cate_code) {
		this.cate_code = cate_code;
	}
	public int getItem_price() {
		return item_price;
	}
	public void setItem_price(int item_price) {
		this.item_price = item_price;
	}
	public String getItem_regdate() {
		return item_regdate;
	}
	public void setItem_regdate(String item_regdate) {
		this.item_regdate = item_regdate;
	}
	public int getTotal_in() {
		return total_in;
	}
	public void setTotal_in(int total_in) {
		this.total_in = total_in;
	}
	public int getTotal_incost() {
		return total_incost;
	}
	public void setTotal_incost(int total_incost) {
		this.total_incost = total_incost;
	}
	public int getTotal_out() {
		return total_out;
	}
	public void setTotal_out(int total_out) {
		this.total_out = total_out;
	}
	public int getTotal_outcost() {
		return total_outcost;
	}
	public void setTotal_outcost(int total_outcost) {
		this.total_outcost = total_outcost;
	}
	public int getTotal_earn() {
		return total_earn;
	}
	public void setTotal_earn(int total_earn) {
		this.total_earn = total_earn;
	}
	public int getLikenum() {
		return likenum;
	}
	public void setLikenum(int likenum) {
		this.likenum = likenum;
	}
	public int getTotal_order() {
		return total_order;
	}
	public void setTotal_order(int total_order) {
		this.total_order = total_order;
	}

	
	
}
