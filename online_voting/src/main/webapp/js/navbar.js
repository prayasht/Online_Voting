//Function to toggle account section visibility
function toggleSidebar() {
    const sidebar = document.querySelector('.sidebar');
    sidebar.classList.toggle('show');
    document.querySelector("section").style.zIndex=1;
}

function logout(link){
	return confirm("Are you sure to logout?");
}