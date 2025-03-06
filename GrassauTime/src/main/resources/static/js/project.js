function toggleSettings() {
    document.querySelector(".settings-menu").classList.toggle("show");
}

function openModal() {
    document.getElementById("projectModal").style.display = "flex";
}

function closeModal() {
    document.getElementById("projectModal").style.display = "none";
}

function addProject() {
    let name = document.getElementById("projectName").value;
    let client = document.getElementById("clientName").value;
    let start = document.getElementById("startDate").value;
    let end = document.getElementById("endDate").value;
    let status = document.getElementById("status").value;

    if (!name || !client || !start || !end) {
        alert("Please fill in all fields!");
        return;
    }

    let table = document.getElementById("projectTable");
    let row = table.insertRow(-1);
    row.classList.add("project-row");
    row.dataset.status = status;
    row.innerHTML = `<td>${name}</td><td>${client}</td><td>${start}</td><td>${end}</td><td><span class="status ${status}">${status.charAt(0).toUpperCase() + status.slice(1)}</span></td>`;

    closeModal();
}

function toggleRemoveMode() {
    let rows = document.querySelectorAll(".project-row");
    rows.forEach(row => {
        row.onclick = function() {
            let confirmDelete = confirm("Are you sure you want to delete this project?");
            if (confirmDelete) {
                this.remove();
            }
        };
    });
}
