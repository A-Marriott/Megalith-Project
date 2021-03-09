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
    while (document.querySelector(".photo_insert > img") !== null) {
      document.querySelector(".photo_insert > img").remove();
    };
    let count = 0;
    for (const [key, value] of Object.entries(input.files)) {

      const reader = new FileReader();

      reader.onload = (event) => {
        document.querySelector('.photo_insert').insertAdjacentHTML('beforeend', `<img src="" class="hidden" width="100" height="100" style="margin-right: 10px; margin-bottom: 10px;">`);
        document.querySelector(`.photo_insert`).children[document.querySelector(`.photo_insert`).children.length - 1].src = event.currentTarget.result;
        document.querySelector(`.photo_insert`).children[document.querySelector(`.photo_insert`).children.length - 1].classList.remove('hidden');
      }
      reader.readAsDataURL(input.files[count])
      count += 1;
    }
  }
}



export { previewImageOnFileSelect };
