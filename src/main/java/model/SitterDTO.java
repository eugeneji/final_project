package more.sitter.model;

import java.sql.*;
import java.util.Arrays;

import org.springframework.web.multipart.MultipartFile;

public class SitterDTO {
	
	private int user_idx;
	private int apply_idx;
	private int approval;
	private Date apply_date;
	private String subject;
	private String content;
	private String img;
	private String tag;
	private int pet;
	private int ss;
	private int sl;
	private int ms;
	private int ml;
	private int ls;
	private int ll;
	private int walkable;
	private String license;
	private String introduce;
	private String account;
	private String user_addr;
	private String user_addr_detail;
	private String user_name;
	private String user_img;
	private String user_tel;
	private String user_email;
	private Double user_x;
	private Double user_y;
	private int user_sex;
	private String star;
	private int avg;
	private MultipartFile upload;
	private MultipartFile[] uploads;
	private String pet_name;
	private String pet_sex;
	private Date pet_birth;
	
	public SitterDTO() {
		super();
	}

	public int getUser_idx() {
		return user_idx;
	}

	public void setUser_idx(int user_idx) {
		this.user_idx = user_idx;
	}

	public int getApply_idx() {
		return apply_idx;
	}

	public void setApply_idx(int apply_idx) {
		this.apply_idx = apply_idx;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public int getPet() {
		return pet;
	}

	public void setPet(int pet) {
		this.pet = pet;
	}

	public int getSs() {
		return ss;
	}

	public void setSs(int ss) {
		this.ss = ss;
	}

	public int getSl() {
		return sl;
	}

	public void setSl(int sl) {
		this.sl = sl;
	}

	public int getMs() {
		return ms;
	}

	public void setMs(int ms) {
		this.ms = ms;
	}

	public int getMl() {
		return ml;
	}

	public void setMl(int ml) {
		this.ml = ml;
	}

	public int getLs() {
		return ls;
	}

	public void setLs(int ls) {
		this.ls = ls;
	}

	public int getLl() {
		return ll;
	}

	public void setLl(int ll) {
		this.ll = ll;
	}

	public int getWalkable() {
		return walkable;
	}

	public void setWalkable(int walkable) {
		this.walkable = walkable;
	}

	public String getLicense() {
		return license;
	}

	public void setLicense(String license) {
		this.license = license;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	public String getAccount() {
		return account;
	}

	public void setAccount(String account) {
		this.account = account;
	}

	public String getUser_addr() {
		return user_addr;
	}

	public void setUser_addr(String user_addr) {
		this.user_addr = user_addr;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_img() {
		return user_img;
	}

	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}

	public String getStar() {
		return star;
	}

	public void setStar(String star) {
		this.star = star;
	}

	public int getAvg() {
		return avg;
	}

	public void setAvg(int avg) {
		this.avg = avg;
	}

	public MultipartFile getUpload() {
		return upload;
	}

	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}

	public String getPet_name() {
		return pet_name;
	}

	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}

	public String getPet_sex() {
		return pet_sex;
	}

	public void setPet_sex(String pet_sex) {
		this.pet_sex = pet_sex;
	}

	public Date getPet_birth() {
		return pet_birth;
	}

	public void setPet_birth(Date pet_birth) {
		this.pet_birth = pet_birth;
	}

	public Date getApply_date() {
		return apply_date;
	}

	public void setApply_date(Date apply_date) {
		this.apply_date = apply_date;
	}

	public int getApproval() {
		return approval;
	}

	public void setApproval(int approval) {
		this.approval = approval;
	}

	public String getUser_addr_detail() {
		return user_addr_detail;
	}

	public void setUser_addr_detail(String user_addr_detail) {
		this.user_addr_detail = user_addr_detail;
	}

	public String getUser_tel() {
		return user_tel;
	}

	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}

	public String getUser_email() {
		return user_email;
	}

	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}

	public int getUser_sex() {
		return user_sex;
	}

	public void setUser_sex(int user_sex) {
		this.user_sex = user_sex;
	}

	public MultipartFile[] getUploads() {
		return uploads;
	}

	public void setUploads(MultipartFile[] uploads) {
		this.uploads = uploads;
	}

	public Double getUser_x() {
		return user_x;
	}

	public void setUser_x(Double user_x) {
		this.user_x = user_x;
	}

	public Double getUser_y() {
		return user_y;
	}

	public void setUser_y(Double user_y) {
		this.user_y = user_y;
	}

	@Override
	public String toString() {
		return "SitterDTO [user_idx=" + user_idx + ", apply_idx=" + apply_idx + ", approval=" + approval
				+ ", apply_date=" + apply_date + ", subject=" + subject + ", content=" + content + ", img=" + img
				+ ", tag=" + tag + ", pet=" + pet + ", ss=" + ss + ", sl=" + sl + ", ms=" + ms + ", ml=" + ml + ", ls="
				+ ls + ", ll=" + ll + ", walkable=" + walkable + ", license=" + license + ", introduce=" + introduce
				+ ", account=" + account + ", user_addr=" + user_addr + ", user_addr_detail=" + user_addr_detail
				+ ", user_name=" + user_name + ", user_img=" + user_img + ", user_tel=" + user_tel + ", user_email="
				+ user_email + ", user_x=" + user_x + ", user_y=" + user_y + ", user_sex=" + user_sex + ", star=" + star
				+ ", avg=" + avg + ", upload=" + upload + ", uploads=" + Arrays.toString(uploads) + ", pet_name="
				+ pet_name + ", pet_sex=" + pet_sex + ", pet_birth=" + pet_birth + "]";
	}
	
}