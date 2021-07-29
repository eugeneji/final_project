package more.chart.model;

import java.sql.Date;

public class periodChartDTO {
	private String period;
	private int earn;
	private int dogSales;
	private int catSales;
	private int total;
	public periodChartDTO() {
		super();
	}
	public periodChartDTO(String period, int earn, int dogSales, int catSales, int total) {
		super();
		this.period = period;
		this.earn = earn;
		this.dogSales = dogSales;
		this.catSales = catSales;
		this.total = total;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public int getEarn() {
		return earn;
	}
	public void setEarn(int earn) {
		this.earn = earn;
	}
	public int getDogSales() {
		return dogSales;
	}
	public void setDogSales(int dogSales) {
		this.dogSales = dogSales;
	}
	public int getCatSales() {
		return catSales;
	}
	public void setCatSales(int catSales) {
		this.catSales = catSales;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	
}
