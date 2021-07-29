package more.chart.model;

public class bestUserChartDTO {
	
	private String bestBuyUser;
	private int bestBuyCount;
	private String bestPayUser;
	private int bestPay;
	public bestUserChartDTO() {
		super();
	}
	public bestUserChartDTO(String bestBuyUser, int bestBuyCount, String bestPayUser, int bestPay) {
		super();
		this.bestBuyUser = bestBuyUser;
		this.bestBuyCount = bestBuyCount;
		this.bestPayUser = bestPayUser;
		this.bestPay = bestPay;
	}
	public String getBestBuyUser() {
		return bestBuyUser;
	}
	public void setBestBuyUser(String bestBuyUser) {
		this.bestBuyUser = bestBuyUser;
	}
	public int getBestBuyCount() {
		return bestBuyCount;
	}
	public void setBestBuyCount(int bestBuyCount) {
		this.bestBuyCount = bestBuyCount;
	}
	public String getBestPayUser() {
		return bestPayUser;
	}
	public void setBestPayUser(String bestPayUser) {
		this.bestPayUser = bestPayUser;
	}
	public int getBestPay() {
		return bestPay;
	}
	public void setBestPay(int bestPay) {
		this.bestPay = bestPay;
	}
	
	
}
