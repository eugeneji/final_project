package more.shopreview.model;

import java.util.Map;

public class itemReviewListDTO {
	private String user_name;
	private String user_email;
	private int review_idx;
	private int user_idx;
	private int star_score;
	private String review_content;
	private String review_date;
	private String imgs;
	public itemReviewListDTO(String user_name, String user_email, int review_idx, int user_idx, int star_score,
			String review_content, String review_date, String imgs) {
		super();
		this.user_name = user_name;
		this.user_email = user_email;
		this.review_idx = review_idx;
		this.user_idx = user_idx;
		this.star_score = star_score;
		this.review_content = review_content;
		this.review_date = review_date;
		this.imgs = imgs;
	}
	public itemReviewListDTO() {
		super();
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
	public int getReview_idx() {
		return review_idx;
	}
	public void setReview_idx(int review_idx) {
		this.review_idx = review_idx;
	}
	public int getUser_idx() {
		return user_idx;
	}
	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}
	public int getStar_score() {
		return star_score;
	}
	public void setStar_score(int star_score) {
		this.star_score = star_score;
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
	public String getImgs() {
		return imgs;
	}
	public void setImgs(String imgs) {
		this.imgs = imgs;
	}
	
	
}
