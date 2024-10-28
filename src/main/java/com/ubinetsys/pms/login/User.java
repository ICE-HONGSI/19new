package com.ubinetsys.pms.login;

public class User {
	private String Uuid;
	private String LocNo;
	private String UName;
	private String Ulevel;
	private String Gname;
	private double locX;
	private double locY;

	public double getLocX() {
		return locX;
	}

	public void setLocX(double locX) {
		this.locX = locX;
	}

	public double getLocY() {
		return locY;
	}

	public void setLocY(double locY) {
		this.locY = locY;
	}

	public String getGname() {
		return Gname;
	}

	public void setGname(String gname) {
		Gname = gname;
	}

	public String getUuid() {
		return Uuid;
	}

	public void setUuid(String uuid) {
		Uuid = uuid;
	}

	public String getUlevel() {
		return Ulevel;
	}

	public void setUlevel(String ulevel) {
		Ulevel = ulevel;
	}

	public String getLocNo() {
		return LocNo;
	}

	public void setLocNo(String locNo) {
		LocNo = locNo;
	}

	public String getName() {
		return UName;
	}

	public void setName(String Uname) {
		UName = Uname;
	}
}
