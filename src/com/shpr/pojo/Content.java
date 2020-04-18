package com.shpr.pojo;

/*
 * 系统需求管理
 */
public class Content {
	
	private int id;
	private String title;
	private String time;
	private String content;
	private String author;
	private String click;
	private int onclick;
	private int state;
	private Long category2_id;
	

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}


	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public String getAuthor() {
		return author;
	}


	public void setAuthor(String author) {
		this.author = author;
	}


	public String getClick() {
		return click;
	}


	public void setClick(String click) {
		this.click = click;
	}



	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOnclick() {
		return onclick;
	}

	public void setOnclick(int onclick) {
		this.onclick = onclick;
	}

	public int getState() {
		return state;
	}


	public void setState(int state) {
		this.state = state;
	}


	public Long getCategory2_id() {
		return category2_id;
	}


	public void setCategory2_id(Long category2_id) {
		this.category2_id = category2_id;
	}

	@Override
	public String toString() {
		return "Content [id=" + id + ", title=" + title + ", time=" + time + ", content=" + content + ", author="
				+ author + ", click=" + click + ", onclick=" + onclick + ", state=" + state + ", category2_id="
				+ category2_id + "]";
	}


	

}
