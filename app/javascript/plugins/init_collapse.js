const collapse = () => {
  const collapseBtn = document.getElementById( "view-more" );
    if (collapseBtn ) {
      collapseBtn.addEventListener("click", () => {
        if (collapseBtn.innerHTML === "View More") {
          collapseBtn.innerHTML = "View Less"
        } else {
          collapseBtn.innerHTML = "View More"
        }
      });
    }
  const collapseTripBtn = document.getElementById( "view+" );
    if (collapseTripBtn ) {
      collapseTripBtn.addEventListener("click", () => {
        if (collapseTripBtn.innerHTML === "View More") {
          collapseTripBtn.innerHTML = "View Less"
        } else {
          collapseTripBtn.innerHTML = "View More"
        }
      });
    }
}

export default collapse;
