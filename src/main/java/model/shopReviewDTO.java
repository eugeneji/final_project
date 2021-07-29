package more.shopreview.model;

public class shopReviewDTO {
	//create sequence shop_review_idx
	private int review_idx;
	private int item_idx;
	private int user_idx;
	private String review_content;
	private String review_date;
	private int star_score;
	private String review_img;
	private String cate_code;
	public shopReviewDTO() {
		super();
	}
	public shopReviewDTO(int review_idx, int item_idx, int user_idx, String review_content, String review_date,
			int star_score, String review_img, String cate_code) {
		super();
		this.review_idx = review_idx;
		this.item_idx = item_idx;
		this.user_idx = user_idx;
		this.review_content = review_content;
		this.review_date = review_date;
		this.star_score = star_score;
		this.review_img = review_img;
		this.cate_code = cate_code;
	}
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getItem_idx() {
		return item_idx;
	}
	public void setItem_idx(int item_idx) {
		this.item_idx = item_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public String getReview_content() {
		return review_content;
	}
	public void setReview_content(String review_content) {
		this.review_content = review_content;
	}
	public String getReview_date() {
		return review_date;
	}
	public void setReview_date(String review_date) {
		this.review_date = review_date;
	}
	public int getStar_score() {
		return star_score;
	}
	public void setStar_score(int star_score) {
		this.star_score = star_score;
	}
	public String getReview_img() {
		return review_img;
	}
	public void setReview_img(String review_img) {
		this.review_img = review_img;
	}
	public String getCate_code() {
		return cate_code;
	}
	public void setCate_code(String cate_code) {
		this.cate_code = cate_code;
	}
	
	
	
	
}

//create table more_shop_review(
//    review_idx number(4) not null primary key,
//    item_idx number(4) not null,
//    user_idx number(4) not null,
//    review_content varchar2(3000) not null,
//    review_date date not null
//)