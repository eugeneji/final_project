package more.coupon.model;

public class couponDTO {
//	create table more_coupon(
//		      coupon_idx number not null primary key
//		    , coupon_name varchar2(100) not null
//		    , coupon_type varchar2(10) not null
//		    , coupon_amount number not null
//		)
//		create table more_user_coupon(
//		      user_idx number not null
//		    , coupon_idx number not null
//		    , coupon_date date not null
//		)
	
	private int coupon_idx;
	private String coupon_name;
	private String coupon_type; // 정액, 정률
	private int coupon_amount; // 정액일경우 원단위, 정률이면 %
	
	/*여긴 유저랑 쿠폰이랑*/
	private int user_idx;
	private String coupon_date; // 유효기간주기
	public couponDTO() {
		super();
	}
	public couponDTO(int coupon_idx, String coupon_name, String coupon_type, int coupon_amount, int user_idx,
			String coupon_date) {
		super();
		this.coupon_idx = coupon_idx;
		this.coupon_name = coupon_name;
		this.coupon_type = coupon_type;
		this.coupon_amount = coupon_amount;
		this.user_idx = user_idx;
		this.coupon_date = coupon_date;
	}
	public int getCoupon_idx() {
		return coupon_idx;
	}
	public void setCoupon_idx(int coupon_idx) {
		this.coupon_idx = coupon_idx;
	}
	public String getCoupon_name() {
		return coupon_name;
	}
	public void setCoupon_name(String coupon_name) {
		this.coupon_name = coupon_name;
	}
	public String getCoupon_type() {
		return coupon_type;
	}
	public void setCoupon_type(String coupon_type) {
		this.coupon_type = coupon_type;
	}
	public int getCoupon_amount() {
		return coupon_amount;
	}
	public void setCoupon_amount(int coupon_amount) {
		this.coupon_amount = coupon_amount;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getCoupon_date() {
		return coupon_date;
	}
	public void setCoupon_date(String coupon_date) {
		this.coupon_date = coupon_date;
	}
	
	
}
