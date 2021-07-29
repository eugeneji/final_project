package more.chart.model;

public class totalChartDTO {
	
	private String mostProduct;
	private int mostProductCount;
	private String bestProduct;
	private int bestProductEarn;
	private String leastProduct;
	private int leastProductCount;
	private String worstProduct;
	private int worstProductEarn;
	private String mostLikeProduct;
	private int mostLikeCount;
	public totalChartDTO() {
		super();
	}
	public totalChartDTO(String mostProduct, int mostProductCount, String bestProduct, int bestProductEarn,
			String leastProduct, int leastProductCount, String worstProduct, int worstProductEarn,
			String mostLikeProduct, int mostLikeCount) {
		super();
		this.mostProduct = mostProduct;
		this.mostProductCount = mostProductCount;
		this.bestProduct = bestProduct;
		this.bestProductEarn = bestProductEarn;
		this.leastProduct = leastProduct;
		this.leastProductCount = leastProductCount;
		this.worstProduct = worstProduct;
		this.worstProductEarn = worstProductEarn;
		this.mostLikeProduct = mostLikeProduct;
		this.mostLikeCount = mostLikeCount;
	}
	public String getMostProduct() {
		return mostProduct;
	}
	public void setMostProduct(String mostProduct) {
		this.mostProduct = mostProduct;
	}
	public int getMostProductCount() {
		return mostProductCount;
	}
	public void setMostProductCount(int mostProductCount) {
		this.mostProductCount = mostProductCount;
	}
	public String getBestProduct() {
		return bestProduct;
	}
	public void setBestProduct(String bestProduct) {
		this.bestProduct = bestProduct;
	}
	public int getBestProductEarn() {
		return bestProductEarn;
	}
	public void setBestProductEarn(int bestProductEarn) {
		this.bestProductEarn = bestProductEarn;
	}
	public String getLeastProduct() {
		return leastProduct;
	}
	public void setLeastProduct(String leastProduct) {
		this.leastProduct = leastProduct;
	}
	public int getLeastProductCount() {
		return leastProductCount;
	}
	public void setLeastProductCount(int leastProductCount) {
		this.leastProductCount = leastProductCount;
	}
	public String getWorstProduct() {
		return worstProduct;
	}
	public void setWorstProduct(String worstProduct) {
		this.worstProduct = worstProduct;
	}
	public int getWorstProductEarn() {
		return worstProductEarn;
	}
	public void setWorstProductEarn(int worstProductEarn) {
		this.worstProductEarn = worstProductEarn;
	}
	public String getMostLikeProduct() {
		return mostLikeProduct;
	}
	public void setMostLikeProduct(String mostLikeProduct) {
		this.mostLikeProduct = mostLikeProduct;
	}
	public int getMostLikeCount() {
		return mostLikeCount;
	}
	public void setMostLikeCount(int mostLikeCount) {
		this.mostLikeCount = mostLikeCount;
	}
	
	
}
