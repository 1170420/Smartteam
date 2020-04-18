package com.shpr.pojo;
/*
 * »’÷æ±Ì
 */
public class Log {
	
	private int id;
	private String systime;
	private String sysname;
	private String sysip;
	private int sysport;
	private String sysusername;
	private String syshost;
	private String sysfunction;
	private String sysdata;

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getSystime() {
		return systime;
	}
	public void setSystime(String systime) {
		this.systime = systime;
	}
	public String getSysname() {
		return sysname;
	}
	public void setSysname(String sysname) {
		this.sysname = sysname;
	}
	public String getSysip() {
		return sysip;
	}
	public void setSysip(String sysip) {
		this.sysip = sysip;
	}
	public int getSysport() {
		return sysport;
	}
	public void setSysport(int sysport) {
		this.sysport = sysport;
	}
	public String getSysusername() {
		return sysusername;
	}
	public void setSysusername(String sysusername) {
		this.sysusername = sysusername;
	}
	public String getSyshost() {
		return syshost;
	}
	public void setSyshost(String syshost) {
		this.syshost = syshost;
	}
	public String getSysfunction() {
		return sysfunction;
	}
	public String getSysdata() {
		return sysdata;
	}
	public void setSysdata(String sysdata) {
		this.sysdata = sysdata;
	}
	public void setSysfunction(String sysfunction) {
		this.sysfunction = sysfunction;
	}
	@Override
	public String toString() {
		return "Log [id=" + id + ", systime=" + systime + ", sysname=" + sysname + ", sysip=" + sysip + ", sysport="
				+ sysport + ", sysusername=" + sysusername + ", syshost=" + syshost + ", sysfunction=" + sysfunction
				+ ", sysdata=" + sysdata + "]";
	}
}
