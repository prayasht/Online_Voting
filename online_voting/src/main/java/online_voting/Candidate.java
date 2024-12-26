package online_voting;
public class Candidate{
	private String name,electionId,count;
	private int id;
	public Candidate(String name, String electionId, String count, int id) {
		super();
		this.name = name;
		this.electionId = electionId;
		this.count = count;
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getElectionId() {
		return electionId;
	}
	public void setElectionId(String electionId) {
		this.electionId = electionId;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Candidate(String name, int id) {
		super();
		this.name = name;
		this.id = id;
	}
	public Candidate() {
		super();
	}
	
		
}