package online_voting;

public class Election {
	private String title,stDate,endDate;
	private int uid;

	public Election() {
		super();
	}

	public Election(String title, String stDate, String endDate, int uid) {
		super();
		this.title = title;
		this.stDate = stDate;
		this.endDate = endDate;
		this.uid = uid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getStDate() {
		return stDate;
	}

	public void setStDate(String stDate) {
		this.stDate = stDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public int getUid() {
		return uid;
	}

	public void setUname(int uid) {
		this.uid = uid;
	}



}
