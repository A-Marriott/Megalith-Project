const collapse = () => {
  const collapseBtn = document.getElementById( "view-more" );
    collapseBtn.addEventListener("click", () => {
      if (collapseBtn.innerHTML === "View More") {
        collapseBtn.innerHTML = "View Less"
      } else {
        collapseBtn.innerHTML = "View More"
      }
    });
}

export default collapse;
