function toggleSettings() {
    document.querySelector(".settings-menu").classList.toggle("show");
}


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
