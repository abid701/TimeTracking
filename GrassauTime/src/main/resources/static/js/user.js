  function toggleSettings() {
      document.querySelector(".settings-menu").classList.toggle("show");
  }

// Open the modal
function openModal() {
    document.getElementById("userModal").style.display = "flex";
}

// Close the modal
function closeModal() {
    document.getElementById("userModal").style.display = "none";
}