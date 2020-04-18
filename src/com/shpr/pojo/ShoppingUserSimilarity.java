package com.shpr.pojo;

public class ShoppingUserSimilarity {
	
	private long user_id;
	private long user_ref_id;
	
	private double similarty;
	


	public long getUser_id() {
		return user_id;
	}



	public void setUser_id(long user_id) {
		this.user_id = user_id;
	}



	public long getUser_ref_id() {
		return user_ref_id;
	}



	public void setUser_ref_id(long user_ref_id) {
		this.user_ref_id = user_ref_id;
	}



	public double getSimilarty() {
		return similarty;
	}



	public void setSimilarty(double similarty) {
		this.similarty = similarty;
	}



	@Override
	public String toString() {
		return "ShoppingUserSimilarity [user_id=" + user_id + ", user_ref_id=" + user_ref_id + ", similarty="
				+ similarty + "]";
	}


	



	

}
