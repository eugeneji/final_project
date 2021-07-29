package more.review.model;

import java.util.*;

public interface ReviewDAO {
	
	public int insertReview(ReviewDTO dto);
	public List reviewList(int cp, int listN);
	public List sitterReview(int user_idx);
}
