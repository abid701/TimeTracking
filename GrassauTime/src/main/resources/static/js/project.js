function toggleSettings() {
  document.querySelector(".settings-menu").classList.toggle("show");
}


// Open the modal
function openModal() {
  document.getElementById("projectModal").style.display = "flex";
}

// Close the modal
function closeModal() {
  document.getElementById("projectModal").style.display = "none";
}



document.addEventListener("DOMContentLoaded", function () {
    // Select all table cells that contain project statuses
    const statusCells = document.querySelectorAll(".status-column");

    statusCells.forEach(cell => {
        let statusText = cell.textContent.trim().toLowerCase(); // Get text content & clean it up

        // Remove any existing status classes (in case of updates)
        cell.classList.remove("ongoing", "completed", "paused");

        // Apply the relevant class based on the status
        if (statusText === "ongoing") {
            cell.classList.add("ongoing");
        } else if (statusText === "completed") {
            cell.classList.add("completed");
        } else if (statusText === "paused") {
            cell.classList.add("paused");
        }
    });
});

// new code

function toggleRemoveMode() {
    const deleteColumns = document.querySelectorAll(".delete-column");
    const deleteButtons = document.querySelectorAll(".delete-btn");
    const cancelBtn = document.getElementById("cancelDelete");
    const isActive = deleteColumns[0].style.display === "table-cell";

    if (isActive) {
        // Hide delete columns
        deleteColumns.forEach(function(col) {
            col.style.display = "none";
        });

        // Hide delete buttons
        deleteButtons.forEach(function(btn) {
            btn.style.display = "none";
        });

        // Hide cancel button
        cancelBtn.style.display = "none";
    } else {
        // Show delete columns
        deleteColumns.forEach(function(col) {
            col.style.display = "table-cell";
        });

        // Show delete buttons
        deleteButtons.forEach(function(btn) {
            btn.style.display = "inline-block";
        });

        // Show cancel button
        cancelBtn.style.display = "inline-block";
    }
}



