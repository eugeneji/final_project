package more.chart.model;

public class areaChartDTO {

	public String area;
	public int totalpay;
	public int totalorder;
	public areaChartDTO() {
		super();
	}
	public areaChartDTO(String area, int totalpay, int totalorder) {
		super();
		this.area = area;
		this.totalpay = totalpay;
		this.totalorder = totalorder;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public int getTotalpay() {
		return totalpay;
	}
	public void setTotalpay(int totalpay) {
		this.totalpay = totalpay;
	}
	public int getTotalorder() {
		return totalorder;
	}
	public void setTotalorder(int totalorder) {
		this.totalorder = totalorder;
	}
	
	
	
}
