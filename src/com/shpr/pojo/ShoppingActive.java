package com.shpr.pojo;

public class ShoppingActive {
	
	//数据库int 实体类里面 long没关系的
	
	private Long user_id; //用户id
	private Long category2_id; //二级目录id
	private Long previewTotal; //二级目录点击量
	
	public Long getUser_id() {
		return user_id;
	}
	public void setUser_id(Long user_id) {
		this.user_id = user_id;
	}
	public Long getCategory2_id() {
		return category2_id;
	}
	public void setCategory2_id(Long category2_id) {
		this.category2_id = category2_id;
	}
	public Long getPreviewTotal() {
		return previewTotal;
	}
	public void setPreviewTotal(Long previewTotal) {
		this.previewTotal = previewTotal;
	}
	@Override
	public String toString() {
		return "ShoppingActive [user_id=" + user_id + ", category2_id=" + category2_id + ", previewTotal="
				+ previewTotal + "]";
	}
	
	

}
