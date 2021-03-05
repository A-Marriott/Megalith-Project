const previewImageOnFileSelect = () => {
  const input = document.getElementById('photo-input');
  if (input) {
    input.addEventListener('change', () => {
      displayPreview(input);
    })
  }
}

const displayPreview = (input) => {
  if (input.files) {
    while (document.querySelector("#photo_upload_form > img") !== null) {
      document.querySelector("#photo_upload_form > img").remove();
    };
    let count = 0;
    for (const [key, value] of Object.entries(input.files)) {

      const reader = new FileReader();

      reader.onload = (event) => {
        document.getElementById('photo_upload_form').insertAdjacentHTML('beforeend', `<img src="" class="hidden" width="200" height="200">`);
        document.getElementById(`photo_upload_form`).children[document.getElementById(`photo_upload_form`).children.length - 1].src = event.currentTarget.result;
        document.getElementById(`photo_upload_form`).children[document.getElementById(`photo_upload_form`).children.length - 1].classList.remove('hidden');
      }
      reader.readAsDataURL(input.files[count])
      count += 1;
    }
  }
}



export { previewImageOnFileSelect };
