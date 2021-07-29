package more.cart.model;

import java.sql.Date;

public class showCartDTO {

		private int item_idx;
		private String item_name;
		private String item_mainimg;
		private int cart_idx;
		private int item_price;
		private int cart_unit;
		private String cart_date;
		public showCartDTO() {
			super();
		}
		public showCartDTO(int item_idx, String item_name, String item_mainimg, int cart_idx, int item_price,
				int cart_unit, String cart_date) {
			super();
			this.item_idx = item_idx;
			this.item_name = item_name;
			this.item_mainimg = item_mainimg;
			this.cart_idx = cart_idx;
			this.item_price = item_price;
			this.cart_unit = cart_unit;
			this.cart_date = cart_date;
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
		public String getItem_mainimg() {
			return item_mainimg;
		}
		public void setItem_mainimg(String item_mainimg) {
			this.item_mainimg = item_mainimg;
		}
		public int getCart_idx() {
			return cart_idx;
		}
		public void setCart_idx(int cart_idx) {
			this.cart_idx = cart_idx;
		}
		public int getItem_price() {
			return item_price;
		}
		public void setItem_price(int item_price) {
			this.item_price = item_price;
		}
		public int getCart_unit() {
			return cart_unit;
		}
		public void setCart_unit(int cart_unit) {
			this.cart_unit = cart_unit;
		}
		public String getCart_date() {
			return cart_date;
		}
		public void setCart_date(String cart_date) {
			this.cart_date = cart_date;
		}
		
		
}
